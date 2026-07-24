import 'notification_severity.dart';
import 'notification_type.dart';

class ResidentNotification {
  const ResidentNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.severity,
    required this.isRead,
    required this.createdAt,
    this.readAt,
  });

  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final NotificationSeverity severity;
  final bool isRead;
  final DateTime? readAt;
  final DateTime createdAt;

  factory ResidentNotification.fromJson(Map<String, dynamic> json) => ResidentNotification(
        id: json['id'] as String,
        title: json['title'] as String,
        message: json['message'] as String,
        type: NotificationType.fromInt(json['type'] as int),
        severity: NotificationSeverity.fromInt(json['severity'] as int),
        isRead: json['isRead'] as bool,
        readAt: json['readAt'] == null ? null : DateTime.parse(json['readAt'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
