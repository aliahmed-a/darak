import '../../../../core/models/billing_status.dart';

class UtilityBillLine {
  const UtilityBillLine({
    required this.id,
    required this.compoundServiceId,
    required this.compoundServiceName,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
  });

  final String id;
  final String compoundServiceId;
  final String compoundServiceName;
  final String description;
  final double quantity;
  final double unitPrice;
  final double lineTotal;

  factory UtilityBillLine.fromJson(Map<String, dynamic> json) => UtilityBillLine(
        id: json['id'] as String,
        compoundServiceId: json['compoundServiceId'] as String,
        compoundServiceName: json['compoundServiceName'] as String,
        description: json['description'] as String,
        quantity: (json['quantity'] as num).toDouble(),
        unitPrice: (json['unitPrice'] as num).toDouble(),
        lineTotal: (json['lineTotal'] as num).toDouble(),
      );
}

class UtilityBill {
  const UtilityBill({
    required this.id,
    required this.compoundName,
    required this.unitNumber,
    required this.billingCycleYear,
    required this.billingCycleMonth,
    required this.billNumber,
    required this.status,
    required this.issueDate,
    required this.dueDate,
    required this.subtotalAmount,
    required this.previousBalanceAmount,
    required this.lateFeeAmount,
    required this.discountAmount,
    required this.totalAmount,
    required this.paidAmount,
    required this.remainingAmount,
    required this.lines,
    this.notes,
  });

  final String id;
  final String compoundName;
  final String unitNumber;
  final int billingCycleYear;
  final int billingCycleMonth;
  final String billNumber;
  final BillingStatus status;
  final DateTime issueDate;
  final DateTime dueDate;
  final double subtotalAmount;
  final double previousBalanceAmount;
  final double lateFeeAmount;
  final double discountAmount;
  final double totalAmount;
  final double paidAmount;
  final double remainingAmount;
  final String? notes;
  final List<UtilityBillLine> lines;

  factory UtilityBill.fromJson(Map<String, dynamic> json) => UtilityBill(
        id: json['id'] as String,
        compoundName: json['compoundName'] as String,
        unitNumber: json['unitNumber'] as String,
        billingCycleYear: json['billingCycleYear'] as int,
        billingCycleMonth: json['billingCycleMonth'] as int,
        billNumber: json['billNumber'] as String,
        status: BillingStatus.fromInt(json['billStatus'] as int),
        issueDate: DateTime.parse(json['issueDate'] as String),
        dueDate: DateTime.parse(json['dueDate'] as String),
        subtotalAmount: (json['subtotalAmount'] as num).toDouble(),
        previousBalanceAmount: (json['previousBalanceAmount'] as num).toDouble(),
        lateFeeAmount: (json['lateFeeAmount'] as num).toDouble(),
        discountAmount: (json['discountAmount'] as num).toDouble(),
        totalAmount: (json['totalAmount'] as num).toDouble(),
        paidAmount: (json['paidAmount'] as num).toDouble(),
        remainingAmount: (json['remainingAmount'] as num).toDouble(),
        notes: json['notes'] as String?,
        lines: (json['lines'] as List).map((e) => UtilityBillLine.fromJson(e as Map<String, dynamic>)).toList(),
      );
}
