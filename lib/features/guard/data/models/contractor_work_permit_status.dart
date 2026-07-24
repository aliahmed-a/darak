import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `ContractorWorkPermitStatus` enum (int-serialized).
/// Not parallel to `VisitorPassStatus` (different member count/order).
enum ContractorWorkPermitStatus {
  pendingApproval,
  approved,
  denied,
  checkedIn,
  checkedOut,
  closed,
  cancelled,
  expired;

  static ContractorWorkPermitStatus fromInt(int value) => ContractorWorkPermitStatus.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      ContractorWorkPermitStatus.pendingApproval => l10n.contractorStatusPendingApproval,
      ContractorWorkPermitStatus.approved => l10n.contractorStatusApproved,
      ContractorWorkPermitStatus.denied => l10n.contractorStatusDenied,
      ContractorWorkPermitStatus.checkedIn => l10n.contractorStatusCheckedIn,
      ContractorWorkPermitStatus.checkedOut => l10n.contractorStatusCheckedOut,
      ContractorWorkPermitStatus.closed => l10n.contractorStatusClosed,
      ContractorWorkPermitStatus.cancelled => l10n.contractorStatusCancelled,
      ContractorWorkPermitStatus.expired => l10n.contractorStatusExpired,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        ContractorWorkPermitStatus.pendingApproval => Colors.orange,
        ContractorWorkPermitStatus.approved => Colors.blue,
        ContractorWorkPermitStatus.denied => scheme.error,
        ContractorWorkPermitStatus.checkedIn => Colors.green,
        ContractorWorkPermitStatus.checkedOut => scheme.outline,
        ContractorWorkPermitStatus.closed => scheme.outline,
        ContractorWorkPermitStatus.cancelled => scheme.outline,
        ContractorWorkPermitStatus.expired => scheme.outline,
      };
}
