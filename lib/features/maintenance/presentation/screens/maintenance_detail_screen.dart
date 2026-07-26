import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/maintenance_request.dart';
import '../../data/models/maintenance_status.dart';
import '../providers/maintenance_provider.dart';

class MaintenanceDetailScreen extends ConsumerStatefulWidget {
  const MaintenanceDetailScreen({super.key, required this.requestId});

  final String requestId;

  @override
  ConsumerState<MaintenanceDetailScreen> createState() => _MaintenanceDetailScreenState();
}

class _MaintenanceDetailScreenState extends ConsumerState<MaintenanceDetailScreen> {
  bool _isSubmitting = false;

  Future<void> _promptAndSubmit({required bool isCancel}) async {
    final l10n = AppLocalizations.of(context)!;
    final notesController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCancel ? l10n.maintenanceCancelRequest : l10n.maintenanceCloseRequest),
        content: TextField(
          controller: notesController,
          decoration: InputDecoration(labelText: l10n.maintenanceNotesOptional),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.commonBack)),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: Text(l10n.commonConfirm)),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _isSubmitting = true);
    try {
      final api = ref.read(maintenanceApiProvider);
      final notes = notesController.text.trim().isEmpty ? null : notesController.text.trim();
      if (isCancel) {
        await api.cancel(widget.requestId, notes: notes);
      } else {
        await api.close(widget.requestId, notes: notes);
      }
      ref.invalidate(maintenanceDetailProvider(widget.requestId));
      ref.invalidate(maintenanceControllerProvider);
    } on ApiException catch (e) {
      if (!mounted) return;
      showErrorSnack(context, e.message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = ref.watch(maintenanceDetailProvider(widget.requestId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.maintenanceDetailTitle)),
      body: AsyncValueView(
        value: request,
        onRetry: () => ref.invalidate(maintenanceDetailProvider(widget.requestId)),
        data: (context, data) => _DetailContent(request: data),
      ),
      bottomNavigationBar: request.valueOrNull == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildActions(request.value!, l10n),
              ),
            ),
    );
  }

  Widget _buildActions(MaintenanceRequest request, AppLocalizations l10n) {
    if (request.status == MaintenanceStatus.resolved) {
      return ElevatedButton(
        onPressed: _isSubmitting ? null : () => _promptAndSubmit(isCancel: false),
        child: Text(l10n.maintenanceCloseRequest),
      );
    }
    if (!request.status.isTerminal) {
      return OutlinedButton(
        onPressed: _isSubmitting ? null : () => _promptAndSubmit(isCancel: true),
        child: Text(l10n.maintenanceCancelRequest),
      );
    }
    return const SizedBox.shrink();
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.request});

  final MaintenanceRequest request;

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
                    Expanded(child: Text(request.title, style: Theme.of(context).textTheme.titleMedium)),
                    StatusChip(label: request.status.label(context), color: request.status.color(scheme)),
                  ],
                ),
                const SizedBox(height: 8),
                StatusChip(label: request.priority.label(context), color: request.priority.color(scheme)),
                const SizedBox(height: 12),
                Text(request.description),
                const SizedBox(height: 12),
                Text(l10n.unitAndCompound(request.unitNumber, request.compoundName), style: Theme.of(context).textTheme.bodySmall),
                if (request.assignedToUserName != null)
                  Text(l10n.maintenanceAssignedTo(request.assignedToUserName!), style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
        if (request.resolutionNotes != null && request.resolutionNotes!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(l10n.maintenanceResolutionNotes, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(request.resolutionNotes!),
        ],
        if (request.costEstimate != null || request.actualCost != null) ...[
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (request.costEstimate != null) _row(l10n.maintenanceCostEstimate, request.costEstimate!),
                  if (request.actualCost != null) _row(l10n.maintenanceActualCost, request.actualCost!),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        Text(l10n.maintenanceTimeline, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              _timelineTile(l10n.maintenanceTimelineCreated, request.createdAt),
              if (request.assignedAt != null) _timelineTile(l10n.maintenanceTimelineAssigned, request.assignedAt),
              if (request.startedAt != null) _timelineTile(l10n.maintenanceTimelineStarted, request.startedAt),
              if (request.resolvedAt != null) _timelineTile(l10n.maintenanceTimelineResolved, request.resolvedAt),
              if (request.closedAt != null) _timelineTile(l10n.maintenanceTimelineClosed, request.closedAt),
              if (request.cancelledAt != null) _timelineTile(l10n.maintenanceTimelineCancelled, request.cancelledAt),
            ],
          ),
        ),
      ],
    );
  }

  Widget _row(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(Formatters.currency(amount))],
      ),
    );
  }

  Widget _timelineTile(String label, DateTime? value) {
    if (value == null) return const SizedBox.shrink();
    return ListTile(title: Text(label), trailing: Text(Formatters.dateTime(value)));
  }
}
