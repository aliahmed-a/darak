import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/violation_appeal.dart';

class ViolationAppealsApi {
  const ViolationAppealsApi(this._client);

  final ApiClient _client;

  Future<PagedResult<ViolationAppeal>> search({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/financial-governance/violation-appeals', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(
          response.data as Map<String, dynamic>,
          (json) => ViolationAppeal.fromJson(json),
        );
      });

  Future<ViolationAppeal> getById(String id) => runApiCall(() async {
        final response = await _client.dio.get('/resident/financial-governance/violation-appeals/$id');
        return ViolationAppeal.fromJson(response.data as Map<String, dynamic>);
      });

  Future<ViolationAppeal> create({
    required String violationId,
    String? violationFineId,
    required String reason,
    required String message,
  }) =>
      runApiCall(() async {
        final response = await _client.dio.post('/resident/financial-governance/violation-appeals', data: {
          'violationId': violationId,
          'violationFineId': violationFineId,
          'reason': reason,
          'message': message,
        });
        return ViolationAppeal.fromJson(response.data as Map<String, dynamic>);
      });
}
