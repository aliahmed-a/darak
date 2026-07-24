import 'payment_target_type.dart';

/// Carries the "pay this" intent from a bill/rent/installment screen into
/// the start-payment flow, passed as a `go_router` `extra`.
class PaymentTarget {
  const PaymentTarget({
    required this.type,
    required this.targetId,
    required this.amount,
    required this.label,
  });

  final PaymentTargetType type;
  final String targetId;
  final double amount;
  final String label;
}
