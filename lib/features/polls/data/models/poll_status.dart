import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Mirrors `DARAK.Api`'s `CommunityPollStatus` enum (int-serialized).
enum PollStatus {
  draft,
  open,
  closed,
  archived;

  static PollStatus fromInt(int value) => PollStatus.values[value];

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      PollStatus.draft => l10n.pollStatusDraft,
      PollStatus.open => l10n.pollStatusOpen,
      PollStatus.closed => l10n.pollStatusClosed,
      PollStatus.archived => l10n.pollStatusArchived,
    };
  }

  Color color(ColorScheme scheme) => switch (this) {
        PollStatus.draft => scheme.outline,
        PollStatus.open => Colors.green,
        PollStatus.closed => scheme.outline,
        PollStatus.archived => scheme.outline,
      };
}
