import 'violation_fine_status.dart';

class ViolationFine {
  const ViolationFine({
    required this.id,
    required this.violationId,
    required this.compoundName,
    required this.amount,
    required this.paidAmount,
    required this.remainingAmount,
    required this.status,
    required this.reason,
    required this.dueDate,
    required this.createdAt,
    this.updatedAt,
    this.cancelledAt,
    this.cancellationReason,
  });

  final String id;
  final String violationId;
  final String compoundName;
  final double amount;
  final double paidAmount;
  final double remainingAmount;
  final ViolationFineStatus status;
  final String reason;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? cancelledAt;
  final String? cancellationReason;

  factory ViolationFine.fromJson(Map<String, dynamic> json) => ViolationFine(
        id: json['id'] as String,
        violationId: json['violationId'] as String,
        compoundName: json['compoundName'] as String,
        amount: (json['amount'] as num).toDouble(),
        paidAmount: (json['paidAmount'] as num).toDouble(),
        remainingAmount: (json['remainingAmount'] as num).toDouble(),
        status: ViolationFineStatus.fromInt(json['status'] as int),
        reason: json['reason'] as String,
        dueDate: DateTime.parse(json['dueDate'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
        cancelledAt: json['cancelledAt'] == null ? null : DateTime.parse(json['cancelledAt'] as String),
        cancellationReason: json['cancellationReason'] as String?,
      );
}
