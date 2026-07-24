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
import '../../../violation_appeals/data/models/violation_appeal_target.dart';
import '../../data/models/violation_fine.dart';
import '../../data/models/violation_fine_status.dart';
import '../providers/account_providers.dart';

class ViolationFineDetailScreen extends ConsumerWidget {
  const ViolationFineDetailScreen({super.key, required this.fineId});

  final String fineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fine = ref.watch(violationFineDetailProvider(fineId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.violationFineDetailTitle)),
      body: AsyncValueView(
        value: fine,
        onRetry: () => ref.invalidate(violationFineDetailProvider(fineId)),
        data: (context, data) => _FineDetailContent(fine: data),
      ),
      bottomNavigationBar: fine.valueOrNull != null ? _FineActions(fine: fine.value!) : null,
    );
  }
}

class _FineActions extends StatelessWidget {
  const _FineActions({required this.fine});

  final ViolationFine fine;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final canAppeal = fine.status != ViolationFineStatus.cancelled;
    final canPay = fine.remainingAmount > 0 && fine.status != ViolationFineStatus.cancelled;

    if (!canAppeal && !canPay) return const SizedBox.shrink();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (canAppeal)
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.gavel_outlined),
                  label: Text(l10n.violationFineAppeal),
                  onPressed: () => context.push(
                    Routes.createViolationAppeal,
                    extra: ViolationAppealTarget(
                      violationId: fine.violationId,
                      violationFineId: fine.id,
                      label: fine.reason,
                      fineAmount: fine.amount,
                    ),
                  ),
                ),
              ),
            if (canAppeal && canPay) const SizedBox(width: 12),
            if (canPay)
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.payment),
                  label: Text(l10n.payAmount(Formatters.currency(fine.remainingAmount))),
                  onPressed: () => context.push(
                    Routes.startPayment,
                    extra: PaymentTarget(
                      type: PaymentTargetType.violationFine,
                      targetId: fine.id,
                      amount: fine.remainingAmount,
                      label: fine.reason,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FineDetailContent extends StatelessWidget {
  const _FineDetailContent({required this.fine});

  final ViolationFine fine;

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
                    Expanded(child: Text(fine.reason, style: Theme.of(context).textTheme.titleMedium)),
                    StatusChip(label: fine.status.label(context), color: fine.status.color(scheme)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(fine.compoundName),
                const SizedBox(height: 4),
                Text(l10n.dueDate(Formatters.date(fine.dueDate))),
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
                _AmountRow(l10n.amountAmount, fine.amount, bold: true),
                _AmountRow(l10n.amountPaid, fine.paidAmount),
                _AmountRow(l10n.amountRemaining, fine.remainingAmount, bold: true),
              ],
            ),
          ),
        ),
        if (fine.cancellationReason != null && fine.cancellationReason!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(l10n.violationFineCancellationReason, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(fine.cancellationReason!),
            ),
          ),
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
