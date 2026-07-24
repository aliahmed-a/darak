import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../guard/presentation/screens/guard_account_screen.dart';
import '../../../guard/presentation/screens/guard_contractors_today_screen.dart';
import '../../../guard/presentation/screens/guard_visitors_today_screen.dart';

/// Guard-facing shell — mirrors [ResidentShell]'s IndexedStack + floating
/// nav pattern.
class GuardShell extends StatefulWidget {
  const GuardShell({super.key});

  @override
  State<GuardShell> createState() => _GuardShellState();
}

class _GuardShellState extends State<GuardShell> {
  int _index = 0;

  static const _tabs = [
    GuardVisitorsTodayScreen(),
    GuardContractorsTodayScreen(),
    GuardAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(color: scheme.shadow.withValues(alpha: 0.18), blurRadius: 20, offset: const Offset(0, 8)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: NavigationBar(
              height: 64,
              selectedIndex: _index,
              onDestinationSelected: (value) => setState(() => _index = value),
              destinations: [
                NavigationDestination(
                    icon: const Icon(Icons.badge_outlined), selectedIcon: const Icon(Icons.badge), label: l10n.navGuardVisitors),
                NavigationDestination(
                    icon: const Icon(Icons.engineering_outlined),
                    selectedIcon: const Icon(Icons.engineering),
                    label: l10n.navGuardContractors),
                NavigationDestination(
                    icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: l10n.navAccount),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
