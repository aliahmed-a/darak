import 'maintenance_priority.dart';
import 'maintenance_status.dart';

class MaintenanceRequest {
  const MaintenanceRequest({
    required this.id,
    required this.compoundName,
    required this.unitNumber,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.assignedToUserName,
    this.costEstimate,
    this.actualCost,
    this.resolutionNotes,
    this.updatedAt,
    this.assignedAt,
    this.startedAt,
    this.resolvedAt,
    this.closedAt,
    this.cancelledAt,
  });

  final String id;
  final String compoundName;
  final String unitNumber;
  final String? assignedToUserName;
  final String title;
  final String description;
  final MaintenancePriority priority;
  final MaintenanceStatus status;
  final double? costEstimate;
  final double? actualCost;
  final String? resolutionNotes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? assignedAt;
  final DateTime? startedAt;
  final DateTime? resolvedAt;
  final DateTime? closedAt;
  final DateTime? cancelledAt;

  factory MaintenanceRequest.fromJson(Map<String, dynamic> json) => MaintenanceRequest(
        id: json['id'] as String,
        compoundName: json['compoundName'] as String,
        unitNumber: json['unitNumber'] as String,
        assignedToUserName: json['assignedToUserName'] as String?,
        title: json['title'] as String,
        description: json['description'] as String,
        priority: MaintenancePriority.fromInt(json['priority'] as int),
        status: MaintenanceStatus.fromInt(json['status'] as int),
        costEstimate: (json['costEstimate'] as num?)?.toDouble(),
        actualCost: (json['actualCost'] as num?)?.toDouble(),
        resolutionNotes: json['resolutionNotes'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
        assignedAt: json['assignedAt'] == null ? null : DateTime.parse(json['assignedAt'] as String),
        startedAt: json['startedAt'] == null ? null : DateTime.parse(json['startedAt'] as String),
        resolvedAt: json['resolvedAt'] == null ? null : DateTime.parse(json['resolvedAt'] as String),
        closedAt: json['closedAt'] == null ? null : DateTime.parse(json['closedAt'] as String),
        cancelledAt: json['cancelledAt'] == null ? null : DateTime.parse(json['cancelledAt'] as String),
      );
}
