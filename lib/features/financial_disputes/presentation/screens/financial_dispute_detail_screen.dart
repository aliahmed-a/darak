import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/financial_dispute.dart';
import '../providers/financial_disputes_provider.dart';

class FinancialDisputeDetailScreen extends ConsumerWidget {
  const FinancialDisputeDetailScreen({super.key, required this.disputeId});

  final String disputeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dispute = ref.watch(financialDisputeDetailProvider(disputeId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.financialDisputeDetailTitle)),
      body: AsyncValueView(
        value: dispute,
        onRetry: () => ref.invalidate(financialDisputeDetailProvider(disputeId)),
        data: (context, data) => _DetailContent(dispute: data),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.dispute});

  final FinancialDispute dispute;

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
                    Expanded(
                      child: Text(l10n.financialDisputeTypeAndReference(dispute.targetType.label(context), dispute.targetReference),
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    StatusChip(label: dispute.status.label(context), color: dispute.status.color(scheme)),
                  ],
                ),
                if (dispute.targetAmount != null) ...[
                  const SizedBox(height: 4),
                  Text('${l10n.amountAmount} ${Formatters.currency(dispute.targetAmount!)}'),
                ],
                const SizedBox(height: 12),
                Text(dispute.reason, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(dispute.residentMessage),
                const SizedBox(height: 12),
                Text(l10n.financialDisputeSubmitted(Formatters.dateTime(dispute.createdAtUtc)),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
        if (dispute.adminDecisionNotes != null && dispute.adminDecisionNotes!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(l10n.financialDisputeManagementNotes, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(dispute.adminDecisionNotes!),
            ),
          ),
        ],
        if (dispute.resolutionSummary != null && dispute.resolutionSummary!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(l10n.financialDisputeResolution, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(dispute.resolutionSummary!),
            ),
          ),
        ],
      ],
    );
  }
}
