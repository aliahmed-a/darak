import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/announcement.dart';
import '../providers/announcements_provider.dart';

class AnnouncementDetailScreen extends ConsumerStatefulWidget {
  const AnnouncementDetailScreen({super.key, required this.announcementId});

  final String announcementId;

  @override
  ConsumerState<AnnouncementDetailScreen> createState() => _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends ConsumerState<AnnouncementDetailScreen> {
  bool _markedRead = false;

  void _maybeMarkRead(Announcement announcement) {
    if (_markedRead || announcement.isRead) return;
    _markedRead = true;
    ref.read(announcementsApiProvider).markRead(announcement.id).then((_) {
      ref.invalidate(announcementsControllerProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final announcement = ref.watch(announcementDetailProvider(widget.announcementId));
    final l10n = AppLocalizations.of(context)!;

    ref.listen(announcementDetailProvider(widget.announcementId), (previous, next) {
      final data = next.valueOrNull;
      if (data != null) _maybeMarkRead(data);
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.announcementDetailTitle)),
      body: AsyncValueView(
        value: announcement,
        onRetry: () => ref.invalidate(announcementDetailProvider(widget.announcementId)),
        data: (context, data) => _DetailContent(announcement: data),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Icon(announcement.category.icon, color: announcement.priority.color(scheme)),
            const SizedBox(width: 8),
            Expanded(child: Text(announcement.title, style: Theme.of(context).textTheme.titleLarge)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            StatusChip(label: announcement.category.label(context), color: scheme.primary),
            const SizedBox(width: 8),
            StatusChip(label: announcement.priority.label(context), color: announcement.priority.color(scheme)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          Formatters.date(announcement.publishedAt ?? announcement.createdAt),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        Text(announcement.body, style: Theme.of(context).textTheme.bodyLarge),
        if (announcement.expiresAt != null) ...[
          const SizedBox(height: 16),
          Text(l10n.announcementExpires(Formatters.date(announcement.expiresAt!)), style: Theme.of(context).textTheme.bodySmall),
        ],
      ],
    );
  }
}
