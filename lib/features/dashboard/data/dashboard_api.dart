import '../../../core/network/api_client.dart';
import 'models/resident_dashboard.dart';

class DashboardApi {
  const DashboardApi(this._client);

  final ApiClient _client;

  Future<ResidentDashboard> getDashboard() => runApiCall(() async {
        final response = await _client.dio.get('/resident/account');
        return ResidentDashboard.fromJson(response.data as Map<String, dynamic>);
      });
}
