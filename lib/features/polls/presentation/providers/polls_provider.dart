import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/models/community_poll.dart';
import '../../data/polls_api.dart';

final pollsApiProvider = Provider<PollsApi>((ref) {
  return PollsApi(ref.watch(apiClientProvider));
});

class PollsController extends PagedListNotifier<CommunityPoll> {
  @override
  Future<PagedResult<CommunityPoll>> fetchPage(int pageNumber) {
    return ref.read(pollsApiProvider).search(pageNumber: pageNumber);
  }
}

final pollsControllerProvider =
    AutoDisposeAsyncNotifierProvider<PollsController, PagedListState<CommunityPoll>>(PollsController.new);

final pollDetailProvider = FutureProvider.autoDispose.family<CommunityPoll, String>((ref, id) {
  return ref.watch(pollsApiProvider).getById(id);
});
