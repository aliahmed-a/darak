import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/models/visitor_pass.dart';
import '../../data/visitor_passes_api.dart';

final visitorPassesApiProvider = Provider<VisitorPassesApi>((ref) {
  return VisitorPassesApi(ref.watch(apiClientProvider));
});

class VisitorPassesController extends PagedListNotifier<VisitorPass> {
  @override
  Future<PagedResult<VisitorPass>> fetchPage(int pageNumber) {
    return ref.read(visitorPassesApiProvider).search(pageNumber: pageNumber);
  }
}

final visitorPassesControllerProvider =
    AutoDisposeAsyncNotifierProvider<VisitorPassesController, PagedListState<VisitorPass>>(
        VisitorPassesController.new);

final visitorPassDetailProvider = FutureProvider.autoDispose.family<VisitorPass, String>((ref, id) {
  return ref.watch(visitorPassesApiProvider).getById(id);
});
