import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/financial_dispute.dart';
import 'models/financial_dispute_target_type.dart';

class FinancialDisputesApi {
  const FinancialDisputesApi(this._client);

  final ApiClient _client;

  Future<PagedResult<FinancialDispute>> search({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/financial-governance/disputes', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(response.data as Map<String, dynamic>, (json) => FinancialDispute.fromJson(json));
      });

  Future<FinancialDispute> getById(String id) => runApiCall(() async {
        final response = await _client.dio.get('/resident/financial-governance/disputes/$id');
        return FinancialDispute.fromJson(response.data as Map<String, dynamic>);
      });

  Future<FinancialDispute> create({
    required FinancialDisputeTargetType targetType,
    required String targetId,
    required String reason,
    required String message,
  }) =>
      runApiCall(() async {
        final response = await _client.dio.post('/resident/financial-governance/disputes', data: {
          'targetType': targetType.apiValue,
          'targetId': targetId,
          'reason': reason,
          'message': message,
        });
        return FinancialDispute.fromJson(response.data as Map<String, dynamic>);
      });
}
