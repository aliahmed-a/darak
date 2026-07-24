import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/documents_api.dart';
import '../../data/models/document_file.dart';

final documentsApiProvider = Provider<DocumentsApi>((ref) {
  return DocumentsApi(ref.watch(apiClientProvider));
});

class DocumentsController extends PagedListNotifier<DocumentFile> {
  @override
  Future<PagedResult<DocumentFile>> fetchPage(int pageNumber) {
    return ref.read(documentsApiProvider).search(pageNumber: pageNumber);
  }
}

final documentsControllerProvider =
    AutoDisposeAsyncNotifierProvider<DocumentsController, PagedListState<DocumentFile>>(DocumentsController.new);
