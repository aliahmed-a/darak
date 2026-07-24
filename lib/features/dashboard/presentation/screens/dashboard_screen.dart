import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/resident_dashboard.dart';
import '../../data/models/resident_property_summary.dart';
import '../../data/models/resident_recent_payment.dart';
import '../../data/models/resident_upcoming_due_item.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(dashboardProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push(Routes.notifications),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardProvider.future),
        child: AsyncValueView(
          value: dashboard,
          onRetry: () => ref.invalidate(dashboardProvider),
          data: (context, data) => _DashboardContent(dashboard: data),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.dashboard});

  final ResidentDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.dashboardWelcome(dashboard.residentName),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _OutstandingCard(dashboard: dashboard),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _CountTile(
                icon: Icons.receipt_long_outlined,
                label: l10n.dashboardUnpaidBills,
                count: dashboard.unpaidUtilityBillsCount,
                onTap: () => context.push(Routes.bills),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _CountTile(
                icon: Icons.home_work_outlined,
                label: l10n.dashboardRentDue,
                count: dashboard.unpaidRentInvoicesCount,
                onTap: () => context.push(Routes.rent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _CountTile(
                icon: Icons.calendar_month_outlined,
                label: l10n.dashboardInstallments,
                count: dashboard.pendingInstallmentsCount,
                onTap: () => context.push(Routes.installments),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _CountTile(
                icon: Icons.payments_outlined,
                label: l10n.dashboardPayments,
                count: dashboard.pendingPaymentsCount,
                onTap: () => context.push(Routes.payments),
              ),
            ),
          ],
        ),
        if (dashboard.upcomingDueItems.isNotEmpty) ...[
          const SizedBox(height: 24),
          _SectionHeader(l10n.dashboardUpcomingDue),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: dashboard.upcomingDueItems
                  .map((item) => _UpcomingDueTile(item: item))
                  .toList(growable: false),
            ),
          ),
        ],
        if (dashboard.recentPayments.isNotEmpty) ...[
          const SizedBox(height: 24),
          _SectionHeader(l10n.dashboardRecentPayments),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: dashboard.recentPayments
                  .map((payment) => _RecentPaymentTile(payment: payment))
                  .toList(growable: false),
            ),
          ),
        ],
        if (dashboard.properties.isNotEmpty) ...[
          const SizedBox(height: 24),
          _SectionHeader(l10n.dashboardYourProperties),
          const SizedBox(height: 8),
          ...dashboard.properties.map((property) => _PropertyCard(property: property)),
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}

class _OutstandingCard extends StatelessWidget {
  const _OutstandingCard({required this.dashboard});

  final ResidentDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final gradient = AppTheme.heroGradient(Theme.of(context).brightness);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: AppTheme.seedColor.withValues(alpha: 0.28), blurRadius: 24, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.dashboardTotalOutstanding, style: TextStyle(color: Colors.white.withValues(alpha: 0.85))),
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), shape: BoxShape.circle),
                child: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 17),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            Formatters.currency(dashboard.totalOutstandingAmount),
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
          ),
          if (dashboard.overdueAmount > 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning_amber_rounded, size: 15, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    l10n.amountOverdue(Formatters.currency(dashboard.overdueAmount)),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CountTile extends StatelessWidget {
  const _CountTile({required this.icon, required this.label, required this.count, required this.onTap});

  final IconData icon;
  final String label;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: scheme.primaryContainer, shape: BoxShape.circle),
                child: Icon(icon, color: scheme.onPrimaryContainer, size: 18),
              ),
              const SizedBox(height: 10),
              Text('$count', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              Text(label, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _UpcomingDueTile extends StatelessWidget {
  const _UpcomingDueTile({required this.item});

  final ResidentUpcomingDueItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListTile(
      title: Text(item.label),
      subtitle: Text('${item.type} · ${l10n.dueDate(Formatters.date(item.dueDate))}'),
      trailing: Text(
        Formatters.currency(item.amount),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _RecentPaymentTile extends StatelessWidget {
  const _RecentPaymentTile({required this.payment});

  final ResidentRecentPayment payment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push(Routes.paymentDetail(payment.paymentId)),
      title: Text(payment.paymentReference),
      subtitle: Text('${payment.targetType} · ${payment.status}'),
      trailing: Text(Formatters.currency(payment.amount)),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({required this.property});

  final ResidentPropertySummary property;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.door_front_door_outlined),
        title: Text(l10n.unitOnly(property.unitNumber)),
        subtitle: Text(
          [
            if (property.buildingName != null) property.buildingName,
            property.propertyType,
            property.occupancyType,
          ].join(' · '),
        ),
        trailing: Text(property.unitStatus),
      ),
    );
  }
}
