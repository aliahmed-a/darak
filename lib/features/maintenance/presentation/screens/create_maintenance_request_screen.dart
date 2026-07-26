import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/widgets/app_picker_field.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/discard_changes_guard.dart';
import '../../../../core/widgets/form_error_scroll.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../account/presentation/providers/account_providers.dart';
import '../../../account/presentation/widgets/property_picker_options.dart';
import '../../data/models/maintenance_priority.dart';
import '../providers/maintenance_provider.dart';

class CreateMaintenanceRequestScreen extends ConsumerStatefulWidget {
  const CreateMaintenanceRequestScreen({super.key});

  @override
  ConsumerState<CreateMaintenanceRequestScreen> createState() => _CreateMaintenanceRequestScreenState();
}

class _CreateMaintenanceRequestScreenState extends ConsumerState<CreateMaintenanceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _propertyUnitId;
  MaintenancePriority _priority = MaintenancePriority.medium;
  bool _isSubmitting = false;

  /// Flipped by the first submit attempt: errors stay hidden until then,
  /// after which every field re-checks itself live as it's corrected.
  bool _autovalidate = false;

  bool get _isDirty =>
      _titleController.text.trim().isNotEmpty || _descriptionController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _autovalidate = true);
    if (!validateAndScrollToError(_formKey)) return;

    setState(() => _isSubmitting = true);
    try {
      await ref.read(maintenanceApiProvider).create(
            propertyUnitId: _propertyUnitId!,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            priority: _priority,
          );
      ref.invalidate(maintenanceControllerProvider);
      if (!mounted) return;
      // Shown before popping so the root ScaffoldMessenger carries it over to
      // the list the resident lands back on.
      showSuccessSnack(context, AppLocalizations.of(context)!.createMaintenanceSuccess);
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
        appBar: AppBar(title: Text(l10n.createMaintenanceTitle)),
        body: AsyncValueView(
          value: properties,
          data: (context, propertyList) {
            // Only pre-fill when there's nothing to choose between; with two
            // units, silently defaulting to the first invites the resident to
            // file against the wrong one.
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
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(labelText: l10n.fieldTitle),
                      validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createMaintenanceEnterTitle : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(labelText: l10n.fieldDescription),
                      validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createMaintenanceDescribeIssue : null,
                    ),
                    const SizedBox(height: 12),
                    AppPickerField<MaintenancePriority>(
                      value: _priority,
                      label: l10n.fieldPriority,
                      options: MaintenancePriority.values
                          .map((priority) => PickerOption<MaintenancePriority>(
                                value: priority,
                                label: priority.label(context),
                                icon: Icons.flag_outlined,
                                iconColor: priority.color(Theme.of(context).colorScheme),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() => _priority = value ?? _priority),
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
                          : Text(l10n.createMaintenanceSubmit),
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
}
