import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/complaint.dart';

class ComplaintsApi {
  const ComplaintsApi(this._client);

  final ApiClient _client;

  Future<PagedResult<Complaint>> search({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/requests/complaints', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(response.data as Map<String, dynamic>, (json) => Complaint.fromJson(json));
      });

  Future<Complaint> getById(String id) => runApiCall(() async {
        final response = await _client.dio.get('/resident/requests/complaints/$id');
        return Complaint.fromJson(response.data as Map<String, dynamic>);
      });

  Future<Complaint> create({
    String? propertyUnitId,
    required String title,
    required String description,
  }) =>
      runApiCall(() async {
        final response = await _client.dio.post('/resident/requests/complaints', data: {
          'propertyUnitId': propertyUnitId,
          'title': title,
          'description': description,
        });
        return Complaint.fromJson(response.data as Map<String, dynamic>);
      });
}
