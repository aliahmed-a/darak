import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/visitor_pass.dart';

class VisitorPassesApi {
  const VisitorPassesApi(this._client);

  final ApiClient _client;

  Future<PagedResult<VisitorPass>> search({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/requests/visitor-passes', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(response.data as Map<String, dynamic>, (json) => VisitorPass.fromJson(json));
      });

  Future<VisitorPass> getById(String id) => runApiCall(() async {
        final response = await _client.dio.get('/resident/requests/visitor-passes/$id');
        return VisitorPass.fromJson(response.data as Map<String, dynamic>);
      });

  Future<VisitorPass> create({
    required String propertyUnitId,
    required String visitorName,
    required String visitorPhoneNumber,
    required String visitReason,
    required DateTime validFrom,
    required DateTime validUntil,
  }) =>
      runApiCall(() async {
        final response = await _client.dio.post('/resident/requests/visitor-passes', data: {
          'propertyUnitId': propertyUnitId,
          'visitorName': visitorName,
          'visitorPhoneNumber': visitorPhoneNumber,
          'visitReason': visitReason,
          'validFrom': validFrom.toUtc().toIso8601String(),
          'validUntil': validUntil.toUtc().toIso8601String(),
        });
        return VisitorPass.fromJson(response.data as Map<String, dynamic>);
      });

  Future<VisitorPass> cancel(String id, {String? reason}) => runApiCall(() async {
        final response = await _client.dio.post('/resident/requests/visitor-passes/$id/cancel', data: {
          'reason': reason,
        });
        return VisitorPass.fromJson(response.data as Map<String, dynamic>);
      });
}
