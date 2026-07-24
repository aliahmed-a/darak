import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/complaint.dart';
import '../providers/complaints_provider.dart';

class ComplaintDetailScreen extends ConsumerWidget {
  const ComplaintDetailScreen({super.key, required this.complaintId});

  final String complaintId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complaint = ref.watch(complaintDetailProvider(complaintId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.complaintDetailTitle)),
      body: AsyncValueView(
        value: complaint,
        onRetry: () => ref.invalidate(complaintDetailProvider(complaintId)),
        data: (context, data) => _DetailContent(complaint: data),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.complaint});

  final Complaint complaint;

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
                    Expanded(child: Text(complaint.title, style: Theme.of(context).textTheme.titleMedium)),
                    StatusChip(label: complaint.status.label(context), color: complaint.status.color(scheme)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(complaint.description),
                const SizedBox(height: 12),
                Text(
                  [complaint.compoundName, if (complaint.unitNumber != null) l10n.unitOnly(complaint.unitNumber!)]
                      .join(' · '),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(l10n.financialDisputeSubmitted(Formatters.dateTime(complaint.createdAt)),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
        if (complaint.adminResponse != null && complaint.adminResponse!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(l10n.complaintManagementResponse, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(complaint.adminResponse!),
            ),
          ),
        ],
      ],
    );
  }
}
