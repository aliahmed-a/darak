import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/payment.dart';
import '../providers/payments_provider.dart';

class PaymentDetailScreen extends ConsumerWidget {
  const PaymentDetailScreen({super.key, required this.paymentId});

  final String paymentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payment = ref.watch(paymentDetailProvider(paymentId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.paymentDetailTitle)),
      body: AsyncValueView(
        value: payment,
        onRetry: () => ref.invalidate(paymentDetailProvider(paymentId)),
        data: (context, data) => _PaymentDetailContent(payment: data),
      ),
    );
  }
}

class _PaymentDetailContent extends StatelessWidget {
  const _PaymentDetailContent({required this.payment});

  final Payment payment;

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
                    Text(payment.paymentReference, style: Theme.of(context).textTheme.titleMedium),
                    StatusChip(label: payment.status.label(context), color: payment.status.color(scheme)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(Formatters.currency(payment.amount),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(l10n.paymentTypeAndMethod(payment.targetType.label(context), payment.paymentMethod.label(context))),
                const SizedBox(height: 4),
                Text(l10n.paymentCreated(Formatters.dateTime(payment.createdAt))),
                if (payment.completedAt != null) Text(l10n.paymentCompleted(Formatters.dateTime(payment.completedAt!))),
                if (payment.failureReason != null) ...[
                  const SizedBox(height: 8),
                  Text(payment.failureReason!, style: TextStyle(color: scheme.error)),
                ],
              ],
            ),
          ),
        ),
        if (payment.receipt != null) ...[
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_outlined),
              title: Text(payment.receipt!.receiptNumber),
              subtitle: Text(l10n.paymentIssued(Formatters.dateTime(payment.receipt!.issuedAt))),
              trailing: Text(Formatters.currency(payment.receipt!.amount)),
            ),
          ),
        ],
        if (payment.attempts.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(l10n.paymentAttempts, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: payment.attempts
                  .map((attempt) => ListTile(
                        title: Text(attempt.provider),
                        subtitle: Text(attempt.message ?? Formatters.dateTime(attempt.createdAt)),
                        trailing: StatusChip(label: attempt.status.label(context), color: attempt.status.color(scheme)),
                      ))
                  .toList(growable: false),
            ),
          ),
        ],
      ],
    );
  }
}
