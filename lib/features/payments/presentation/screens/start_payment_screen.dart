import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/payment_target.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/payment.dart';
import '../../data/models/payment_method.dart';
import '../providers/payments_provider.dart';

enum _Step { selectingMethod, startingPayment, awaitingGatewayConfirmation, confirmingGateway }

class StartPaymentScreen extends ConsumerStatefulWidget {
  const StartPaymentScreen({super.key, required this.target});

  final PaymentTarget target;

  @override
  ConsumerState<StartPaymentScreen> createState() => _StartPaymentScreenState();
}

class _StartPaymentScreenState extends ConsumerState<StartPaymentScreen> {
  PaymentMethod _method = PaymentMethod.zainCashMock;
  _Step _step = _Step.selectingMethod;
  Payment? _payment;
  String? _errorMessage;

  Future<void> _startPayment() async {
    setState(() {
      _step = _Step.startingPayment;
      _errorMessage = null;
    });
    try {
      final payment = await ref.read(paymentsApiProvider).start(
            targetType: widget.target.type,
            targetId: widget.target.targetId,
            paymentMethod: _method,
            amount: widget.target.amount,
          );
      setState(() {
        _payment = payment;
        _step = _Step.awaitingGatewayConfirmation;
      });
    } on ApiException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _step = _Step.selectingMethod;
      });
    }
  }

  Future<void> _confirmGateway(bool success) async {
    final payment = _payment;
    if (payment == null) return;

    setState(() => _step = _Step.confirmingGateway);
    try {
      await ref.read(paymentsApiProvider).confirmMock(
            paymentId: payment.id,
            method: _method,
            success: success,
          );
      if (!mounted) return;
      ref.invalidate(paymentsControllerProvider);
      context.pushReplacement(Routes.paymentDetail(payment.id));
    } on ApiException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _step = _Step.awaitingGatewayConfirmation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.startPaymentTitle)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _step == _Step.awaitingGatewayConfirmation || _step == _Step.confirmingGateway
            ? _buildGatewayStep(context)
            : _buildSelectionStep(context),
      ),
    );
  }

  Widget _buildSelectionStep(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isSubmitting = _step == _Step.startingPayment;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.target.label, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(widget.target.type.label(context), style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 12),
                Text(
                  Formatters.currency(widget.target.amount),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(l10n.startPaymentMethod, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        _MethodTile(
          icon: Icons.phone_android,
          label: l10n.paymentMethodZainCash,
          selected: _method == PaymentMethod.zainCashMock,
          onTap: () => setState(() => _method = PaymentMethod.zainCashMock),
        ),
        const SizedBox(height: 8),
        _MethodTile(
          icon: Icons.credit_card,
          label: l10n.paymentMethodMasterCard,
          selected: _method == PaymentMethod.masterCardMock,
          onTap: () => setState(() => _method = PaymentMethod.masterCardMock),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 16),
          Text(_errorMessage!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
        ],
        const Spacer(),
        ElevatedButton(
          onPressed: isSubmitting ? null : _startPayment,
          child: isSubmitting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : Text(l10n.payAmount(Formatters.currency(widget.target.amount))),
        ),
      ],
    );
  }

  Widget _buildGatewayStep(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isConfirming = _step == _Step.confirmingGateway;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  _method == PaymentMethod.zainCashMock ? Icons.phone_android : Icons.credit_card,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(l10n.startPaymentDemoGateway(_method.label(context)), style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  l10n.startPaymentMockNotice,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 16),
          Text(_errorMessage!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
        ],
        const Spacer(),
        ElevatedButton(
          onPressed: isConfirming ? null : () => _confirmGateway(true),
          child: Text(l10n.startPaymentSimulateSuccess),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: isConfirming ? null : () => _confirmGateway(false),
          child: Text(l10n.startPaymentSimulateFailure),
        ),
      ],
    );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({required this.icon, required this.label, required this.selected, required this.onTap});

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: selected ? scheme.primaryContainer : null,
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        trailing: selected ? Icon(Icons.check_circle, color: scheme.primary) : null,
        onTap: onTap,
      ),
    );
  }
}
