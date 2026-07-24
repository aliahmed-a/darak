import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/payment_target.dart';
import '../../../../core/models/payment_target_type.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/installment_schedule_item.dart';
import '../providers/account_providers.dart';

class InstallmentsListScreen extends ConsumerWidget {
  const InstallmentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(installmentsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.installmentsTitle)),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(installmentsControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.installmentsEmpty,
          onLoadMore: () => ref.read(installmentsControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(installmentsControllerProvider.notifier).refresh(),
          itemBuilder: (context, item) => _InstallmentCard(item: item),
        ),
      ),
    );
  }
}

class _InstallmentCard extends StatelessWidget {
  const _InstallmentCard({required this.item});

  final InstallmentScheduleItem item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showDetail(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.installmentNumber('${item.installmentNumber}'), style: const TextStyle(fontWeight: FontWeight.w600)),
                  StatusChip(label: item.status.label(context), color: item.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 4),
              Text(l10n.unitAndCompound(item.unitNumber, item.compoundName), style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.dueDate(Formatters.date(item.dueDate))),
                  Text(Formatters.currency(item.amount), style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _InstallmentDetailSheet(item: item),
    );
  }
}

class _InstallmentDetailSheet extends StatelessWidget {
  const _InstallmentDetailSheet({required this.item});

  final InstallmentScheduleItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.installmentNumber('${item.installmentNumber}'), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(l10n.unitAndCompound(item.unitNumber, item.compoundName)),
            const SizedBox(height: 16),
            _row(l10n.amountAmount, item.amount),
            _row(l10n.amountPaid, item.paidAmount),
            _row(l10n.amountRemaining, item.remainingAmount, bold: true),
            _row(l10n.fieldDueDate, 0, dateOverride: item.dueDate),
            if (item.remainingAmount > 0) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.payment),
                label: Text(l10n.payAmount(Formatters.currency(item.remainingAmount))),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push(
                    Routes.startPayment,
                    extra: PaymentTarget(
                      type: PaymentTargetType.propertyInstallment,
                      targetId: item.id,
                      amount: item.remainingAmount,
                      label: l10n.installmentNumber('${item.installmentNumber}'),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(String label, double amount, {bool bold = false, DateTime? dateOverride}) {
    final style = TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(dateOverride != null ? Formatters.date(dateOverride) : Formatters.currency(amount), style: style),
        ],
      ),
    );
  }
}
