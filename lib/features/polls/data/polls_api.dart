import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/community_poll.dart';

class PollsApi {
  const PollsApi(this._client);

  final ApiClient _client;

  Future<PagedResult<CommunityPoll>> search({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/communication/polls', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(response.data as Map<String, dynamic>, (json) => CommunityPoll.fromJson(json));
      });

  Future<CommunityPoll> getById(String id) => runApiCall(() async {
        final response = await _client.dio.get('/resident/communication/polls/$id');
        return CommunityPoll.fromJson(response.data as Map<String, dynamic>);
      });

  Future<CommunityPoll> vote(String pollId, List<String> optionIds) => runApiCall(() async {
        final response = await _client.dio.post('/resident/communication/polls/$pollId/vote', data: {
          'pollOptionIds': optionIds,
        });
        return CommunityPoll.fromJson(response.data as Map<String, dynamic>);
      });
}
