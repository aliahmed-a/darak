import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/maintenance_api.dart';
import '../../data/models/maintenance_request.dart';

final maintenanceApiProvider = Provider<MaintenanceApi>((ref) {
  return MaintenanceApi(ref.watch(apiClientProvider));
});

class MaintenanceController extends PagedListNotifier<MaintenanceRequest> {
  @override
  Future<PagedResult<MaintenanceRequest>> fetchPage(int pageNumber) {
    return ref.read(maintenanceApiProvider).search(pageNumber: pageNumber);
  }
}

final maintenanceControllerProvider =
    AutoDisposeAsyncNotifierProvider<MaintenanceController, PagedListState<MaintenanceRequest>>(
        MaintenanceController.new);

final maintenanceDetailProvider = FutureProvider.autoDispose.family<MaintenanceRequest, String>((ref, id) {
  return ref.watch(maintenanceApiProvider).getById(id);
});
