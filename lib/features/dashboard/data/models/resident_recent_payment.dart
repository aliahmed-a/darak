class ResidentRecentPayment {
  const ResidentRecentPayment({
    required this.paymentId,
    required this.paymentReference,
    required this.targetType,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.completedAt,
  });

  final String paymentId;
  final String paymentReference;
  final String targetType;
  final double amount;
  final String status;
  final DateTime createdAt;
  final DateTime? completedAt;

  factory ResidentRecentPayment.fromJson(Map<String, dynamic> json) => ResidentRecentPayment(
        paymentId: json['paymentId'] as String,
        paymentReference: json['paymentReference'] as String,
        targetType: json['targetType'] as String,
        amount: (json['amount'] as num).toDouble(),
        status: json['status'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        completedAt: json['completedAt'] == null ? null : DateTime.parse(json['completedAt'] as String),
      );
}
