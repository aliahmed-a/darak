import 'complaint_status.dart';

class Complaint {
  const Complaint({
    required this.id,
    required this.compoundName,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    this.unitNumber,
    this.adminResponse,
    this.updatedAt,
    this.resolvedAt,
    this.rejectedAt,
  });

  final String id;
  final String compoundName;
  final String? unitNumber;
  final String title;
  final String description;
  final ComplaintStatus status;
  final String? adminResponse;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? resolvedAt;
  final DateTime? rejectedAt;

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        id: json['id'] as String,
        compoundName: json['compoundName'] as String,
        unitNumber: json['unitNumber'] as String?,
        title: json['title'] as String,
        description: json['description'] as String,
        status: ComplaintStatus.fromInt(json['status'] as int),
        adminResponse: json['adminResponse'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
        resolvedAt: json['resolvedAt'] == null ? null : DateTime.parse(json['resolvedAt'] as String),
        rejectedAt: json['rejectedAt'] == null ? null : DateTime.parse(json['rejectedAt'] as String),
      );
}
