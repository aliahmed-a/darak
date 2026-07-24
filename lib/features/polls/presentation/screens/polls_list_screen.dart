import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/community_poll.dart';
import '../providers/polls_provider.dart';

class PollsListScreen extends ConsumerWidget {
  const PollsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pollsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return AsyncValueView(
      value: state,
      onRetry: () => ref.invalidate(pollsControllerProvider),
      data: (context, data) => PagedListView(
        state: data,
        emptyMessage: l10n.pollsEmpty,
        onLoadMore: () => ref.read(pollsControllerProvider.notifier).loadMore(),
        onRefresh: () => ref.read(pollsControllerProvider.notifier).refresh(),
        itemBuilder: (context, poll) => _PollCard(poll: poll),
      ),
    );
  }
}

class _PollCard extends StatelessWidget {
  const _PollCard({required this.poll});

  final CommunityPoll poll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.pollDetail(poll.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(poll.question, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.pollCloses(Formatters.date(poll.endsAt)), style: Theme.of(context).textTheme.bodySmall),
                  if (poll.hasVoted)
                    Text(l10n.pollVoted, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
