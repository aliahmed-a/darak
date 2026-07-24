import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/guard_contractor_permit.dart';
import '../providers/guard_contractor_access_provider.dart';

class GuardContractorsTodayScreen extends ConsumerWidget {
  const GuardContractorsTodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(guardContractorsTodayControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.guardContractorsTitle)),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(guardContractorsTodayControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.guardContractorsEmpty,
          onLoadMore: () => ref.read(guardContractorsTodayControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(guardContractorsTodayControllerProvider.notifier).refresh(),
          itemBuilder: (context, permit) => _ContractorCard(permit: permit),
        ),
      ),
    );
  }
}

class _ContractorCard extends StatelessWidget {
  const _ContractorCard({required this.permit});

  final GuardContractorPermit permit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.guardContractorDetail(permit.id), extra: permit),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(permit.vendorName, style: const TextStyle(fontWeight: FontWeight.w600))),
                  StatusChip(label: permit.status.label(context), color: permit.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 4),
              Text(permit.workArea),
              const SizedBox(height: 8),
              Row(
                children: [
                  StatusChip(label: permit.riskLevel.label(context), color: permit.riskLevel.color(scheme)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      Formatters.dateTime(permit.allowedFromUtc),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
