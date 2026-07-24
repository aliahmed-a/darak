import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `ViolationFineStatus` enum (int-serialized,
/// 0-indexed on the backend).
enum ViolationFineStatus {
  unpaid,
  partiallyPaid,
  paid,
  cancelled;

  static ViolationFineStatus fromInt(int value) => ViolationFineStatus.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      ViolationFineStatus.unpaid => l10n.statusUnpaid,
      ViolationFineStatus.partiallyPaid => l10n.statusPartiallyPaid,
      ViolationFineStatus.paid => l10n.statusPaid,
      ViolationFineStatus.cancelled => l10n.statusCancelled,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        ViolationFineStatus.unpaid => scheme.error,
        ViolationFineStatus.partiallyPaid => Colors.orange,
        ViolationFineStatus.paid => Colors.green,
        ViolationFineStatus.cancelled => scheme.outline,
      };
}
