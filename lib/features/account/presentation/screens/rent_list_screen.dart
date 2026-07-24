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
import '../../data/models/rent_invoice.dart';
import '../providers/account_providers.dart';

class RentListScreen extends ConsumerWidget {
  const RentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rentControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.rentTitle)),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(rentControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.rentEmpty,
          onLoadMore: () => ref.read(rentControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(rentControllerProvider.notifier).refresh(),
          itemBuilder: (context, invoice) => _RentCard(invoice: invoice),
        ),
      ),
    );
  }
}

class _RentCard extends StatelessWidget {
  const _RentCard({required this.invoice});

  final RentInvoice invoice;

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
                  Expanded(child: Text(invoice.invoiceNumber, style: const TextStyle(fontWeight: FontWeight.w600))),
                  StatusChip(label: invoice.status.label(context), color: invoice.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 4),
              Text(l10n.unitAndCompound(invoice.unitNumber, invoice.compoundName), style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.dueDate(Formatters.date(invoice.dueDate))),
                  Text(Formatters.currency(invoice.totalAmount), style: const TextStyle(fontWeight: FontWeight.bold)),
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
      builder: (context) => _RentDetailSheet(invoice: invoice),
    );
  }
}

class _RentDetailSheet extends StatelessWidget {
  const _RentDetailSheet({required this.invoice});

  final RentInvoice invoice;

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
            Text(invoice.invoiceNumber, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(l10n.rentPeriodUnit('${invoice.month}', '${invoice.year}', invoice.unitNumber)),
            const SizedBox(height: 16),
            _row(l10n.amountRent, invoice.rentAmount),
            _row(l10n.amountPreviousBalance, invoice.previousBalanceAmount),
            _row(l10n.amountLateFee, invoice.lateFeeAmount),
            _row(l10n.amountDiscount, -invoice.discountAmount),
            const Divider(height: 24),
            _row(l10n.amountTotal, invoice.totalAmount, bold: true),
            _row(l10n.amountPaid, invoice.paidAmount),
            _row(l10n.amountRemaining, invoice.remainingAmount, bold: true),
            if (invoice.notes != null && invoice.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(invoice.notes!),
            ],
            if (invoice.remainingAmount > 0) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.payment),
                label: Text(l10n.payAmount(Formatters.currency(invoice.remainingAmount))),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push(
                    Routes.startPayment,
                    extra: PaymentTarget(
                      type: PaymentTargetType.rentInvoice,
                      targetId: invoice.id,
                      amount: invoice.remainingAmount,
                      label: invoice.invoiceNumber,
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

  Widget _row(String label, double amount, {bool bold = false}) {
    final style = TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(Formatters.currency(amount), style: style),
        ],
      ),
    );
  }
}
