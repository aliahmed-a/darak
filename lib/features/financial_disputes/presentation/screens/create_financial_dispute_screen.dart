import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../account/presentation/providers/account_providers.dart';
import '../../../payments/presentation/providers/payments_provider.dart';
import '../../data/models/financial_dispute_target_type.dart';
import '../providers/financial_disputes_provider.dart';

const _targetTypeOptions = [
  FinancialDisputeTargetType.utilityBill,
  FinancialDisputeTargetType.rentInvoice,
  FinancialDisputeTargetType.propertyInstallment,
  FinancialDisputeTargetType.payment,
];

class CreateFinancialDisputeScreen extends ConsumerStatefulWidget {
  const CreateFinancialDisputeScreen({super.key});

  @override
  ConsumerState<CreateFinancialDisputeScreen> createState() => _CreateFinancialDisputeScreenState();
}

class _CreateFinancialDisputeScreenState extends ConsumerState<CreateFinancialDisputeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _messageController = TextEditingController();
  FinancialDisputeTargetType _targetType = FinancialDisputeTargetType.utilityBill;
  String? _targetId;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reasonController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;
    if (_targetId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.createFinancialDisputeSelectTarget)));
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await ref.read(financialDisputesApiProvider).create(
            targetType: _targetType,
            targetId: _targetId!,
            reason: _reasonController.text.trim(),
            message: _messageController.text.trim(),
          );
      ref.invalidate(financialDisputesControllerProvider);
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
    return Scaffold(
      appBar: AppBar(title: Text(l10n.createFinancialDisputeTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<FinancialDisputeTargetType>(
                value: _targetType,
                decoration: InputDecoration(labelText: l10n.fieldWhatDisputing),
                items: _targetTypeOptions
                    .map((type) => DropdownMenuItem(value: type, child: Text(type.label(context))))
                    .toList(),
                onChanged: (value) => setState(() {
                  _targetType = value!;
                  _targetId = null;
                }),
              ),
              const SizedBox(height: 12),
              _TargetPicker(
                key: ValueKey(_targetType),
                targetType: _targetType,
                selectedId: _targetId,
                onChanged: (id) => setState(() => _targetId = id),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(labelText: l10n.fieldReason),
                validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createFinancialDisputeEnterReason : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: l10n.fieldMessage),
                maxLines: 5,
                validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createFinancialDisputeDescribe : null,
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
                    : Text(l10n.createFinancialDisputeSubmit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fetches the list backing the selected [targetType] (bills, rent invoices,
/// installments, or payments) and renders it as a picker of specific items
/// the resident can attach the dispute to.
class _TargetPicker extends ConsumerWidget {
  const _TargetPicker({
    super.key,
    required this.targetType,
    required this.selectedId,
    required this.onChanged,
  });

  final FinancialDisputeTargetType targetType;
  final String? selectedId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (targetType) {
      case FinancialDisputeTargetType.utilityBill:
        return _buildDropdown(
          context,
          ref.watch(billsControllerProvider),
          labelFor: (bill) => '${bill.billNumber} · ${Formatters.currency(bill.totalAmount)}',
          idFor: (bill) => bill.id,
        );
      case FinancialDisputeTargetType.rentInvoice:
        return _buildDropdown(
          context,
          ref.watch(rentControllerProvider),
          labelFor: (invoice) => '${invoice.invoiceNumber} · ${Formatters.currency(invoice.totalAmount)}',
          idFor: (invoice) => invoice.id,
        );
      case FinancialDisputeTargetType.propertyInstallment:
        return _buildDropdown(
          context,
          ref.watch(installmentsControllerProvider),
          labelFor: (item) => '${AppLocalizations.of(context)!.installmentNumber('${item.installmentNumber}')} · ${Formatters.currency(item.amount)}',
          idFor: (item) => item.id,
        );
      case FinancialDisputeTargetType.payment:
        return _buildDropdown(
          context,
          ref.watch(paymentsControllerProvider),
          labelFor: (payment) => '${payment.paymentReference} · ${Formatters.currency(payment.amount)}',
          idFor: (payment) => payment.id,
        );
      case FinancialDisputeTargetType.violationFine:
      case FinancialDisputeTargetType.financialAdjustment:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDropdown<T>(
    BuildContext context,
    AsyncValue<PagedListState<T>> state, {
    required String Function(T) labelFor,
    required String Function(T) idFor,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return state.when(
      data: (data) {
        if (data.items.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(l10n.createFinancialDisputeNothingAvailable),
          );
        }
        return DropdownButtonFormField<String>(
          value: selectedId,
          decoration: InputDecoration(labelText: l10n.createFinancialDisputeSelectItem),
          isExpanded: true,
          items: data.items
              .map((item) => DropdownMenuItem(
                    value: idFor(item),
                    child: Text(labelFor(item), overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: LinearProgressIndicator(),
      ),
      error: (error, _) => Text(
        l10n.createFinancialDisputeCouldNotLoad,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
