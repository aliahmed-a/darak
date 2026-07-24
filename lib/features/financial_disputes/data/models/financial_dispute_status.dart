import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `FinancialDisputeStatus` enum (int-serialized,
/// explicitly numbered starting at 1 on the backend).
enum FinancialDisputeStatus {
  open,
  underReview,
  needResidentResponse,
  accepted,
  rejected,
  resolved,
  cancelled;

  static FinancialDisputeStatus fromInt(int value) => FinancialDisputeStatus.values[value - 1];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      FinancialDisputeStatus.open => l10n.financialDisputeStatusOpen,
      FinancialDisputeStatus.underReview => l10n.financialDisputeStatusUnderReview,
      FinancialDisputeStatus.needResidentResponse => l10n.financialDisputeStatusNeedResidentResponse,
      FinancialDisputeStatus.accepted => l10n.financialDisputeStatusAccepted,
      FinancialDisputeStatus.rejected => l10n.financialDisputeStatusRejected,
      FinancialDisputeStatus.resolved => l10n.financialDisputeStatusResolved,
      FinancialDisputeStatus.cancelled => l10n.financialDisputeStatusCancelled,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        FinancialDisputeStatus.open => Colors.blue,
        FinancialDisputeStatus.underReview => Colors.orange,
        FinancialDisputeStatus.needResidentResponse => Colors.deepOrange,
        FinancialDisputeStatus.accepted => Colors.green,
        FinancialDisputeStatus.rejected => scheme.error,
        FinancialDisputeStatus.resolved => Colors.green,
        FinancialDisputeStatus.cancelled => scheme.error,
      };
}
