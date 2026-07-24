import '../../../visitor_passes/data/models/visitor_pass_status.dart';

/// Guard-facing view of a visitor pass (`VisitorPassResponse` from
/// `api/guard/access/visitors/...`) — a superset of the resident-facing
/// `VisitorPass` model, adding who the visitor is here to see
/// (`residentName`/`unitNumber`), so it's a distinct model rather than a
/// reuse. The status enum itself is identical to the resident side and is
/// reused as-is.
class GuardVisitorPass {
  const GuardVisitorPass({
    required this.id,
    required this.residentName,
    required this.compoundName,
    required this.unitNumber,
    required this.visitorName,
    required this.visitorPhoneNumber,
    required this.visitReason,
    required this.accessCode,
    required this.status,
    required this.validFrom,
    required this.validUntil,
    required this.createdAt,
    this.updatedAt,
    this.checkedInAt,
    this.checkedOutAt,
    this.cancelledAt,
    this.denialReason,
  });

  final String id;
  final String residentName;
  final String compoundName;
  final String unitNumber;
  final String visitorName;
  final String visitorPhoneNumber;
  final String visitReason;
  final String accessCode;
  final VisitorPassStatus status;
  final DateTime validFrom;
  final DateTime validUntil;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? checkedInAt;
  final DateTime? checkedOutAt;
  final DateTime? cancelledAt;
  final String? denialReason;

  factory GuardVisitorPass.fromJson(Map<String, dynamic> json) => GuardVisitorPass(
        id: json['id'] as String,
        residentName: json['residentName'] as String,
        compoundName: json['compoundName'] as String,
        unitNumber: json['unitNumber'] as String,
        visitorName: json['visitorName'] as String,
        visitorPhoneNumber: json['visitorPhoneNumber'] as String,
        visitReason: json['visitReason'] as String,
        accessCode: json['accessCode'] as String,
        status: VisitorPassStatus.fromInt(json['status'] as int),
        validFrom: DateTime.parse(json['validFrom'] as String),
        validUntil: DateTime.parse(json['validUntil'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
        checkedInAt: json['checkedInAt'] == null ? null : DateTime.parse(json['checkedInAt'] as String),
        checkedOutAt: json['checkedOutAt'] == null ? null : DateTime.parse(json['checkedOutAt'] as String),
        cancelledAt: json['cancelledAt'] == null ? null : DateTime.parse(json['cancelledAt'] as String),
        denialReason: json['denialReason'] as String?,
      );
}
