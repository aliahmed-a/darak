import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/complaint.dart';
import '../providers/complaints_provider.dart';

class ComplaintsListScreen extends ConsumerWidget {
  const ComplaintsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(complaintsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.complaintsTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.createComplaint),
        child: const Icon(Icons.add),
      ),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(complaintsControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.complaintsEmpty,
          onLoadMore: () => ref.read(complaintsControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(complaintsControllerProvider.notifier).refresh(),
          itemBuilder: (context, complaint) => _ComplaintCard(complaint: complaint),
        ),
      ),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  const _ComplaintCard({required this.complaint});

  final Complaint complaint;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.complaintDetail(complaint.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(complaint.title, style: const TextStyle(fontWeight: FontWeight.w600))),
                  StatusChip(label: complaint.status.label(context), color: complaint.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 8),
              Text(Formatters.date(complaint.createdAt), style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
