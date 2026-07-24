import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/maintenance_priority.dart';
import 'models/maintenance_request.dart';

class MaintenanceApi {
  const MaintenanceApi(this._client);

  final ApiClient _client;

  Future<PagedResult<MaintenanceRequest>> search({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/requests/maintenance', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(response.data as Map<String, dynamic>, (json) => MaintenanceRequest.fromJson(json));
      });

  Future<MaintenanceRequest> getById(String id) => runApiCall(() async {
        final response = await _client.dio.get('/resident/requests/maintenance/$id');
        return MaintenanceRequest.fromJson(response.data as Map<String, dynamic>);
      });

  Future<MaintenanceRequest> create({
    required String propertyUnitId,
    required String title,
    required String description,
    required MaintenancePriority priority,
  }) =>
      runApiCall(() async {
        final response = await _client.dio.post('/resident/requests/maintenance', data: {
          'propertyUnitId': propertyUnitId,
          'title': title,
          'description': description,
          'priority': priority.index,
        });
        return MaintenanceRequest.fromJson(response.data as Map<String, dynamic>);
      });

  Future<MaintenanceRequest> cancel(String id, {String? notes}) => runApiCall(() async {
        final response = await _client.dio.post('/resident/requests/maintenance/$id/cancel', data: {
          'notes': notes,
        });
        return MaintenanceRequest.fromJson(response.data as Map<String, dynamic>);
      });

  Future<MaintenanceRequest> close(String id, {String? notes}) => runApiCall(() async {
        final response = await _client.dio.post('/resident/requests/maintenance/$id/close', data: {
          'notes': notes,
        });
        return MaintenanceRequest.fromJson(response.data as Map<String, dynamic>);
      });
}
