import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/resident_notification.dart';

class NotificationsApi {
  const NotificationsApi(this._client);

  final ApiClient _client;

  Future<PagedResult<ResidentNotification>> search({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/communication/notifications', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(
          response.data as Map<String, dynamic>,
          (json) => ResidentNotification.fromJson(json),
        );
      });

  Future<void> markRead(String id) => runApiCall(() async {
        await _client.dio.patch('/resident/communication/notifications/$id/read');
      });

  Future<void> markAllRead() => runApiCall(() async {
        await _client.dio.patch('/resident/communication/notifications/read-all');
      });
}
