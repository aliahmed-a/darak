import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `ContractorWorkPermitRiskLevel` enum (int-serialized).
enum ContractorWorkPermitRiskLevel {
  low,
  medium,
  high,
  critical;

  static ContractorWorkPermitRiskLevel fromInt(int value) => ContractorWorkPermitRiskLevel.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      ContractorWorkPermitRiskLevel.low => l10n.contractorRiskLevelLow,
      ContractorWorkPermitRiskLevel.medium => l10n.contractorRiskLevelMedium,
      ContractorWorkPermitRiskLevel.high => l10n.contractorRiskLevelHigh,
      ContractorWorkPermitRiskLevel.critical => l10n.contractorRiskLevelCritical,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        ContractorWorkPermitRiskLevel.low => Colors.green,
        ContractorWorkPermitRiskLevel.medium => Colors.orange,
        ContractorWorkPermitRiskLevel.high => Colors.deepOrange,
        ContractorWorkPermitRiskLevel.critical => scheme.error,
      };
}
