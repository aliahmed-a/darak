import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `PaymentStatus` enum (int-serialized).
enum PaymentStatus {
  pending,
  succeeded,
  failed,
  cancelled,
  refunded;

  static PaymentStatus fromInt(int value) => PaymentStatus.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      PaymentStatus.pending => l10n.paymentStatusPending,
      PaymentStatus.succeeded => l10n.paymentStatusSucceeded,
      PaymentStatus.failed => l10n.paymentStatusFailed,
      PaymentStatus.cancelled => l10n.paymentStatusCancelled,
      PaymentStatus.refunded => l10n.paymentStatusRefunded,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        PaymentStatus.succeeded => Colors.green,
        PaymentStatus.failed => scheme.error,
        PaymentStatus.pending => Colors.orange,
        PaymentStatus.cancelled => scheme.outline,
        PaymentStatus.refunded => scheme.outline,
      };
}
