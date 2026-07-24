import 'package:flutter/widgets.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `DocumentCategory` enum (int-serialized,
/// 0-indexed on the backend).
enum DocumentCategory {
  residentIdentity,
  ownershipContract,
  leaseContract,
  paymentReceipt,
  maintenanceAttachment,
  complaintAttachment,
  violationAttachment,
  administrative,
  other;

  static DocumentCategory fromInt(int value) => DocumentCategory.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      DocumentCategory.residentIdentity => l10n.documentCategoryResidentIdentity,
      DocumentCategory.ownershipContract => l10n.documentCategoryOwnershipContract,
      DocumentCategory.leaseContract => l10n.documentCategoryLeaseContract,
      DocumentCategory.paymentReceipt => l10n.documentCategoryPaymentReceipt,
      DocumentCategory.maintenanceAttachment => l10n.documentCategoryMaintenanceAttachment,
      DocumentCategory.complaintAttachment => l10n.documentCategoryComplaintAttachment,
      DocumentCategory.violationAttachment => l10n.documentCategoryViolationAttachment,
      DocumentCategory.administrative => l10n.documentCategoryAdministrative,
      DocumentCategory.other => l10n.documentCategoryOther,
    };
  }
}
