import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/financial_dispute.dart';
import '../providers/financial_disputes_provider.dart';

class FinancialDisputesListScreen extends ConsumerWidget {
  const FinancialDisputesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(financialDisputesControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.financialDisputesTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.createFinancialDispute),
        child: const Icon(Icons.add),
      ),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(financialDisputesControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.financialDisputesEmpty,
          onLoadMore: () => ref.read(financialDisputesControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(financialDisputesControllerProvider.notifier).refresh(),
          itemBuilder: (context, dispute) => _DisputeCard(dispute: dispute),
        ),
      ),
    );
  }
}

class _DisputeCard extends StatelessWidget {
  const _DisputeCard({required this.dispute});

  final FinancialDispute dispute;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.financialDisputeDetail(dispute.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(l10n.financialDisputeTypeAndReference(dispute.targetType.label(context), dispute.targetReference),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  StatusChip(label: dispute.status.label(context), color: dispute.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 4),
              Text(dispute.reason, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Text(Formatters.date(dispute.createdAtUtc), style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
