import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/models/resident_notification.dart';
import '../../data/notifications_api.dart';

final notificationsApiProvider = Provider<NotificationsApi>((ref) {
  return NotificationsApi(ref.watch(apiClientProvider));
});

class NotificationsController extends PagedListNotifier<ResidentNotification> {
  @override
  Future<PagedResult<ResidentNotification>> fetchPage(int pageNumber) {
    return ref.read(notificationsApiProvider).search(pageNumber: pageNumber);
  }
}

final notificationsControllerProvider =
    AutoDisposeAsyncNotifierProvider<NotificationsController, PagedListState<ResidentNotification>>(
        NotificationsController.new);
