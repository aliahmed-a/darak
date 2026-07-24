import 'visitor_access_action.dart';

class GuardAccessLog {
  const GuardAccessLog({
    required this.id,
    required this.visitorPassId,
    required this.action,
    required this.createdAt,
    this.guardName,
    this.notes,
  });

  final String id;
  final String visitorPassId;
  final VisitorAccessAction action;
  final DateTime createdAt;
  final String? guardName;
  final String? notes;

  factory GuardAccessLog.fromJson(Map<String, dynamic> json) => GuardAccessLog(
        id: json['id'] as String,
        visitorPassId: json['visitorPassId'] as String,
        action: VisitorAccessAction.fromInt(json['action'] as int),
        createdAt: DateTime.parse(json['createdAt'] as String),
        guardName: json['guardName'] as String?,
        notes: json['notes'] as String?,
      );
}
