import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/resident_notification.dart';
import '../providers/notifications_provider.dart';

class NotificationsListScreen extends ConsumerWidget {
  const NotificationsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notificationsTitle),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(notificationsApiProvider).markAllRead();
              ref.invalidate(notificationsControllerProvider);
            },
            child: Text(l10n.notificationsMarkAllRead),
          ),
        ],
      ),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(notificationsControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.notificationsEmpty,
          onLoadMore: () => ref.read(notificationsControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(notificationsControllerProvider.notifier).refresh(),
          itemBuilder: (context, notification) => _NotificationTile(notification: notification),
        ),
      ),
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  const _NotificationTile({required this.notification});

  final ResidentNotification notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: notification.isRead ? null : scheme.primaryContainer.withValues(alpha: 0.35),
      child: ListTile(
        leading: Icon(notification.severity.icon, color: notification.severity.color(scheme)),
        title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${notification.message}\n${Formatters.dateTime(notification.createdAt)}'),
        isThreeLine: true,
        onTap: () async {
          if (!notification.isRead) {
            await ref.read(notificationsApiProvider).markRead(notification.id);
            ref.invalidate(notificationsControllerProvider);
          }
        },
      ),
    );
  }
}
