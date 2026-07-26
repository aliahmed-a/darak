import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/discard_changes_guard.dart';
import '../../../../core/widgets/form_error_scroll.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/emergency_contact.dart';
import '../providers/family_contacts_provider.dart';

class EmergencyContactFormScreen extends ConsumerStatefulWidget {
  const EmergencyContactFormScreen({super.key, this.existing});

  final EmergencyContact? existing;

  @override
  ConsumerState<EmergencyContactFormScreen> createState() => _EmergencyContactFormScreenState();
}

class _EmergencyContactFormScreenState extends ConsumerState<EmergencyContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _fullNameController = TextEditingController(text: widget.existing?.fullName);
  late final _relationshipController = TextEditingController(text: widget.existing?.relationship);
  late final _phoneController = TextEditingController(text: widget.existing?.phoneNumber);
  late bool _isActive = widget.existing?.isActive ?? true;
  bool _isSubmitting = false;

  /// Flipped by the first submit attempt: errors stay hidden until then,
  /// after which every field re-checks itself live as it's corrected.
  bool _autovalidate = false;

  /// Compared against what the screen opened with, so editing an existing
  /// contact only warns once something has actually been changed.
  bool get _isDirty {
    final existing = widget.existing;
    if (existing == null) {
      return _fullNameController.text.trim().isNotEmpty ||
          _relationshipController.text.trim().isNotEmpty ||
          _phoneController.text.trim().isNotEmpty;
    }
    return _fullNameController.text.trim() != existing.fullName ||
        _relationshipController.text.trim() != existing.relationship ||
        _phoneController.text.trim() != existing.phoneNumber ||
        _isActive != existing.isActive;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _relationshipController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _autovalidate = true);
    if (!validateAndScrollToError(_formKey)) return;

    setState(() => _isSubmitting = true);
    try {
      final api = ref.read(familyContactsApiProvider);
      final fullName = _fullNameController.text.trim();
      final relationship = _relationshipController.text.trim();
      final phoneNumber = _phoneController.text.trim();

      if (widget.existing == null) {
        await api.createEmergencyContact(fullName: fullName, relationship: relationship, phoneNumber: phoneNumber);
      } else {
        await api.updateEmergencyContact(
          widget.existing!.id,
          fullName: fullName,
          relationship: relationship,
          phoneNumber: phoneNumber,
          isActive: _isActive,
        );
      }
      ref.invalidate(emergencyContactsProvider);
      if (!mounted) return;
      showSuccessSnack(context, AppLocalizations.of(context)!.emergencyContactSavedSuccess);
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
    final isEditing = widget.existing != null;
    return DiscardChangesGuard(
      isDirty: () => _isDirty && !_isSubmitting,
      child: Scaffold(
        appBar: AppBar(title: Text(isEditing ? l10n.emergencyContactEditTitle : l10n.emergencyContactAddTitle)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(labelText: l10n.fieldFullName),
                  validator: (value) => (value == null || value.trim().isEmpty) ? l10n.familyMemberEnterName : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _relationshipController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(labelText: l10n.fieldRelationship),
                  validator: (value) => (value == null || value.trim().isEmpty) ? l10n.familyMemberEnterRelationship : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: l10n.fieldPhoneNumber),
                  validator: (value) => (value == null || value.trim().isEmpty) ? l10n.emergencyContactEnterPhone : null,
                  onFieldSubmitted: (_) => _isSubmitting ? null : _submit(),
                ),
                if (isEditing) ...[
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.commonActive),
                    value: _isActive,
                    onChanged: (value) => setState(() => _isActive = value),
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(isEditing ? l10n.familyMemberSave : l10n.emergencyContactAdd),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
