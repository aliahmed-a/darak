import 'resident_property_summary.dart';
import 'resident_recent_payment.dart';
import 'resident_upcoming_due_item.dart';

class ResidentDashboard {
  const ResidentDashboard({
    required this.residentProfileId,
    required this.residentName,
    required this.activePropertiesCount,
    required this.totalOutstandingAmount,
    required this.overdueAmount,
    required this.unpaidUtilityBillsCount,
    required this.overdueUtilityBillsCount,
    required this.pendingInstallmentsCount,
    required this.overdueInstallmentsCount,
    required this.unpaidRentInvoicesCount,
    required this.overdueRentInvoicesCount,
    required this.pendingPaymentsCount,
    required this.openMeterReadingsCount,
    required this.upcomingDueItems,
    required this.recentPayments,
    required this.properties,
  });

  final String residentProfileId;
  final String residentName;
  final int activePropertiesCount;
  final double totalOutstandingAmount;
  final double overdueAmount;
  final int unpaidUtilityBillsCount;
  final int overdueUtilityBillsCount;
  final int pendingInstallmentsCount;
  final int overdueInstallmentsCount;
  final int unpaidRentInvoicesCount;
  final int overdueRentInvoicesCount;
  final int pendingPaymentsCount;
  final int openMeterReadingsCount;
  final List<ResidentUpcomingDueItem> upcomingDueItems;
  final List<ResidentRecentPayment> recentPayments;
  final List<ResidentPropertySummary> properties;

  factory ResidentDashboard.fromJson(Map<String, dynamic> json) => ResidentDashboard(
        residentProfileId: json['residentProfileId'] as String,
        residentName: json['residentName'] as String,
        activePropertiesCount: json['activePropertiesCount'] as int,
        totalOutstandingAmount: (json['totalOutstandingAmount'] as num).toDouble(),
        overdueAmount: (json['overdueAmount'] as num).toDouble(),
        unpaidUtilityBillsCount: json['unpaidUtilityBillsCount'] as int,
        overdueUtilityBillsCount: json['overdueUtilityBillsCount'] as int,
        pendingInstallmentsCount: json['pendingInstallmentsCount'] as int,
        overdueInstallmentsCount: json['overdueInstallmentsCount'] as int,
        unpaidRentInvoicesCount: json['unpaidRentInvoicesCount'] as int,
        overdueRentInvoicesCount: json['overdueRentInvoicesCount'] as int,
        pendingPaymentsCount: json['pendingPaymentsCount'] as int,
        openMeterReadingsCount: json['openMeterReadingsCount'] as int,
        upcomingDueItems: (json['upcomingDueItems'] as List)
            .map((e) => ResidentUpcomingDueItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        recentPayments: (json['recentPayments'] as List)
            .map((e) => ResidentRecentPayment.fromJson(e as Map<String, dynamic>))
            .toList(),
        properties: (json['properties'] as List)
            .map((e) => ResidentPropertySummary.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
