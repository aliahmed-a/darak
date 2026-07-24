import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `ViolationAppealStatus` enum (int-serialized,
/// explicitly numbered starting at 1 on the backend).
enum ViolationAppealStatus {
  submitted,
  underReview,
  needResidentResponse,
  accepted,
  rejected,
  fineReduced,
  fineCancelled,
  cancelled;

  static ViolationAppealStatus fromInt(int value) => ViolationAppealStatus.values[value - 1];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      ViolationAppealStatus.submitted => l10n.violationAppealStatusSubmitted,
      ViolationAppealStatus.underReview => l10n.violationAppealStatusUnderReview,
      ViolationAppealStatus.needResidentResponse => l10n.violationAppealStatusNeedResidentResponse,
      ViolationAppealStatus.accepted => l10n.violationAppealStatusAccepted,
      ViolationAppealStatus.rejected => l10n.violationAppealStatusRejected,
      ViolationAppealStatus.fineReduced => l10n.violationAppealStatusFineReduced,
      ViolationAppealStatus.fineCancelled => l10n.violationAppealStatusFineCancelled,
      ViolationAppealStatus.cancelled => l10n.violationAppealStatusCancelled,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        ViolationAppealStatus.submitted => Colors.blue,
        ViolationAppealStatus.underReview => Colors.orange,
        ViolationAppealStatus.needResidentResponse => Colors.deepOrange,
        ViolationAppealStatus.accepted => Colors.green,
        ViolationAppealStatus.rejected => scheme.error,
        ViolationAppealStatus.fineReduced => Colors.green,
        ViolationAppealStatus.fineCancelled => Colors.green,
        ViolationAppealStatus.cancelled => scheme.error,
      };
}
