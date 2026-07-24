import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/models/payment.dart';
import '../../data/payments_api.dart';

final paymentsApiProvider = Provider<PaymentsApi>((ref) {
  return PaymentsApi(ref.watch(apiClientProvider));
});

class PaymentsController extends PagedListNotifier<Payment> {
  @override
  Future<PagedResult<Payment>> fetchPage(int pageNumber) {
    return ref.read(paymentsApiProvider).search(pageNumber: pageNumber);
  }
}

final paymentsControllerProvider =
    AutoDisposeAsyncNotifierProvider<PaymentsController, PagedListState<Payment>>(PaymentsController.new);

final paymentDetailProvider = FutureProvider.autoDispose.family<Payment, String>((ref, id) {
  return ref.watch(paymentsApiProvider).getById(id);
});
