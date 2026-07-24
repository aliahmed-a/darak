import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/family_member.dart';
import '../providers/family_contacts_provider.dart';

class FamilyMemberFormScreen extends ConsumerStatefulWidget {
  const FamilyMemberFormScreen({super.key, this.existing});

  final FamilyMember? existing;

  @override
  ConsumerState<FamilyMemberFormScreen> createState() => _FamilyMemberFormScreenState();
}

class _FamilyMemberFormScreenState extends ConsumerState<FamilyMemberFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _fullNameController = TextEditingController(text: widget.existing?.fullName);
  late final _relationshipController = TextEditingController(text: widget.existing?.relationship);
  late final _phoneController = TextEditingController(text: widget.existing?.phoneNumber);
  DateTime? _dateOfBirth;
  late bool _isActive = widget.existing?.isActive ?? true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _dateOfBirth = widget.existing?.dateOfBirth;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _relationshipController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickDateOfBirth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(now.year - 20),
      firstDate: DateTime(now.year - 120),
      lastDate: now,
    );
    if (picked != null) setState(() => _dateOfBirth = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      final api = ref.read(familyContactsApiProvider);
      final fullName = _fullNameController.text.trim();
      final relationship = _relationshipController.text.trim();
      final phoneNumber = _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim();

      if (widget.existing == null) {
        await api.createFamilyMember(
          fullName: fullName,
          relationship: relationship,
          dateOfBirth: _dateOfBirth,
          phoneNumber: phoneNumber,
        );
      } else {
        await api.updateFamilyMember(
          widget.existing!.id,
          fullName: fullName,
          relationship: relationship,
          dateOfBirth: _dateOfBirth,
          phoneNumber: phoneNumber,
          isActive: _isActive,
        );
      }
      ref.invalidate(familyMembersProvider);
      if (!mounted) return;
      context.pop();
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.existing != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? l10n.familyMemberEditTitle : l10n.familyMemberAddTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: l10n.fieldFullName),
                validator: (value) => (value == null || value.trim().isEmpty) ? l10n.familyMemberEnterName : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _relationshipController,
                decoration: InputDecoration(labelText: l10n.fieldRelationship),
                validator: (value) => (value == null || value.trim().isEmpty) ? l10n.familyMemberEnterRelationship : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: l10n.fieldPhoneNumberOptional),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: _pickDateOfBirth,
                child: InputDecorator(
                  decoration: InputDecoration(labelText: l10n.fieldDateOfBirthOptional),
                  child: Text(_dateOfBirth == null ? l10n.commonNotSet : Formatters.date(_dateOfBirth!)),
                ),
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
                    : Text(isEditing ? l10n.familyMemberSave : l10n.familyMemberAdd),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
