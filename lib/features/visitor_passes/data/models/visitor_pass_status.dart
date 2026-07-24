import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `VisitorPassStatus` enum (int-serialized).
enum VisitorPassStatus {
  pending,
  approved,
  checkedIn,
  checkedOut,
  expired,
  cancelled,
  denied;

  static VisitorPassStatus fromInt(int value) => VisitorPassStatus.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      VisitorPassStatus.pending => l10n.visitorPassStatusPending,
      VisitorPassStatus.approved => l10n.visitorPassStatusApproved,
      VisitorPassStatus.checkedIn => l10n.visitorPassStatusCheckedIn,
      VisitorPassStatus.checkedOut => l10n.visitorPassStatusCheckedOut,
      VisitorPassStatus.expired => l10n.visitorPassStatusExpired,
      VisitorPassStatus.cancelled => l10n.visitorPassStatusCancelled,
      VisitorPassStatus.denied => l10n.visitorPassStatusDenied,
    };
  }

  bool get canCancel => this == VisitorPassStatus.pending || this == VisitorPassStatus.approved;

  Color color(ColorScheme scheme) => switch (this) {
        VisitorPassStatus.pending => Colors.orange,
        VisitorPassStatus.approved => Colors.blue,
        VisitorPassStatus.checkedIn => Colors.green,
        VisitorPassStatus.checkedOut => scheme.outline,
        VisitorPassStatus.expired => scheme.outline,
        VisitorPassStatus.cancelled => scheme.outline,
        VisitorPassStatus.denied => scheme.error,
      };
}
