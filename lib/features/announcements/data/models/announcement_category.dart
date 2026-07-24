import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `AnnouncementCategory` enum (int-serialized).
enum AnnouncementCategory {
  general,
  maintenance,
  utility,
  payment,
  security,
  event,
  emergency,
  rule,
  other;

  static AnnouncementCategory fromInt(int value) => AnnouncementCategory.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      AnnouncementCategory.general => l10n.announcementCategoryGeneral,
      AnnouncementCategory.maintenance => l10n.announcementCategoryMaintenance,
      AnnouncementCategory.utility => l10n.announcementCategoryUtility,
      AnnouncementCategory.payment => l10n.announcementCategoryPayment,
      AnnouncementCategory.security => l10n.announcementCategorySecurity,
      AnnouncementCategory.event => l10n.announcementCategoryEvent,
      AnnouncementCategory.emergency => l10n.announcementCategoryEmergency,
      AnnouncementCategory.rule => l10n.announcementCategoryRule,
      AnnouncementCategory.other => l10n.announcementCategoryOther,
    };
  }

  IconData get icon => switch (this) {
        AnnouncementCategory.general => Icons.campaign_outlined,
        AnnouncementCategory.maintenance => Icons.build_outlined,
        AnnouncementCategory.utility => Icons.bolt_outlined,
        AnnouncementCategory.payment => Icons.payments_outlined,
        AnnouncementCategory.security => Icons.shield_outlined,
        AnnouncementCategory.event => Icons.event_outlined,
        AnnouncementCategory.emergency => Icons.warning_amber_outlined,
        AnnouncementCategory.rule => Icons.gavel_outlined,
        AnnouncementCategory.other => Icons.info_outline,
      };
}
