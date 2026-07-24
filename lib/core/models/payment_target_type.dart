import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `PaymentTargetType` enum (int-serialized, declaration
/// order = ordinal).
enum PaymentTargetType {
  utilityBill,
  propertyInstallment,
  rentInvoice,
  violationFine,
  paymentPlanInstallment,
  propertySaleContract;

  static PaymentTargetType fromInt(int value) => PaymentTargetType.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      PaymentTargetType.utilityBill => l10n.paymentTargetTypeUtilityBill,
      PaymentTargetType.propertyInstallment => l10n.paymentTargetTypePropertyInstallment,
      PaymentTargetType.rentInvoice => l10n.paymentTargetTypeRentInvoice,
      PaymentTargetType.violationFine => l10n.paymentTargetTypeViolationFine,
      PaymentTargetType.paymentPlanInstallment => l10n.paymentTargetTypePaymentPlanInstallment,
      PaymentTargetType.propertySaleContract => l10n.paymentTargetTypePropertySaleContract,
    };
  }
}
