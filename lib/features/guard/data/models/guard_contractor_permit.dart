import 'contractor_work_permit_risk_level.dart';
import 'contractor_work_permit_status.dart';

/// Guard-facing view of a contractor work permit
/// (`ContractorWorkPermitResponse` from `api/guard/access/contractors/...`).
/// No GET-by-id exists on the backend for this resource, so the detail
/// screen receives an instance of this class via navigation `extra` rather
/// than its own fetch provider.
class GuardContractorPermit {
  const GuardContractorPermit({
    required this.id,
    required this.compoundName,
    required this.vendorName,
    required this.purpose,
    required this.workArea,
    required this.riskLevel,
    required this.status,
    required this.allowedFromUtc,
    required this.allowedUntilUtc,
    required this.requiresEscort,
    required this.createdAtUtc,
    this.checkedInAtUtc,
    this.checkedOutAtUtc,
    this.guardNotes,
    this.denialReason,
  });

  final String id;
  final String compoundName;
  final String vendorName;
  final String purpose;
  final String workArea;
  final ContractorWorkPermitRiskLevel riskLevel;
  final ContractorWorkPermitStatus status;
  final DateTime allowedFromUtc;
  final DateTime allowedUntilUtc;
  final bool requiresEscort;
  final DateTime createdAtUtc;
  final DateTime? checkedInAtUtc;
  final DateTime? checkedOutAtUtc;
  final String? guardNotes;
  final String? denialReason;

  factory GuardContractorPermit.fromJson(Map<String, dynamic> json) => GuardContractorPermit(
        id: json['id'] as String,
        compoundName: json['compoundName'] as String,
        vendorName: json['vendorName'] as String,
        purpose: json['purpose'] as String,
        workArea: json['workArea'] as String,
        riskLevel: ContractorWorkPermitRiskLevel.fromInt(json['riskLevel'] as int),
        status: ContractorWorkPermitStatus.fromInt(json['status'] as int),
        allowedFromUtc: DateTime.parse(json['allowedFromUtc'] as String),
        allowedUntilUtc: DateTime.parse(json['allowedUntilUtc'] as String),
        requiresEscort: json['requiresEscort'] as bool,
        createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
        checkedInAtUtc: json['checkedInAtUtc'] == null ? null : DateTime.parse(json['checkedInAtUtc'] as String),
        checkedOutAtUtc: json['checkedOutAtUtc'] == null ? null : DateTime.parse(json['checkedOutAtUtc'] as String),
        guardNotes: json['guardNotes'] as String?,
        denialReason: json['denialReason'] as String?,
      );
}
