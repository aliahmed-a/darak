import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/complaints_api.dart';
import '../../data/models/complaint.dart';

final complaintsApiProvider = Provider<ComplaintsApi>((ref) {
  return ComplaintsApi(ref.watch(apiClientProvider));
});

class ComplaintsController extends PagedListNotifier<Complaint> {
  @override
  Future<PagedResult<Complaint>> fetchPage(int pageNumber) {
    return ref.read(complaintsApiProvider).search(pageNumber: pageNumber);
  }
}

final complaintsControllerProvider =
    AutoDisposeAsyncNotifierProvider<ComplaintsController, PagedListState<Complaint>>(ComplaintsController.new);

final complaintDetailProvider = FutureProvider.autoDispose.family<Complaint, String>((ref, id) {
  return ref.watch(complaintsApiProvider).getById(id);
});
