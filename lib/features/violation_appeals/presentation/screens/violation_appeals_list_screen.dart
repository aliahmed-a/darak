import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/violation_appeal.dart';
import '../providers/violation_appeals_provider.dart';

class ViolationAppealsListScreen extends ConsumerWidget {
  const ViolationAppealsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(violationAppealsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.violationAppealsTitle)),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(violationAppealsControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.violationAppealsEmpty,
          onLoadMore: () => ref.read(violationAppealsControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(violationAppealsControllerProvider.notifier).refresh(),
          itemBuilder: (context, appeal) => _AppealCard(appeal: appeal),
        ),
      ),
    );
  }
}

class _AppealCard extends StatelessWidget {
  const _AppealCard({required this.appeal});

  final ViolationAppeal appeal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.violationAppealDetail(appeal.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(appeal.violationTitle, style: const TextStyle(fontWeight: FontWeight.w600))),
                  StatusChip(label: appeal.status.label(context), color: appeal.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 4),
              Text(appeal.reason, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Text(Formatters.date(appeal.createdAtUtc), style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
