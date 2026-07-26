import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_picker_field.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/discard_changes_guard.dart';
import '../../../../core/widgets/form_error_scroll.dart';
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

IconData _targetTypeIcon(FinancialDisputeTargetType type) => switch (type) {
      FinancialDisputeTargetType.utilityBill => Icons.receipt_long_outlined,
      FinancialDisputeTargetType.rentInvoice => Icons.home_outlined,
      FinancialDisputeTargetType.propertyInstallment => Icons.calendar_month_outlined,
      FinancialDisputeTargetType.payment => Icons.payments_outlined,
      FinancialDisputeTargetType.violationFine => Icons.gavel_outlined,
      FinancialDisputeTargetType.financialAdjustment => Icons.tune_outlined,
    };

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

  /// Flipped by the first submit attempt: errors stay hidden until then,
  /// after which every field re-checks itself live as it's corrected.
  bool _autovalidate = false;

  bool get _isDirty =>
      _reasonController.text.trim().isNotEmpty || _messageController.text.trim().isNotEmpty || _targetId != null;

  @override
  void dispose() {
    _reasonController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _autovalidate = true);
    if (!validateAndScrollToError(_formKey)) return;
    final l10n = AppLocalizations.of(context)!;
    // The item picker validates inline, but when the resident has nothing of
    // this type at all there's no picker on screen to hang an error on.
    if (_targetId == null) {
      showErrorSnack(context, l10n.createFinancialDisputeSelectTarget);
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
      showSuccessSnack(context, l10n.createFinancialDisputeSuccess);
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
        appBar: AppBar(title: Text(l10n.createFinancialDisputeTitle)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppPickerField<FinancialDisputeTargetType>(
                  value: _targetType,
                  label: l10n.fieldWhatDisputing,
                  options: _targetTypeOptions
                      .map((type) => PickerOption<FinancialDisputeTargetType>(
                            value: type,
                            label: type.label(context),
                            icon: _targetTypeIcon(type),
                          ))
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
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: l10n.fieldReason),
                  validator: (value) => (value == null || value.trim().isEmpty) ? l10n.createFinancialDisputeEnterReason : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _messageController,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: l10n.fieldMessage),
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
        return _buildPicker(
          context,
          ref.watch(billsControllerProvider),
          labelFor: (bill) => bill.billNumber,
          subtitleFor: (bill) => Formatters.currency(bill.totalAmount),
          idFor: (bill) => bill.id,
        );
      case FinancialDisputeTargetType.rentInvoice:
        return _buildPicker(
          context,
          ref.watch(rentControllerProvider),
          labelFor: (invoice) => invoice.invoiceNumber,
          subtitleFor: (invoice) => Formatters.currency(invoice.totalAmount),
          idFor: (invoice) => invoice.id,
        );
      case FinancialDisputeTargetType.propertyInstallment:
        return _buildPicker(
          context,
          ref.watch(installmentsControllerProvider),
          labelFor: (item) => AppLocalizations.of(context)!.installmentNumber('${item.installmentNumber}'),
          subtitleFor: (item) => Formatters.currency(item.amount),
          idFor: (item) => item.id,
        );
      case FinancialDisputeTargetType.payment:
        return _buildPicker(
          context,
          ref.watch(paymentsControllerProvider),
          labelFor: (payment) => payment.paymentReference,
          subtitleFor: (payment) => Formatters.currency(payment.amount),
          idFor: (payment) => payment.id,
        );
      case FinancialDisputeTargetType.violationFine:
      case FinancialDisputeTargetType.financialAdjustment:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPicker<T>(
    BuildContext context,
    AsyncValue<PagedListState<T>> state, {
    required String Function(T) labelFor,
    required String Function(T) subtitleFor,
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
        return AppPickerField<String>(
          value: selectedId,
          label: l10n.createFinancialDisputeSelectItem,
          // The amount moves to its own line, so a long reference no longer
          // gets truncated to make room for it.
          options: data.items
              .map((item) => PickerOption<String>(
                    value: idFor(item),
                    label: labelFor(item),
                    subtitle: subtitleFor(item),
                    icon: _targetTypeIcon(targetType),
                  ))
              .toList(),
          validator: (value) => value == null ? l10n.createFinancialDisputeSelectTarget : null,
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
