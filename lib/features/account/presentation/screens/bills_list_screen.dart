import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/utility_bill.dart';
import '../providers/account_providers.dart';

class BillsListScreen extends ConsumerWidget {
  const BillsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.billsTitle)),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(billsControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.billsEmpty,
          onLoadMore: () => ref.read(billsControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(billsControllerProvider.notifier).refresh(),
          itemBuilder: (context, bill) => _BillCard(bill: bill),
        ),
      ),
    );
  }
}

class _BillCard extends StatelessWidget {
  const _BillCard({required this.bill});

  final UtilityBill bill;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.billDetail(bill.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(bill.billNumber, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  StatusChip(label: bill.status.label(context), color: bill.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 4),
              Text(l10n.unitAndCompound(bill.unitNumber, bill.compoundName), style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.dueDate(Formatters.date(bill.dueDate))),
                  Text(Formatters.currency(bill.totalAmount), style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
