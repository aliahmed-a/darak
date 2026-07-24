import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/visitor_pass.dart';
import '../providers/visitor_passes_provider.dart';

class VisitorPassesListScreen extends ConsumerWidget {
  const VisitorPassesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(visitorPassesControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.visitorPassesTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.createVisitorPass),
        child: const Icon(Icons.add),
      ),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(visitorPassesControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.visitorPassesEmpty,
          onLoadMore: () => ref.read(visitorPassesControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(visitorPassesControllerProvider.notifier).refresh(),
          itemBuilder: (context, pass) => _PassCard(pass: pass),
        ),
      ),
    );
  }
}

class _PassCard extends StatelessWidget {
  const _PassCard({required this.pass});

  final VisitorPass pass;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.visitorPassDetail(pass.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(pass.visitorName, style: const TextStyle(fontWeight: FontWeight.w600))),
                  StatusChip(label: pass.status.label(context), color: pass.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 4),
              Text(pass.visitReason, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Text(l10n.validDateRange(Formatters.dateTime(pass.validFrom), Formatters.dateTime(pass.validUntil))),
            ],
          ),
        ),
      ),
    );
  }
}
