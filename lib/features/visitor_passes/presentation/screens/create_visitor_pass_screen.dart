import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_picker_field.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/discard_changes_guard.dart';
import '../../../../core/widgets/form_error_scroll.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../account/presentation/providers/account_providers.dart';
import '../../../account/presentation/widgets/property_picker_options.dart';
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

  /// Flipped by the first submit attempt: errors stay hidden until then,
  /// after which every field re-checks itself live as it's corrected.
  bool _autovalidate = false;

  bool get _isDirty =>
      _nameController.text.trim().isNotEmpty ||
      _phoneController.text.trim().isNotEmpty ||
      _reasonController.text.trim().isNotEmpty;

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
    setState(() => _autovalidate = true);
    if (!validateAndScrollToError(_formKey)) return;
    final l10n = AppLocalizations.of(context)!;

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
                showSuccessSnack(context, l10n.createVisitorPassCodeCopied);
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
      showSuccessSnack(context, l10n.createVisitorPassSuccess);
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
    final properties = ref.watch(residentPropertiesProvider);
    final l10n = AppLocalizations.of(context)!;

    return DiscardChangesGuard(
      isDirty: () => _isDirty && !_isSubmitting,
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.createVisitorPassTitle)),
        body: AsyncValueView(
          value: properties,
          data: (context, propertyList) {
            if (propertyList.length == 1) _propertyUnitId ??= propertyList.first.propertyUnitId;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppPickerField<String>(
                      value: _propertyUnitId,
                      label: l10n.fieldProperty,
                      options: propertyPickerOptions(context, propertyList),
                      validator: (value) => value == null ? l10n.validationChooseProperty : null,
                      onChanged: (value) => setState(() => _propertyUnitId = value),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(labelText: l10n.fieldVisitorName),
                      validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createVisitorPassEnterName : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: l10n.fieldPhoneNumber),
                      validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createVisitorPassEnterPhone : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _reasonController,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(labelText: l10n.fieldReasonForVisit),
                      validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createVisitorPassEnterReason : null,
                    ),
                    const SizedBox(height: 8),
                    _validityWindowField(l10n),
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
      ),
    );
  }

  /// Both date rows live inside one [FormField] so an inverted range reports
  /// itself under the rows that caused it. It used to submit, fail, and throw
  /// a SnackBar at the bottom of the screen instead.
  Widget _validityWindowField(AppLocalizations l10n) {
    return FormField<DateTime>(
      initialValue: _validUntil,
      validator: (_) => _validUntil.isAfter(_validFrom) ? null : l10n.createVisitorPassValidUntilError,
      builder: (field) {
        Future<void> pick({required bool isFrom}) async {
          await _pickDateTime(isFrom: isFrom);
          // Re-checks the window straight away so a corrected date clears the
          // error without waiting for another submit.
          field.didChange(_validUntil);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.fieldValidFrom),
              subtitle: Text(Formatters.dateTime(_validFrom)),
              trailing: const Icon(Icons.edit_calendar_outlined),
              onTap: () => pick(isFrom: true),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.fieldValidUntil),
              subtitle: Text(Formatters.dateTime(_validUntil)),
              trailing: const Icon(Icons.edit_calendar_outlined),
              onTap: () => pick(isFrom: false),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  field.errorText!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
          ],
        );
      },
    );
  }
}
