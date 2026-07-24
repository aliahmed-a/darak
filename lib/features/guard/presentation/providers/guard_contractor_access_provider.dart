import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/guard_contractor_access_api.dart';
import '../../data/models/guard_contractor_permit.dart';

final guardContractorAccessApiProvider = Provider<GuardContractorAccessApi>((ref) {
  return GuardContractorAccessApi(ref.watch(apiClientProvider));
});

class GuardContractorsTodayController extends PagedListNotifier<GuardContractorPermit> {
  @override
  Future<PagedResult<GuardContractorPermit>> fetchPage(int pageNumber) {
    return ref.read(guardContractorAccessApiProvider).today(pageNumber: pageNumber);
  }
}

final guardContractorsTodayControllerProvider =
    AutoDisposeAsyncNotifierProvider<GuardContractorsTodayController, PagedListState<GuardContractorPermit>>(
        GuardContractorsTodayController.new);
