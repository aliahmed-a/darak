import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import '../../dashboard/data/models/resident_property_summary.dart';
import 'models/installment_schedule_item.dart';
import 'models/rent_invoice.dart';
import 'models/utility_bill.dart';
import 'models/violation_fine.dart';

class AccountApi {
  const AccountApi(this._client);

  final ApiClient _client;

  Future<PagedResult<UtilityBill>> searchBills({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/account/bills', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(
          response.data as Map<String, dynamic>,
          (json) => UtilityBill.fromJson(json),
        );
      });

  Future<UtilityBill> getBill(String id) => runApiCall(() async {
        final response = await _client.dio.get('/resident/account/bills/$id');
        return UtilityBill.fromJson(response.data as Map<String, dynamic>);
      });

  Future<PagedResult<RentInvoice>> searchRent({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/account/rent', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(
          response.data as Map<String, dynamic>,
          (json) => RentInvoice.fromJson(json),
        );
      });

  Future<PagedResult<InstallmentScheduleItem>> searchInstallments({int pageNumber = 1, int pageSize = 20}) =>
      runApiCall(() async {
        final response = await _client.dio.get('/resident/account/installments', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(
          response.data as Map<String, dynamic>,
          (json) => InstallmentScheduleItem.fromJson(json),
        );
      });

  Future<List<ResidentPropertySummary>> getProperties() => runApiCall(() async {
        final response = await _client.dio.get('/resident/account/properties');
        return (response.data as List)
            .map((e) => ResidentPropertySummary.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  Future<PagedResult<ViolationFine>> searchViolationFines({int pageNumber = 1, int pageSize = 20}) =>
      runApiCall(() async {
        final response = await _client.dio.get('/resident/account/violation-fines', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(
          response.data as Map<String, dynamic>,
          (json) => ViolationFine.fromJson(json),
        );
      });

  Future<ViolationFine> getViolationFine(String id) => runApiCall(() async {
        final response = await _client.dio.get('/resident/account/violation-fines/$id');
        return ViolationFine.fromJson(response.data as Map<String, dynamic>);
      });
}
