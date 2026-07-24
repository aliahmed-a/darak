import '../../../../core/models/billing_status.dart';

class RentInvoice {
  const RentInvoice({
    required this.id,
    required this.compoundName,
    required this.unitNumber,
    required this.invoiceNumber,
    required this.year,
    required this.month,
    required this.issueDate,
    required this.dueDate,
    required this.rentAmount,
    required this.previousBalanceAmount,
    required this.lateFeeAmount,
    required this.discountAmount,
    required this.totalAmount,
    required this.paidAmount,
    required this.remainingAmount,
    required this.status,
    this.notes,
  });

  final String id;
  final String compoundName;
  final String unitNumber;
  final String invoiceNumber;
  final int year;
  final int month;
  final DateTime issueDate;
  final DateTime dueDate;
  final double rentAmount;
  final double previousBalanceAmount;
  final double lateFeeAmount;
  final double discountAmount;
  final double totalAmount;
  final double paidAmount;
  final double remainingAmount;
  final BillingStatus status;
  final String? notes;

  factory RentInvoice.fromJson(Map<String, dynamic> json) => RentInvoice(
        id: json['id'] as String,
        compoundName: json['compoundName'] as String,
        unitNumber: json['unitNumber'] as String,
        invoiceNumber: json['invoiceNumber'] as String,
        year: json['year'] as int,
        month: json['month'] as int,
        issueDate: DateTime.parse(json['issueDate'] as String),
        dueDate: DateTime.parse(json['dueDate'] as String),
        rentAmount: (json['rentAmount'] as num).toDouble(),
        previousBalanceAmount: (json['previousBalanceAmount'] as num).toDouble(),
        lateFeeAmount: (json['lateFeeAmount'] as num).toDouble(),
        discountAmount: (json['discountAmount'] as num).toDouble(),
        totalAmount: (json['totalAmount'] as num).toDouble(),
        paidAmount: (json['paidAmount'] as num).toDouble(),
        remainingAmount: (json['remainingAmount'] as num).toDouble(),
        status: BillingStatus.fromInt(json['rentInvoiceStatus'] as int),
        notes: json['notes'] as String?,
      );
}
