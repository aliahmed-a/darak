import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/document_approval_status.dart';
import '../../data/models/document_file.dart';
import '../providers/documents_provider.dart';

class DocumentsListScreen extends ConsumerWidget {
  const DocumentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(documentsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.documentsTitle)),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(documentsControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.documentsEmpty,
          onLoadMore: () => ref.read(documentsControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(documentsControllerProvider.notifier).refresh(),
          itemBuilder: (context, document) => _DocumentCard(document: document),
        ),
      ),
    );
  }
}

class _DocumentCard extends ConsumerStatefulWidget {
  const _DocumentCard({required this.document});

  final DocumentFile document;

  @override
  ConsumerState<_DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends ConsumerState<_DocumentCard> {
  bool _isDownloading = false;

  IconData get _fileIcon {
    final extension = widget.document.extension.toLowerCase().replaceAll('.', '');
    if (extension == 'pdf') return Icons.picture_as_pdf_outlined;
    if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension)) return Icons.image_outlined;
    if (['doc', 'docx'].contains(extension)) return Icons.description_outlined;
    return Icons.insert_drive_file_outlined;
  }

  Future<void> _downloadAndOpen() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    final l10n = AppLocalizations.of(context)!;
    try {
      final bytes = await ref.read(documentsApiProvider).download(widget.document.id);
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/${widget.document.originalFileName}');
      await file.writeAsBytes(bytes, flush: true);

      final result = await OpenFilex.open(file.path);
      if (result.type != ResultType.done && mounted) {
        showErrorSnack(context, l10n.documentCouldNotOpen(result.message));
      }
    } on ApiException catch (e) {
      if (!mounted) return;
      showErrorSnack(context, e.message);
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final document = widget.document;
    final showStatusChip = document.approvalStatus != DocumentApprovalStatus.notRequired;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: _downloadAndOpen,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(child: Icon(_fileIcon)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            document.originalFileName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (showStatusChip) ...[
                          const SizedBox(width: 8),
                          StatusChip(label: document.approvalStatus.label(context), color: document.approvalStatus.color(scheme)),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.documentMeta(document.category.label(context), document.sizeLabel, Formatters.date(document.createdAtUtc)),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _isDownloading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.download_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
