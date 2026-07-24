import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `MaintenancePriority` enum (int-serialized).
enum MaintenancePriority {
  low,
  medium,
  high,
  emergency;

  static MaintenancePriority fromInt(int value) => MaintenancePriority.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      MaintenancePriority.low => l10n.maintenancePriorityLow,
      MaintenancePriority.medium => l10n.maintenancePriorityMedium,
      MaintenancePriority.high => l10n.maintenancePriorityHigh,
      MaintenancePriority.emergency => l10n.maintenancePriorityEmergency,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        MaintenancePriority.low => Colors.blueGrey,
        MaintenancePriority.medium => Colors.orange,
        MaintenancePriority.high => Colors.deepOrange,
        MaintenancePriority.emergency => scheme.error,
      };
}
