import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `ComplaintStatus` enum (int-serialized).
enum ComplaintStatus {
  open,
  underReview,
  resolved,
  rejected,
  convertedToViolation;

  static ComplaintStatus fromInt(int value) => ComplaintStatus.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      ComplaintStatus.open => l10n.complaintStatusOpen,
      ComplaintStatus.underReview => l10n.complaintStatusUnderReview,
      ComplaintStatus.resolved => l10n.complaintStatusResolved,
      ComplaintStatus.rejected => l10n.complaintStatusRejected,
      ComplaintStatus.convertedToViolation => l10n.complaintStatusConvertedToViolation,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        ComplaintStatus.open => Colors.blue,
        ComplaintStatus.underReview => Colors.orange,
        ComplaintStatus.resolved => Colors.green,
        ComplaintStatus.rejected => scheme.error,
        ComplaintStatus.convertedToViolation => scheme.error,
      };
}
