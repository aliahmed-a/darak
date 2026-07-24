import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `MaintenanceStatus` enum (int-serialized).
enum MaintenanceStatus {
  open,
  assigned,
  inProgress,
  resolved,
  closed,
  rejected,
  cancelled;

  static MaintenanceStatus fromInt(int value) => MaintenanceStatus.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      MaintenanceStatus.open => l10n.maintenanceStatusOpen,
      MaintenanceStatus.assigned => l10n.maintenanceStatusAssigned,
      MaintenanceStatus.inProgress => l10n.maintenanceStatusInProgress,
      MaintenanceStatus.resolved => l10n.maintenanceStatusResolved,
      MaintenanceStatus.closed => l10n.maintenanceStatusClosed,
      MaintenanceStatus.rejected => l10n.maintenanceStatusRejected,
      MaintenanceStatus.cancelled => l10n.maintenanceStatusCancelled,
    };
  }

  bool get isTerminal => this == MaintenanceStatus.closed ||
      this == MaintenanceStatus.rejected ||
      this == MaintenanceStatus.cancelled;

  Color color(ColorScheme scheme) => switch (this) {
        MaintenanceStatus.open => Colors.blue,
        MaintenanceStatus.assigned => Colors.indigo,
        MaintenanceStatus.inProgress => Colors.orange,
        MaintenanceStatus.resolved => Colors.green,
        MaintenanceStatus.closed => scheme.outline,
        MaintenanceStatus.rejected => scheme.error,
        MaintenanceStatus.cancelled => scheme.outline,
      };
}
