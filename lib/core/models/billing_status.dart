import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Shared lifecycle for utility bills, rent invoices, and sale installments
/// — all three backend enums (`BillStatus`, `RentInvoiceStatus`,
/// `InstallmentStatus`) declare the same five ordinals in the same order.
enum BillingStatus {
  unpaid,
  partiallyPaid,
  paid,
  overdue,
  cancelled;

  static BillingStatus fromInt(int value) => BillingStatus.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      BillingStatus.unpaid => l10n.statusUnpaid,
      BillingStatus.partiallyPaid => l10n.statusPartiallyPaid,
      BillingStatus.paid => l10n.statusPaid,
      BillingStatus.overdue => l10n.statusOverdue,
      BillingStatus.cancelled => l10n.statusCancelled,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        BillingStatus.paid => Colors.green,
        BillingStatus.overdue => scheme.error,
        BillingStatus.partiallyPaid => Colors.orange,
        BillingStatus.unpaid => scheme.outline,
        BillingStatus.cancelled => scheme.outline,
      };
}
