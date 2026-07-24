import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `VisitorAccessAction` enum (int-serialized).
enum VisitorAccessAction {
  checkIn,
  checkOut,
  denied,
  verified,
  credentialFailed;

  static VisitorAccessAction fromInt(int value) => VisitorAccessAction.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      VisitorAccessAction.checkIn => l10n.visitorAccessActionCheckIn,
      VisitorAccessAction.checkOut => l10n.visitorAccessActionCheckOut,
      VisitorAccessAction.denied => l10n.visitorAccessActionDenied,
      VisitorAccessAction.verified => l10n.visitorAccessActionVerified,
      VisitorAccessAction.credentialFailed => l10n.visitorAccessActionCredentialFailed,
    };
  }

  IconData get icon => switch (this) {
        VisitorAccessAction.checkIn => Icons.login,
        VisitorAccessAction.checkOut => Icons.logout,
        VisitorAccessAction.denied => Icons.block,
        VisitorAccessAction.verified => Icons.check_circle_outline,
        VisitorAccessAction.credentialFailed => Icons.warning_amber_outlined,
      };
}
