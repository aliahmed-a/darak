import 'financial_dispute_status.dart';
import 'financial_dispute_target_type.dart';

class FinancialDispute {
  const FinancialDispute({
    required this.id,
    required this.targetType,
    required this.targetId,
    required this.targetReference,
    required this.status,
    required this.reason,
    required this.residentMessage,
    required this.createdAtUtc,
    this.targetAmount,
    this.adminDecisionNotes,
    this.resolutionSummary,
    this.updatedAtUtc,
    this.reviewedAtUtc,
    this.resolvedAtUtc,
    this.cancelledAtUtc,
  });

  final String id;
  final FinancialDisputeTargetType targetType;
  final String targetId;
  final String targetReference;
  final double? targetAmount;
  final FinancialDisputeStatus status;
  final String reason;
  final String residentMessage;
  final String? adminDecisionNotes;
  final String? resolutionSummary;
  final DateTime createdAtUtc;
  final DateTime? updatedAtUtc;
  final DateTime? reviewedAtUtc;
  final DateTime? resolvedAtUtc;
  final DateTime? cancelledAtUtc;

  factory FinancialDispute.fromJson(Map<String, dynamic> json) => FinancialDispute(
        id: json['id'] as String,
        targetType: FinancialDisputeTargetType.fromInt(json['targetType'] as int),
        targetId: json['targetId'] as String,
        targetReference: json['targetReference'] as String,
        targetAmount: (json['targetAmount'] as num?)?.toDouble(),
        status: FinancialDisputeStatus.fromInt(json['status'] as int),
        reason: json['reason'] as String,
        residentMessage: json['residentMessage'] as String,
        adminDecisionNotes: json['adminDecisionNotes'] as String?,
        resolutionSummary: json['resolutionSummary'] as String?,
        createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
        updatedAtUtc: json['updatedAtUtc'] == null ? null : DateTime.parse(json['updatedAtUtc'] as String),
        reviewedAtUtc: json['reviewedAtUtc'] == null ? null : DateTime.parse(json['reviewedAtUtc'] as String),
        resolvedAtUtc: json['resolvedAtUtc'] == null ? null : DateTime.parse(json['resolvedAtUtc'] as String),
        cancelledAtUtc: json['cancelledAtUtc'] == null ? null : DateTime.parse(json['cancelledAtUtc'] as String),
      );
}
