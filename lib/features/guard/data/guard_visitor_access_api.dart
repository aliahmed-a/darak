import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/guard_visitor_pass.dart';
import 'models/visitor_access_log.dart';

class GuardVisitorAccessApi {
  const GuardVisitorAccessApi(this._client);

  final ApiClient _client;

  Future<PagedResult<GuardVisitorPass>> today({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/guard/access/visitors/today', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(response.data as Map<String, dynamic>, (json) => GuardVisitorPass.fromJson(json));
      });

  Future<GuardVisitorPass> verifyCode(String accessCode) => runApiCall(() async {
        final response = await _client.dio.post('/guard/access/visitors/verify-code', data: {
          'accessCode': accessCode,
        });
        return GuardVisitorPass.fromJson(response.data as Map<String, dynamic>);
      });

  Future<GuardVisitorPass> getById(String id) => runApiCall(() async {
        final response = await _client.dio.get('/guard/access/visitors/$id');
        return GuardVisitorPass.fromJson(response.data as Map<String, dynamic>);
      });

  Future<GuardVisitorPass> checkIn(String id, {required String accessCode, String? notes}) => runApiCall(() async {
        final response = await _client.dio.post('/guard/access/visitors/$id/check-in', data: {
          'accessCode': accessCode,
          'notes': notes,
        });
        return GuardVisitorPass.fromJson(response.data as Map<String, dynamic>);
      });

  Future<GuardVisitorPass> checkOut(String id, {String? notes}) => runApiCall(() async {
        final response = await _client.dio.post('/guard/access/visitors/$id/check-out', data: {
          'notes': notes,
        });
        return GuardVisitorPass.fromJson(response.data as Map<String, dynamic>);
      });

  Future<GuardVisitorPass> deny(String id, {required String reason}) => runApiCall(() async {
        final response = await _client.dio.post('/guard/access/visitors/$id/deny', data: {
          'reason': reason,
        });
        return GuardVisitorPass.fromJson(response.data as Map<String, dynamic>);
      });

  Future<PagedResult<GuardAccessLog>> logs(String id, {int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/guard/access/visitors/$id/logs', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(response.data as Map<String, dynamic>, (json) => GuardAccessLog.fromJson(json));
      });
}
