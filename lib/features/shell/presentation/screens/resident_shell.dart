import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import 'account_hub_screen.dart';
import 'community_screen.dart';
import 'requests_hub_screen.dart';

class ResidentShell extends StatefulWidget {
  const ResidentShell({super.key});

  @override
  State<ResidentShell> createState() => _ResidentShellState();
}

class _ResidentShellState extends State<ResidentShell> {
  int _index = 0;

  static const _tabs = [
    DashboardScreen(),
    RequestsHubScreen(),
    CommunityScreen(),
    AccountHubScreen(),
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
                NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: l10n.navHome),
                NavigationDestination(icon: const Icon(Icons.assignment_outlined), selectedIcon: const Icon(Icons.assignment), label: l10n.navRequests),
                NavigationDestination(icon: const Icon(Icons.campaign_outlined), selectedIcon: const Icon(Icons.campaign), label: l10n.navCommunity),
                NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: l10n.navAccount),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
