import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/payment.dart';
import '../providers/payments_provider.dart';

class PaymentsListScreen extends ConsumerWidget {
  const PaymentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paymentsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.paymentsTitle)),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(paymentsControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.paymentsEmpty,
          onLoadMore: () => ref.read(paymentsControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(paymentsControllerProvider.notifier).refresh(),
          itemBuilder: (context, payment) => _PaymentCard(payment: payment),
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({required this.payment});

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.paymentDetail(payment.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(payment.paymentReference, style: const TextStyle(fontWeight: FontWeight.w600))),
                  StatusChip(label: payment.status.label(context), color: payment.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 4),
              Text(l10n.paymentTypeAndMethod(payment.targetType.label(context), payment.paymentMethod.label(context)),
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Formatters.dateTime(payment.createdAt)),
                  Text(Formatters.currency(payment.amount), style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
