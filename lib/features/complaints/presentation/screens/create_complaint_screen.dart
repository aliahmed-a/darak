import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../account/presentation/providers/account_providers.dart';
import '../providers/complaints_provider.dart';

class CreateComplaintScreen extends ConsumerStatefulWidget {
  const CreateComplaintScreen({super.key});

  @override
  ConsumerState<CreateComplaintScreen> createState() => _CreateComplaintScreenState();
}

class _CreateComplaintScreenState extends ConsumerState<CreateComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _propertyUnitId;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      await ref.read(complaintsApiProvider).create(
            propertyUnitId: _propertyUnitId,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
          );
      ref.invalidate(complaintsControllerProvider);
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
      appBar: AppBar(title: Text(l10n.createComplaintTitle)),
      body: AsyncValueView(
        value: properties,
        data: (context, propertyList) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String?>(
                    value: _propertyUnitId,
                    decoration: InputDecoration(labelText: l10n.fieldPropertyOptional),
                    items: [
                      DropdownMenuItem<String?>(value: null, child: Text(l10n.fieldPropertyGeneral)),
                      ...propertyList.map(
                        (p) => DropdownMenuItem<String?>(value: p.propertyUnitId, child: Text(l10n.unitOnly(p.unitNumber))),
                      ),
                    ],
                    onChanged: (value) => setState(() => _propertyUnitId = value),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: l10n.fieldTitle),
                    validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createMaintenanceEnterTitle : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: l10n.fieldDescription),
                    maxLines: 5,
                    validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createComplaintDescribe : null,
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
                        : Text(l10n.createComplaintSubmit),
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
