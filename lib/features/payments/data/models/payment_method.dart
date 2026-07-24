import 'package:flutter/widgets.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `PaymentMethod` enum (int-serialized).
enum PaymentMethod {
  zainCashMock,
  masterCardMock,
  cash,
  bankTransfer,
  manualAdminPayment;

  static PaymentMethod fromInt(int value) => PaymentMethod.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      PaymentMethod.zainCashMock => l10n.paymentMethodZainCash,
      PaymentMethod.masterCardMock => l10n.paymentMethodMasterCard,
      PaymentMethod.cash => l10n.paymentMethodCash,
      PaymentMethod.bankTransfer => l10n.paymentMethodBankTransfer,
      PaymentMethod.manualAdminPayment => l10n.paymentMethodManualAdminPayment,
    };
  }
}
