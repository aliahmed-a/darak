import 'package:flutter/widgets.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `FinancialDisputeTargetType` enum (int-serialized,
/// explicitly numbered starting at 1 on the backend).
enum FinancialDisputeTargetType {
  utilityBill,
  payment,
  violationFine,
  rentInvoice,
  propertyInstallment,
  financialAdjustment;

  static FinancialDisputeTargetType fromInt(int value) => FinancialDisputeTargetType.values[value - 1];

  int get apiValue => FinancialDisputeTargetType.values.indexOf(this) + 1;

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      FinancialDisputeTargetType.utilityBill => l10n.financialDisputeTargetTypeUtilityBill,
      FinancialDisputeTargetType.payment => l10n.financialDisputeTargetTypePayment,
      FinancialDisputeTargetType.violationFine => l10n.financialDisputeTargetTypeViolationFine,
      FinancialDisputeTargetType.rentInvoice => l10n.financialDisputeTargetTypeRentInvoice,
      FinancialDisputeTargetType.propertyInstallment => l10n.financialDisputeTargetTypePropertyInstallment,
      FinancialDisputeTargetType.financialAdjustment => l10n.financialDisputeTargetTypeFinancialAdjustment,
    };
  }
}
