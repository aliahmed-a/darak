import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/violation_fine.dart';
import '../providers/account_providers.dart';

class ViolationFinesListScreen extends ConsumerWidget {
  const ViolationFinesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(violationFinesControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.violationFinesTitle)),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(violationFinesControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.violationFinesEmpty,
          onLoadMore: () => ref.read(violationFinesControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(violationFinesControllerProvider.notifier).refresh(),
          itemBuilder: (context, fine) => _FineCard(fine: fine),
        ),
      ),
    );
  }
}

class _FineCard extends StatelessWidget {
  const _FineCard({required this.fine});

  final ViolationFine fine;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.violationFineDetail(fine.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(fine.reason, style: const TextStyle(fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  StatusChip(label: fine.status.label(context), color: fine.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.dueDate(Formatters.date(fine.dueDate))),
                  Text(Formatters.currency(fine.amount), style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
