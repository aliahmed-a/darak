import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/payment_target.dart';
import '../../../../core/models/payment_target_type.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/utility_bill.dart';
import '../providers/account_providers.dart';

class BillDetailScreen extends ConsumerWidget {
  const BillDetailScreen({super.key, required this.billId});

  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bill = ref.watch(billDetailProvider(billId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.billDetailTitle)),
      body: AsyncValueView(
        value: bill,
        onRetry: () => ref.invalidate(billDetailProvider(billId)),
        data: (context, data) => _BillDetailContent(bill: data),
      ),
      bottomNavigationBar: bill.valueOrNull != null && bill.value!.remainingAmount > 0
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.payment),
                  label: Text(l10n.payAmount(Formatters.currency(bill.value!.remainingAmount))),
                  onPressed: () => context.push(
                    Routes.startPayment,
                    extra: PaymentTarget(
                      type: PaymentTargetType.utilityBill,
                      targetId: bill.value!.id,
                      amount: bill.value!.remainingAmount,
                      label: bill.value!.billNumber,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}

class _BillDetailContent extends StatelessWidget {
  const _BillDetailContent({required this.bill});

  final UtilityBill bill;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(bill.billNumber, style: Theme.of(context).textTheme.titleMedium),
                    StatusChip(label: bill.status.label(context), color: bill.status.color(scheme)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(l10n.unitAndCompound(bill.unitNumber, bill.compoundName)),
                const SizedBox(height: 4),
                Text(l10n.billingCycle('${bill.billingCycleMonth}', '${bill.billingCycleYear}')),
                const SizedBox(height: 4),
                Text(l10n.issuedAndDue(Formatters.date(bill.issueDate), Formatters.date(bill.dueDate))),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _AmountRow(l10n.amountSubtotal, bill.subtotalAmount),
                _AmountRow(l10n.amountPreviousBalance, bill.previousBalanceAmount),
                _AmountRow(l10n.amountLateFee, bill.lateFeeAmount),
                _AmountRow(l10n.amountDiscount, -bill.discountAmount),
                const Divider(height: 24),
                _AmountRow(l10n.amountTotal, bill.totalAmount, bold: true),
                _AmountRow(l10n.amountPaid, bill.paidAmount),
                _AmountRow(l10n.amountRemaining, bill.remainingAmount, bold: true),
              ],
            ),
          ),
        ),
        if (bill.lines.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(l10n.lineItems, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: bill.lines
                  .map((line) => ListTile(
                        title: Text(line.compoundServiceName),
                        subtitle: Text(l10n.lineItemDetail(
                            line.description, '${line.quantity}', Formatters.currency(line.unitPrice))),
                        trailing: Text(Formatters.currency(line.lineTotal)),
                      ))
                  .toList(growable: false),
            ),
          ),
        ],
        if (bill.notes != null && bill.notes!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(l10n.notes, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(bill.notes!),
        ],
      ],
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow(this.label, this.amount, {this.bold = false});

  final String label;
  final double amount;
  final bool bold;

  @override
  Widget build(BuildContext context) {
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
