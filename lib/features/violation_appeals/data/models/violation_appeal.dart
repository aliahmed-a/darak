import 'violation_appeal_status.dart';

class ViolationAppeal {
  const ViolationAppeal({
    required this.id,
    required this.violationId,
    required this.violationTitle,
    required this.status,
    required this.reason,
    required this.residentMessage,
    required this.createdAtUtc,
    this.violationFineId,
    this.fineAmount,
    this.adminDecisionNotes,
    this.reducedFineAmount,
    this.updatedAtUtc,
    this.reviewedAtUtc,
  });

  final String id;
  final String violationId;
  final String? violationFineId;
  final String violationTitle;
  final double? fineAmount;
  final ViolationAppealStatus status;
  final String reason;
  final String residentMessage;
  final String? adminDecisionNotes;
  final double? reducedFineAmount;
  final DateTime createdAtUtc;
  final DateTime? updatedAtUtc;
  final DateTime? reviewedAtUtc;

  factory ViolationAppeal.fromJson(Map<String, dynamic> json) => ViolationAppeal(
        id: json['id'] as String,
        violationId: json['violationId'] as String,
        violationFineId: json['violationFineId'] as String?,
        violationTitle: json['violationTitle'] as String,
        fineAmount: (json['fineAmount'] as num?)?.toDouble(),
        status: ViolationAppealStatus.fromInt(json['status'] as int),
        reason: json['reason'] as String,
        residentMessage: json['residentMessage'] as String,
        adminDecisionNotes: json['adminDecisionNotes'] as String?,
        reducedFineAmount: (json['reducedFineAmount'] as num?)?.toDouble(),
        createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
        updatedAtUtc: json['updatedAtUtc'] == null ? null : DateTime.parse(json['updatedAtUtc'] as String),
        reviewedAtUtc: json['reviewedAtUtc'] == null ? null : DateTime.parse(json['reviewedAtUtc'] as String),
      );
}
