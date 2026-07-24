/// Mirrors `DARAK.Api`'s `ResidentNotificationType` enum (int-serialized).
enum NotificationType {
  general,
  payment,
  maintenance,
  complaint,
  violation,
  visitor,
  reservation,
  announcement,
  system;

  static NotificationType fromInt(int value) => NotificationType.values[value];
}
