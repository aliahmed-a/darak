import 'package:flutter/material.dart';

/// Mirrors `DARAK.Api`'s `ResidentNotificationSeverity` enum (int-serialized).
enum NotificationSeverity {
  info,
  success,
  warning,
  error,
  critical;

  static NotificationSeverity fromInt(int value) => NotificationSeverity.values[value];

  Color color(ColorScheme scheme) => switch (this) {
        NotificationSeverity.info => Colors.blue,
        NotificationSeverity.success => Colors.green,
        NotificationSeverity.warning => Colors.orange,
        NotificationSeverity.error => scheme.error,
        NotificationSeverity.critical => scheme.error,
      };

  IconData get icon => switch (this) {
        NotificationSeverity.info => Icons.info_outline,
        NotificationSeverity.success => Icons.check_circle_outline,
        NotificationSeverity.warning => Icons.warning_amber_outlined,
        NotificationSeverity.error => Icons.error_outline,
        NotificationSeverity.critical => Icons.report_gmailerrorred_outlined,
      };
}
