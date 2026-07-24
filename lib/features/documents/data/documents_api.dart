import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/document_file.dart';

class DocumentsApi {
  const DocumentsApi(this._client);

  final ApiClient _client;

  Future<PagedResult<DocumentFile>> search({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/documents', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(
          response.data as Map<String, dynamic>,
          (json) => DocumentFile.fromJson(json),
        );
      });

  Future<List<int>> download(String id) => runApiCall(() async {
        final response = await _client.dio.get<List<int>>(
          '/resident/documents/$id/download',
          options: Options(responseType: ResponseType.bytes),
        );
        return response.data!;
      });
}
