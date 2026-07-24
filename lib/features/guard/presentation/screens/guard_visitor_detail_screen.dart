import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../visitor_passes/data/models/visitor_pass_status.dart';
import '../../data/models/guard_visitor_pass.dart';
import '../../data/models/visitor_access_log.dart';
import '../providers/guard_visitor_access_provider.dart';

class GuardVisitorDetailScreen extends ConsumerStatefulWidget {
  const GuardVisitorDetailScreen({super.key, required this.passId});

  final String passId;

  @override
  ConsumerState<GuardVisitorDetailScreen> createState() => _GuardVisitorDetailScreenState();
}

class _GuardVisitorDetailScreenState extends ConsumerState<GuardVisitorDetailScreen> {
  bool _isSubmitting = false;

  void _refreshAfterAction() {
    ref.invalidate(guardVisitorDetailProvider(widget.passId));
    ref.invalidate(guardVisitorsTodayControllerProvider);
    ref.invalidate(guardVisitorLogsControllerProvider(widget.passId));
  }

  /// Check-out and deny both move the pass to a status the backend excludes
  /// from guard visibility (`IsVisibleToGuard` only allows
  /// Pending/Approved/CheckedIn), so re-fetching this detail screen after
  /// either action always 404s. Leave the screen instead of refreshing it.
  void _leaveAfterTerminalAction() {
    ref.invalidate(guardVisitorsTodayControllerProvider);
    if (mounted) context.pop();
  }

  Future<void> _checkIn() async {
    final l10n = AppLocalizations.of(context)!;
    final codeController = TextEditingController();
    final notesController = TextEditingController();
    String? error;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.guardCheckIn),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeController,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(labelText: l10n.guardVerifyCodeLabel, errorText: error),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesController,
                decoration: InputDecoration(labelText: l10n.guardNotesOptional),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.commonCancel)),
            FilledButton(
              onPressed: () async {
                setState(() => error = null);
                if (codeController.text.trim().isEmpty) {
                  setState(() => error = l10n.guardEnterAccessCode);
                  return;
                }
                Navigator.of(context).pop(true);
              },
              child: Text(l10n.guardCheckIn),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true) return;

    setState(() => _isSubmitting = true);
    try {
      await ref.read(guardVisitorAccessApiProvider).checkIn(
            widget.passId,
            accessCode: codeController.text.trim(),
            notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
          );
      _refreshAfterAction();
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _checkOut() async {
    final l10n = AppLocalizations.of(context)!;
    final notesController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.guardCheckOut),
        content: TextField(
          controller: notesController,
          decoration: InputDecoration(labelText: l10n.guardNotesOptional),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.commonCancel)),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: Text(l10n.guardCheckOut)),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _isSubmitting = true);
    try {
      await ref.read(guardVisitorAccessApiProvider).checkOut(
            widget.passId,
            notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
          );
      _leaveAfterTerminalAction();
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _deny() async {
    final l10n = AppLocalizations.of(context)!;
    final reasonController = TextEditingController();
    String? error;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.guardDenyTitle),
          content: TextField(
            controller: reasonController,
            autofocus: true,
            decoration: InputDecoration(labelText: l10n.guardDenyReasonLabel, errorText: error),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.commonCancel)),
            FilledButton(
              onPressed: () {
                if (reasonController.text.trim().isEmpty) {
                  setState(() => error = l10n.guardEnterDenyReason);
                  return;
                }
                Navigator.of(context).pop(true);
              },
              child: Text(l10n.guardDeny),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true) return;

    setState(() => _isSubmitting = true);
    try {
      await ref.read(guardVisitorAccessApiProvider).deny(widget.passId, reason: reasonController.text.trim());
      _leaveAfterTerminalAction();
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pass = ref.watch(guardVisitorDetailProvider(widget.passId));
    final l10n = AppLocalizations.of(context)!;
    final status = pass.valueOrNull?.status;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.guardVisitorDetailTitle)),
      body: AsyncValueView(
        value: pass,
        onRetry: () => ref.invalidate(guardVisitorDetailProvider(widget.passId)),
        data: (context, data) => _DetailContent(pass: data, passId: widget.passId),
      ),
      bottomNavigationBar: status == VisitorPassStatus.approved || status == VisitorPassStatus.checkedIn
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (status == VisitorPassStatus.approved) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _isSubmitting ? null : _deny,
                          child: Text(l10n.guardDeny),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: _isSubmitting ? null : _checkIn,
                          child: Text(l10n.guardCheckIn),
                        ),
                      ),
                    ] else if (status == VisitorPassStatus.checkedIn) ...[
                      Expanded(
                        child: FilledButton(
                          onPressed: _isSubmitting ? null : _checkOut,
                          child: Text(l10n.guardCheckOut),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

class _DetailContent extends ConsumerWidget {
  const _DetailContent({required this.pass, required this.passId});

  final GuardVisitorPass pass;
  final String passId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final logs = ref.watch(guardVisitorLogsControllerProvider(passId));

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
                    Expanded(child: Text(pass.visitorName, style: Theme.of(context).textTheme.titleMedium)),
                    StatusChip(label: pass.status.label(context), color: pass.status.color(scheme)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(pass.visitorPhoneNumber),
                const SizedBox(height: 8),
                Text(pass.visitReason),
                const SizedBox(height: 12),
                Text(l10n.unitAndCompound(pass.unitNumber, pass.compoundName)),
                Text(pass.residentName),
                const SizedBox(height: 12),
                Text(l10n.validDateRange(Formatters.dateTime(pass.validFrom), Formatters.dateTime(pass.validUntil))),
                if (pass.checkedInAt != null) Text(l10n.visitorPassCheckedIn(Formatters.dateTime(pass.checkedInAt!))),
                if (pass.checkedOutAt != null)
                  Text(l10n.visitorPassCheckedOut(Formatters.dateTime(pass.checkedOutAt!))),
                if (pass.denialReason != null) ...[
                  const SizedBox(height: 8),
                  Text(pass.denialReason!, style: TextStyle(color: scheme.error)),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(l10n.guardAccessLogTitle, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        logs.when(
          data: (data) => data.items.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(l10n.guardAccessLogEmpty, style: TextStyle(color: scheme.outline)),
                )
              : Column(
                  children: [
                    for (final log in data.items) _LogTile(log: log),
                    if (data.hasNextPage)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: OutlinedButton(
                          onPressed: () => ref.read(guardVisitorLogsControllerProvider(passId).notifier).loadMore(),
                          child: Text(l10n.commonLoadMore),
                        ),
                      ),
                  ],
                ),
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _LogTile extends StatelessWidget {
  const _LogTile({required this.log});

  final GuardAccessLog log;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(log.action.icon),
        title: Text(log.action.label(context)),
        subtitle: Text(Formatters.dateTime(log.createdAt)),
      ),
    );
  }
}
