import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../l10n/app_localizations.dart';

class RequestsHubScreen extends StatelessWidget {
  const RequestsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.requestsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HubTile(
            icon: Icons.build_outlined,
            title: l10n.requestsMaintenanceTitle,
            subtitle: l10n.requestsMaintenanceSubtitle,
            onTap: () => context.push(Routes.maintenance),
          ),
          const SizedBox(height: 12),
          _HubTile(
            icon: Icons.badge_outlined,
            title: l10n.requestsVisitorPassesTitle,
            subtitle: l10n.requestsVisitorPassesSubtitle,
            onTap: () => context.push(Routes.visitorPasses),
          ),
          const SizedBox(height: 12),
          _HubTile(
            icon: Icons.report_problem_outlined,
            title: l10n.requestsComplaintsTitle,
            subtitle: l10n.requestsComplaintsSubtitle,
            onTap: () => context.push(Routes.complaints),
          ),
        ],
      ),
    );
  }
}

class _HubTile extends StatelessWidget {
  const _HubTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: Icon(Directionality.of(context) == TextDirection.rtl ? Icons.chevron_left : Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
