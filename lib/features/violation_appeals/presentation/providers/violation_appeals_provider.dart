import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/models/violation_appeal.dart';
import '../../data/violation_appeals_api.dart';

final violationAppealsApiProvider = Provider<ViolationAppealsApi>((ref) {
  return ViolationAppealsApi(ref.watch(apiClientProvider));
});

class ViolationAppealsController extends PagedListNotifier<ViolationAppeal> {
  @override
  Future<PagedResult<ViolationAppeal>> fetchPage(int pageNumber) {
    return ref.read(violationAppealsApiProvider).search(pageNumber: pageNumber);
  }
}

final violationAppealsControllerProvider =
    AutoDisposeAsyncNotifierProvider<ViolationAppealsController, PagedListState<ViolationAppeal>>(
        ViolationAppealsController.new);

final violationAppealDetailProvider = FutureProvider.autoDispose.family<ViolationAppeal, String>((ref, id) {
  return ref.watch(violationAppealsApiProvider).getById(id);
});
