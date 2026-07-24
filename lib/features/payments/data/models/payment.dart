import '../../../../core/models/payment_target_type.dart';
import 'payment_method.dart';
import 'payment_status.dart';

class Receipt {
  const Receipt({
    required this.id,
    required this.receiptNumber,
    required this.amount,
    required this.issuedAt,
  });

  final String id;
  final String receiptNumber;
  final double amount;
  final DateTime issuedAt;

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        id: json['id'] as String,
        receiptNumber: json['receiptNumber'] as String,
        amount: (json['amount'] as num).toDouble(),
        issuedAt: DateTime.parse(json['issuedAt'] as String),
      );
}

class PaymentAttempt {
  const PaymentAttempt({
    required this.id,
    required this.status,
    required this.provider,
    required this.createdAt,
    this.providerTransactionId,
    this.message,
  });

  final String id;
  final PaymentStatus status;
  final String provider;
  final String? providerTransactionId;
  final String? message;
  final DateTime createdAt;

  factory PaymentAttempt.fromJson(Map<String, dynamic> json) => PaymentAttempt(
        id: json['id'] as String,
        status: PaymentStatus.fromInt(json['attemptStatus'] as int),
        provider: json['provider'] as String,
        providerTransactionId: json['providerTransactionId'] as String?,
        message: json['message'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}

class Payment {
  const Payment({
    required this.id,
    required this.compoundName,
    required this.targetType,
    required this.targetId,
    required this.paymentMethod,
    required this.status,
    required this.amount,
    required this.currency,
    required this.paymentReference,
    required this.createdAt,
    required this.attempts,
    this.targetReference,
    this.failureReason,
    this.completedAt,
    this.receipt,
  });

  final String id;
  final String compoundName;
  final PaymentTargetType targetType;
  final String targetId;
  final String? targetReference;
  final PaymentMethod paymentMethod;
  final PaymentStatus status;
  final double amount;
  final String currency;
  final String paymentReference;
  final String? failureReason;
  final DateTime createdAt;
  final DateTime? completedAt;
  final Receipt? receipt;
  final List<PaymentAttempt> attempts;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'] as String,
        compoundName: json['compoundName'] as String,
        targetType: PaymentTargetType.fromInt(json['targetType'] as int),
        targetId: json['targetId'] as String,
        targetReference: json['targetReference'] as String?,
        paymentMethod: PaymentMethod.fromInt(json['paymentMethod'] as int),
        status: PaymentStatus.fromInt(json['paymentStatus'] as int),
        amount: (json['amount'] as num).toDouble(),
        currency: json['currency'] as String,
        paymentReference: json['paymentReference'] as String,
        failureReason: json['failureReason'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        completedAt: json['completedAt'] == null ? null : DateTime.parse(json['completedAt'] as String),
        receipt: json['receipt'] == null ? null : Receipt.fromJson(json['receipt'] as Map<String, dynamic>),
        attempts: (json['attempts'] as List).map((e) => PaymentAttempt.fromJson(e as Map<String, dynamic>)).toList(),
      );
}
