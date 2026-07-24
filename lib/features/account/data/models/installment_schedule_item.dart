import '../../../../core/models/billing_status.dart';

class InstallmentScheduleItem {
  const InstallmentScheduleItem({
    required this.id,
    required this.compoundName,
    required this.unitNumber,
    required this.installmentNumber,
    required this.dueDate,
    required this.amount,
    required this.paidAmount,
    required this.remainingAmount,
    required this.status,
  });

  final String id;
  final String compoundName;
  final String unitNumber;
  final int installmentNumber;
  final DateTime dueDate;
  final double amount;
  final double paidAmount;
  final double remainingAmount;
  final BillingStatus status;

  factory InstallmentScheduleItem.fromJson(Map<String, dynamic> json) => InstallmentScheduleItem(
        id: json['id'] as String,
        compoundName: json['compoundName'] as String,
        unitNumber: json['unitNumber'] as String,
        installmentNumber: json['installmentNumber'] as int,
        dueDate: DateTime.parse(json['dueDate'] as String),
        amount: (json['amount'] as num).toDouble(),
        paidAmount: (json['paidAmount'] as num).toDouble(),
        remainingAmount: (json['remainingAmount'] as num).toDouble(),
        status: BillingStatus.fromInt(json['installmentStatus'] as int),
      );
}
