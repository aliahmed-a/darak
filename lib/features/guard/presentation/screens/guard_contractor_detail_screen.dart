import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/contractor_work_permit_status.dart';
import '../../data/models/guard_contractor_permit.dart';
import '../providers/guard_contractor_access_provider.dart';

/// There is no GET-by-id for contractor permits on the backend, so this
/// screen is handed its data directly via navigation `extra` rather than
/// fetching it, and simply pops back (invalidating the today-list) after a
/// check-in/check-out action instead of refreshing itself in place.
class GuardContractorDetailScreen extends ConsumerStatefulWidget {
  const GuardContractorDetailScreen({super.key, required this.permit});

  final GuardContractorPermit permit;

  @override
  ConsumerState<GuardContractorDetailScreen> createState() => _GuardContractorDetailScreenState();
}

class _GuardContractorDetailScreenState extends ConsumerState<GuardContractorDetailScreen> {
  bool _isSubmitting = false;

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
              onPressed: () {
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
      await ref.read(guardContractorAccessApiProvider).checkIn(
            widget.permit.id,
            accessCode: codeController.text.trim(),
            notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
          );
      ref.invalidate(guardContractorsTodayControllerProvider);
      if (mounted) context.pop();
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
      await ref.read(guardContractorAccessApiProvider).checkOut(
            widget.permit.id,
            notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
          );
      ref.invalidate(guardContractorsTodayControllerProvider);
      if (mounted) context.pop();
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final permit = widget.permit;
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.guardContractorDetailTitle)),
      body: ListView(
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
                      Expanded(child: Text(permit.vendorName, style: Theme.of(context).textTheme.titleMedium)),
                      StatusChip(label: permit.status.label(context), color: permit.status.color(scheme)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  StatusChip(label: permit.riskLevel.label(context), color: permit.riskLevel.color(scheme)),
                  const SizedBox(height: 12),
                  Text(permit.purpose),
                  const SizedBox(height: 4),
                  Text(permit.workArea),
                  const SizedBox(height: 12),
                  Text(l10n.validDateRange(
                    Formatters.dateTime(permit.allowedFromUtc),
                    Formatters.dateTime(permit.allowedUntilUtc),
                  )),
                  if (permit.checkedInAtUtc != null)
                    Text(l10n.visitorPassCheckedIn(Formatters.dateTime(permit.checkedInAtUtc!))),
                  if (permit.checkedOutAtUtc != null)
                    Text(l10n.visitorPassCheckedOut(Formatters.dateTime(permit.checkedOutAtUtc!))),
                  if (permit.denialReason != null) ...[
                    const SizedBox(height: 8),
                    Text(permit.denialReason!, style: TextStyle(color: scheme.error)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: permit.status == ContractorWorkPermitStatus.approved ||
              permit.status == ContractorWorkPermitStatus.checkedIn
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: permit.status == ContractorWorkPermitStatus.approved
                    ? FilledButton(
                        onPressed: _isSubmitting ? null : _checkIn,
                        child: Text(l10n.guardCheckIn),
                      )
                    : FilledButton(
                        onPressed: _isSubmitting ? null : _checkOut,
                        child: Text(l10n.guardCheckOut),
                      ),
              ),
            )
          : null,
    );
  }
}
