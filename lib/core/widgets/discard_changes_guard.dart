import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Asks before backing out of a partly filled form.
///
/// Nothing in the app used to intercept the back gesture, so a resident who
/// had typed half a complaint and hit back lost it with no warning. Wrap a
/// form screen's [Scaffold] in this and give it a callback reporting whether
/// anything's been entered yet.
///
/// [isDirty] is a callback rather than a plain bool on purpose: typing into a
/// [TextEditingController] doesn't rebuild the screen, so a value read at
/// build time is stale by the time the user hits back. For the same reason
/// `canPop` stays false and an unmodified form is popped manually below.
class DiscardChangesGuard extends StatelessWidget {
  const DiscardChangesGuard({super.key, required this.isDirty, required this.child});

  final ValueGetter<bool> isDirty;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final navigator = Navigator.of(context);
        if (!isDirty()) {
          navigator.pop();
          return;
        }
        if (await _confirm(context)) navigator.pop();
      },
      child: child,
    );
  }

  Future<bool> _confirm(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.discardChangesTitle),
        content: Text(l10n.discardChangesBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.commonKeepEditing),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
            child: Text(l10n.commonDiscard),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
