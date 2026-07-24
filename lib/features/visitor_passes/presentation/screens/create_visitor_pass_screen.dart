import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../account/presentation/providers/account_providers.dart';
import '../providers/visitor_passes_provider.dart';

class CreateVisitorPassScreen extends ConsumerStatefulWidget {
  const CreateVisitorPassScreen({super.key});

  @override
  ConsumerState<CreateVisitorPassScreen> createState() => _CreateVisitorPassScreenState();
}

class _CreateVisitorPassScreenState extends ConsumerState<CreateVisitorPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _reasonController = TextEditingController();
  String? _propertyUnitId;
  DateTime _validFrom = DateTime.now();
  DateTime _validUntil = DateTime.now().add(const Duration(hours: 4));
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime({required bool isFrom}) async {
    final initial = isFrom ? _validFrom : _validUntil;
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initial));
    if (time == null) return;

    final combined = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (isFrom) {
        _validFrom = combined;
        if (_validUntil.isBefore(_validFrom)) {
          _validUntil = _validFrom.add(const Duration(hours: 4));
        }
      } else {
        _validUntil = combined;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _propertyUnitId == null) return;
    final l10n = AppLocalizations.of(context)!;
    if (!_validUntil.isAfter(_validFrom)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.createVisitorPassValidUntilError)));
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final pass = await ref.read(visitorPassesApiProvider).create(
            propertyUnitId: _propertyUnitId!,
            visitorName: _nameController.text.trim(),
            visitorPhoneNumber: _phoneController.text.trim(),
            visitReason: _reasonController.text.trim(),
            validFrom: _validFrom,
            validUntil: _validUntil,
          );
      ref.invalidate(visitorPassesControllerProvider);
      if (!mounted) return;

      // The backend only ever returns the plaintext access code in this
      // create response — it's stored hashed and shows as masked on every
      // later fetch — so this is the resident's one chance to see/share it.
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(l10n.createVisitorPassCreatedTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.createVisitorPassCreatedBody),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  pass.accessCode,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 4),
                ),
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.copy_outlined),
              label: Text(l10n.commonCopy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: pass.accessCode));
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(l10n.createVisitorPassCodeCopied)));
              },
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.commonDone),
            ),
          ],
        ),
      );
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
    final properties = ref.watch(residentPropertiesProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.createVisitorPassTitle)),
      body: AsyncValueView(
        value: properties,
        data: (context, propertyList) {
          _propertyUnitId ??= propertyList.isNotEmpty ? propertyList.first.propertyUnitId : null;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: _propertyUnitId,
                    decoration: InputDecoration(labelText: l10n.fieldProperty),
                    items: propertyList
                        .map((p) => DropdownMenuItem(value: p.propertyUnitId, child: Text(l10n.unitOnly(p.unitNumber))))
                        .toList(),
                    onChanged: (value) => setState(() => _propertyUnitId = value),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: l10n.fieldVisitorName),
                    validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createVisitorPassEnterName : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: l10n.fieldPhoneNumber),
                    validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createVisitorPassEnterPhone : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _reasonController,
                    decoration: InputDecoration(labelText: l10n.fieldReasonForVisit),
                    validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createVisitorPassEnterReason : null,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.fieldValidFrom),
                    subtitle: Text(Formatters.dateTime(_validFrom)),
                    trailing: const Icon(Icons.edit_calendar_outlined),
                    onTap: () => _pickDateTime(isFrom: true),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.fieldValidUntil),
                    subtitle: Text(Formatters.dateTime(_validUntil)),
                    trailing: const Icon(Icons.edit_calendar_outlined),
                    onTap: () => _pickDateTime(isFrom: false),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isSubmitting || propertyList.isEmpty ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(l10n.createVisitorPassSubmit),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
