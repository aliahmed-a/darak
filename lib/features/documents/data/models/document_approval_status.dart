import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `DocumentApprovalStatus` enum (int-serialized,
/// explicitly numbered starting at 1 on the backend).
enum DocumentApprovalStatus {
  notRequired,
  pendingReview,
  approved,
  rejected;

  static DocumentApprovalStatus fromInt(int value) => DocumentApprovalStatus.values[value - 1];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      DocumentApprovalStatus.notRequired => l10n.documentApprovalStatusNotRequired,
      DocumentApprovalStatus.pendingReview => l10n.documentApprovalStatusPendingReview,
      DocumentApprovalStatus.approved => l10n.documentApprovalStatusApproved,
      DocumentApprovalStatus.rejected => l10n.documentApprovalStatusRejected,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        DocumentApprovalStatus.notRequired => scheme.outline,
        DocumentApprovalStatus.pendingReview => Colors.orange,
        DocumentApprovalStatus.approved => Colors.green,
        DocumentApprovalStatus.rejected => scheme.error,
      };
}
