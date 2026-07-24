import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class AccountHubScreen extends ConsumerWidget {
  const AccountHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).valueOrNull;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.accountTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (user != null)
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(user.fullName.isNotEmpty ? user.fullName[0] : '?')),
                title: Text(user.fullName),
                subtitle: Text(user.email),
              ),
            ),
          const SizedBox(height: 16),
          _HubTile(
            icon: Icons.family_restroom_outlined,
            title: l10n.accountFamilyMembers,
            onTap: () => context.push(Routes.familyMembers),
          ),
          const SizedBox(height: 8),
          _HubTile(
            icon: Icons.contact_phone_outlined,
            title: l10n.accountEmergencyContacts,
            onTap: () => context.push(Routes.emergencyContacts),
          ),
          const SizedBox(height: 8),
          _HubTile(
            icon: Icons.folder_outlined,
            title: l10n.accountDocuments,
            onTap: () => context.push(Routes.documents),
          ),
          const SizedBox(height: 16),
          _HubTile(
            icon: Icons.receipt_long_outlined,
            title: l10n.accountUtilityBills,
            onTap: () => context.push(Routes.bills),
          ),
          const SizedBox(height: 8),
          _HubTile(
            icon: Icons.home_work_outlined,
            title: l10n.accountRentInvoices,
            onTap: () => context.push(Routes.rent),
          ),
          const SizedBox(height: 8),
          _HubTile(
            icon: Icons.calendar_month_outlined,
            title: l10n.accountInstallments,
            onTap: () => context.push(Routes.installments),
          ),
          const SizedBox(height: 8),
          _HubTile(
            icon: Icons.payments_outlined,
            title: l10n.accountPaymentHistory,
            onTap: () => context.push(Routes.payments),
          ),
          const SizedBox(height: 8),
          _HubTile(
            icon: Icons.gavel_outlined,
            title: l10n.accountFinancialDisputes,
            onTap: () => context.push(Routes.financialDisputes),
          ),
          const SizedBox(height: 8),
          _HubTile(
            icon: Icons.report_gmailerrorred_outlined,
            title: l10n.accountViolationFines,
            onTap: () => context.push(Routes.violationFines),
          ),
          const SizedBox(height: 8),
          _HubTile(
            icon: Icons.balance_outlined,
            title: l10n.accountViolationAppeals,
            onTap: () => context.push(Routes.violationAppeals),
          ),
          const SizedBox(height: 16),
          _HubTile(
            icon: Icons.settings_outlined,
            title: l10n.accountSettings,
            onTap: () => context.push(Routes.settings),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            icon: const Icon(Icons.logout),
            label: Text(l10n.accountSignOut),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
    );
  }
}

class _HubTile extends StatelessWidget {
  const _HubTile({required this.icon, required this.title, required this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Icon(Directionality.of(context) == TextDirection.rtl ? Icons.chevron_left : Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
