import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/financial_disputes_api.dart';
import '../../data/models/financial_dispute.dart';

final financialDisputesApiProvider = Provider<FinancialDisputesApi>((ref) {
  return FinancialDisputesApi(ref.watch(apiClientProvider));
});

class FinancialDisputesController extends PagedListNotifier<FinancialDispute> {
  @override
  Future<PagedResult<FinancialDispute>> fetchPage(int pageNumber) {
    return ref.read(financialDisputesApiProvider).search(pageNumber: pageNumber);
  }
}

final financialDisputesControllerProvider =
    AutoDisposeAsyncNotifierProvider<FinancialDisputesController, PagedListState<FinancialDispute>>(
        FinancialDisputesController.new);

final financialDisputeDetailProvider = FutureProvider.autoDispose.family<FinancialDispute, String>((ref, id) {
  return ref.watch(financialDisputesApiProvider).getById(id);
});
