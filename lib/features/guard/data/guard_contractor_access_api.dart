import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/guard_contractor_permit.dart';

class GuardContractorAccessApi {
  const GuardContractorAccessApi(this._client);

  final ApiClient _client;

  Future<PagedResult<GuardContractorPermit>> today({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/guard/access/contractors/today', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(
            response.data as Map<String, dynamic>, (json) => GuardContractorPermit.fromJson(json));
      });

  Future<GuardContractorPermit> checkIn(String id, {required String accessCode, String? notes}) =>
      runApiCall(() async {
        final response = await _client.dio.post('/guard/access/contractors/$id/check-in', data: {
          'accessCode': accessCode,
          'notes': notes,
        });
        return GuardContractorPermit.fromJson(response.data as Map<String, dynamic>);
      });

  Future<GuardContractorPermit> checkOut(String id, {String? notes}) => runApiCall(() async {
        final response = await _client.dio.post('/guard/access/contractors/$id/check-out', data: {
          'notes': notes,
        });
        return GuardContractorPermit.fromJson(response.data as Map<String, dynamic>);
      });
}
