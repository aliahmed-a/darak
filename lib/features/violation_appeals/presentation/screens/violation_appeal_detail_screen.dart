import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/violation_appeal.dart';
import '../providers/violation_appeals_provider.dart';

class ViolationAppealDetailScreen extends ConsumerWidget {
  const ViolationAppealDetailScreen({super.key, required this.appealId});

  final String appealId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appeal = ref.watch(violationAppealDetailProvider(appealId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.violationAppealDetailTitle)),
      body: AsyncValueView(
        value: appeal,
        onRetry: () => ref.invalidate(violationAppealDetailProvider(appealId)),
        data: (context, data) => _DetailContent(appeal: data),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.appeal});

  final ViolationAppeal appeal;

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
                    Expanded(child: Text(appeal.violationTitle, style: Theme.of(context).textTheme.titleMedium)),
                    StatusChip(label: appeal.status.label(context), color: appeal.status.color(scheme)),
                  ],
                ),
                if (appeal.fineAmount != null) ...[
                  const SizedBox(height: 4),
                  Text(l10n.violationAppealFineAmount(Formatters.currency(appeal.fineAmount!))),
                ],
                if (appeal.reducedFineAmount != null) ...[
                  const SizedBox(height: 4),
                  Text(l10n.violationAppealReducedTo(Formatters.currency(appeal.reducedFineAmount!)),
                      style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w600)),
                ],
                const SizedBox(height: 12),
                Text(appeal.reason, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(appeal.residentMessage),
                const SizedBox(height: 12),
                Text(l10n.financialDisputeSubmitted(Formatters.dateTime(appeal.createdAtUtc)),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
        if (appeal.adminDecisionNotes != null && appeal.adminDecisionNotes!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(l10n.financialDisputeManagementNotes, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(appeal.adminDecisionNotes!),
            ),
          ),
        ],
      ],
    );
  }
}
