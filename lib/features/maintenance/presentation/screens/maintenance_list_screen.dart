import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/maintenance_request.dart';
import '../providers/maintenance_provider.dart';

class MaintenanceListScreen extends ConsumerWidget {
  const MaintenanceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(maintenanceControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.maintenanceTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.createMaintenance),
        child: const Icon(Icons.add),
      ),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(maintenanceControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.maintenanceEmpty,
          onLoadMore: () => ref.read(maintenanceControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(maintenanceControllerProvider.notifier).refresh(),
          itemBuilder: (context, request) => _RequestCard(request: request),
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});

  final MaintenanceRequest request;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.maintenanceDetail(request.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(request.title, style: const TextStyle(fontWeight: FontWeight.w600))),
                  StatusChip(label: request.status.label(context), color: request.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 4),
              Text(l10n.unitOnly(request.unitNumber), style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusChip(label: request.priority.label(context), color: request.priority.color(scheme)),
                  Text(Formatters.date(request.createdAt), style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
