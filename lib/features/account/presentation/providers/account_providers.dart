import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../dashboard/data/models/resident_property_summary.dart';
import '../../data/account_api.dart';
import '../../data/models/installment_schedule_item.dart';
import '../../data/models/rent_invoice.dart';
import '../../data/models/utility_bill.dart';
import '../../data/models/violation_fine.dart';

final accountApiProvider = Provider<AccountApi>((ref) {
  return AccountApi(ref.watch(apiClientProvider));
});

final residentPropertiesProvider = FutureProvider.autoDispose<List<ResidentPropertySummary>>((ref) {
  return ref.watch(accountApiProvider).getProperties();
});

class BillsController extends PagedListNotifier<UtilityBill> {
  @override
  Future<PagedResult<UtilityBill>> fetchPage(int pageNumber) {
    return ref.read(accountApiProvider).searchBills(pageNumber: pageNumber);
  }
}

final billsControllerProvider =
    AutoDisposeAsyncNotifierProvider<BillsController, PagedListState<UtilityBill>>(BillsController.new);

final billDetailProvider = FutureProvider.autoDispose.family<UtilityBill, String>((ref, id) {
  return ref.watch(accountApiProvider).getBill(id);
});

class RentController extends PagedListNotifier<RentInvoice> {
  @override
  Future<PagedResult<RentInvoice>> fetchPage(int pageNumber) {
    return ref.read(accountApiProvider).searchRent(pageNumber: pageNumber);
  }
}

final rentControllerProvider =
    AutoDisposeAsyncNotifierProvider<RentController, PagedListState<RentInvoice>>(RentController.new);

class InstallmentsController extends PagedListNotifier<InstallmentScheduleItem> {
  @override
  Future<PagedResult<InstallmentScheduleItem>> fetchPage(int pageNumber) {
    return ref.read(accountApiProvider).searchInstallments(pageNumber: pageNumber);
  }
}

final installmentsControllerProvider =
    AutoDisposeAsyncNotifierProvider<InstallmentsController, PagedListState<InstallmentScheduleItem>>(
        InstallmentsController.new);

class ViolationFinesController extends PagedListNotifier<ViolationFine> {
  @override
  Future<PagedResult<ViolationFine>> fetchPage(int pageNumber) {
    return ref.read(accountApiProvider).searchViolationFines(pageNumber: pageNumber);
  }
}

final violationFinesControllerProvider =
    AutoDisposeAsyncNotifierProvider<ViolationFinesController, PagedListState<ViolationFine>>(
        ViolationFinesController.new);

final violationFineDetailProvider = FutureProvider.autoDispose.family<ViolationFine, String>((ref, id) {
  return ref.watch(accountApiProvider).getViolationFine(id);
});
