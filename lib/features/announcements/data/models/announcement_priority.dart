import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `AnnouncementPriority` enum (int-serialized).
enum AnnouncementPriority {
  low,
  normal,
  high,
  critical;

  static AnnouncementPriority fromInt(int value) => AnnouncementPriority.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      AnnouncementPriority.low => l10n.announcementPriorityLow,
      AnnouncementPriority.normal => l10n.announcementPriorityNormal,
      AnnouncementPriority.high => l10n.announcementPriorityHigh,
      AnnouncementPriority.critical => l10n.announcementPriorityCritical,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        AnnouncementPriority.low => scheme.outline,
        AnnouncementPriority.normal => Colors.blue,
        AnnouncementPriority.high => Colors.orange,
        AnnouncementPriority.critical => scheme.error,
      };
}
