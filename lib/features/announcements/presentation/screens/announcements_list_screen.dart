import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/announcement.dart';
import '../providers/announcements_provider.dart';

class AnnouncementsListScreen extends ConsumerWidget {
  const AnnouncementsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(announcementsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return AsyncValueView(
      value: state,
      onRetry: () => ref.invalidate(announcementsControllerProvider),
      data: (context, data) => PagedListView(
        state: data,
        emptyMessage: l10n.announcementsEmpty,
        onLoadMore: () => ref.read(announcementsControllerProvider.notifier).loadMore(),
        onRefresh: () => ref.read(announcementsControllerProvider.notifier).refresh(),
        itemBuilder: (context, announcement) => _AnnouncementCard(announcement: announcement),
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard({required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: announcement.isRead ? null : scheme.primaryContainer.withValues(alpha: 0.35),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.announcementDetail(announcement.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(announcement.category.icon, color: announcement.priority.color(scheme)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (announcement.isPinned) ...[
                          Icon(Icons.push_pin, size: 14, color: scheme.primary),
                          const SizedBox(width: 4),
                        ],
                        Expanded(
                          child: Text(
                            announcement.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      announcement.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      Formatters.date(announcement.publishedAt ?? announcement.createdAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
