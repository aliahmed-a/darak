import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/visitor_pass.dart';
import '../providers/visitor_passes_provider.dart';

class VisitorPassDetailScreen extends ConsumerStatefulWidget {
  const VisitorPassDetailScreen({super.key, required this.passId});

  final String passId;

  @override
  ConsumerState<VisitorPassDetailScreen> createState() => _VisitorPassDetailScreenState();
}

class _VisitorPassDetailScreenState extends ConsumerState<VisitorPassDetailScreen> {
  bool _isCancelling = false;

  Future<void> _cancel() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.visitorPassCancelConfirmTitle),
        content: Text(l10n.visitorPassCancelConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.commonBack)),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: Text(l10n.visitorPassCancelPass)),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _isCancelling = true);
    try {
      await ref.read(visitorPassesApiProvider).cancel(widget.passId);
      ref.invalidate(visitorPassDetailProvider(widget.passId));
      ref.invalidate(visitorPassesControllerProvider);
    } on ApiException catch (e) {
      if (!mounted) return;
      showErrorSnack(context, e.message);
    } finally {
      if (mounted) setState(() => _isCancelling = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pass = ref.watch(visitorPassDetailProvider(widget.passId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.visitorPassDetailTitle)),
      body: AsyncValueView(
        value: pass,
        onRetry: () => ref.invalidate(visitorPassDetailProvider(widget.passId)),
        data: (context, data) => _DetailContent(pass: data),
      ),
      bottomNavigationBar: pass.valueOrNull != null && pass.value!.status.canCancel
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: OutlinedButton(
                  onPressed: _isCancelling ? null : _cancel,
                  child: Text(l10n.visitorPassCancelPass),
                ),
              ),
            )
          : null,
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.pass});

  final VisitorPass pass;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(l10n.visitorPassAccessCode, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text(
                  pass.accessCode,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 4),
                ),
                if (pass.accessCode.contains('*')) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.visitorPassAccessCodeNotice,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                const SizedBox(height: 12),
                StatusChip(label: pass.status.label(context), color: pass.status.color(scheme)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pass.visitorName, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(pass.visitorPhoneNumber),
                const SizedBox(height: 8),
                Text(pass.visitReason),
                const SizedBox(height: 12),
                Text(l10n.validDateRange(Formatters.dateTime(pass.validFrom), Formatters.dateTime(pass.validUntil))),
                if (pass.checkedInAt != null) Text(l10n.visitorPassCheckedIn(Formatters.dateTime(pass.checkedInAt!))),
                if (pass.checkedOutAt != null) Text(l10n.visitorPassCheckedOut(Formatters.dateTime(pass.checkedOutAt!))),
                if (pass.denialReason != null) ...[
                  const SizedBox(height: 8),
                  Text(pass.denialReason!, style: TextStyle(color: scheme.error)),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
