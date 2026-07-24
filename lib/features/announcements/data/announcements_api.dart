import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/announcement.dart';

class AnnouncementsApi {
  const AnnouncementsApi(this._client);

  final ApiClient _client;

  Future<PagedResult<Announcement>> search({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/communication/announcements', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(response.data as Map<String, dynamic>, (json) => Announcement.fromJson(json));
      });

  Future<Announcement> getById(String id) => runApiCall(() async {
        final response = await _client.dio.get('/resident/communication/announcements/$id');
        return Announcement.fromJson(response.data as Map<String, dynamic>);
      });

  Future<void> markRead(String id) => runApiCall(() async {
        await _client.dio.patch('/resident/communication/announcements/$id/read');
      });
}
