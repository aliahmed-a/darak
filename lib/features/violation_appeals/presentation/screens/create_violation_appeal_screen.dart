import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/discard_changes_guard.dart';
import '../../../../core/widgets/form_error_scroll.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/violation_appeal_target.dart';
import '../providers/violation_appeals_provider.dart';

class CreateViolationAppealScreen extends ConsumerStatefulWidget {
  const CreateViolationAppealScreen({super.key, required this.target});

  final ViolationAppealTarget target;

  @override
  ConsumerState<CreateViolationAppealScreen> createState() => _CreateViolationAppealScreenState();
}

class _CreateViolationAppealScreenState extends ConsumerState<CreateViolationAppealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  /// Flipped by the first submit attempt: errors stay hidden until then,
  /// after which every field re-checks itself live as it's corrected.
  bool _autovalidate = false;

  bool get _isDirty =>
      _reasonController.text.trim().isNotEmpty || _messageController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _reasonController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _autovalidate = true);
    if (!validateAndScrollToError(_formKey)) return;

    setState(() => _isSubmitting = true);
    try {
      await ref.read(violationAppealsApiProvider).create(
            violationId: widget.target.violationId,
            violationFineId: widget.target.violationFineId,
            reason: _reasonController.text.trim(),
            message: _messageController.text.trim(),
          );
      ref.invalidate(violationAppealsControllerProvider);
      if (!mounted) return;
      showSuccessSnack(context, AppLocalizations.of(context)!.createViolationAppealSuccess);
      context.pop();
    } on ApiException catch (e) {
      if (!mounted) return;
      showErrorSnack(context, e.message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DiscardChangesGuard(
      isDirty: () => _isDirty && !_isSubmitting,
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.createViolationAppealTitle)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.createViolationAppealAppealing, style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 4),
                        Text(widget.target.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                        if (widget.target.fineAmount != null) ...[
                          const SizedBox(height: 4),
                          Text(l10n.violationAppealFineAmount(Formatters.currency(widget.target.fineAmount!))),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reasonController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: l10n.fieldReason),
                  validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createViolationAppealEnterReason : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _messageController,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: l10n.fieldMessage),
                  validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createViolationAppealExplain : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(l10n.createViolationAppealSubmit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
