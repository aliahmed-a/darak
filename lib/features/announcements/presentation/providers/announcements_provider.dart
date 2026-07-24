import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/announcements_api.dart';
import '../../data/models/announcement.dart';

final announcementsApiProvider = Provider<AnnouncementsApi>((ref) {
  return AnnouncementsApi(ref.watch(apiClientProvider));
});

class AnnouncementsController extends PagedListNotifier<Announcement> {
  @override
  Future<PagedResult<Announcement>> fetchPage(int pageNumber) {
    return ref.read(announcementsApiProvider).search(pageNumber: pageNumber);
  }
}

final announcementsControllerProvider =
    AutoDisposeAsyncNotifierProvider<AnnouncementsController, PagedListState<Announcement>>(
        AnnouncementsController.new);

final announcementDetailProvider = FutureProvider.autoDispose.family<Announcement, String>((ref, id) {
  return ref.watch(announcementsApiProvider).getById(id);
});
