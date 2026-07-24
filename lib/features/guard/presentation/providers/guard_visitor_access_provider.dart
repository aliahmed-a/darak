import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/paged_list_controller.dart';
import '../../../../core/network/paged_result.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/guard_visitor_access_api.dart';
import '../../data/models/guard_visitor_pass.dart';
import '../../data/models/visitor_access_log.dart';

final guardVisitorAccessApiProvider = Provider<GuardVisitorAccessApi>((ref) {
  return GuardVisitorAccessApi(ref.watch(apiClientProvider));
});

class GuardVisitorsTodayController extends PagedListNotifier<GuardVisitorPass> {
  @override
  Future<PagedResult<GuardVisitorPass>> fetchPage(int pageNumber) {
    return ref.read(guardVisitorAccessApiProvider).today(pageNumber: pageNumber);
  }
}

final guardVisitorsTodayControllerProvider =
    AutoDisposeAsyncNotifierProvider<GuardVisitorsTodayController, PagedListState<GuardVisitorPass>>(
        GuardVisitorsTodayController.new);

final guardVisitorDetailProvider = FutureProvider.autoDispose.family<GuardVisitorPass, String>((ref, id) {
  return ref.watch(guardVisitorAccessApiProvider).getById(id);
});

/// Paged access-log list for one visitor pass, keyed by pass id. Duplicates
/// [PagedListNotifier]'s small loadMore/refresh logic rather than sharing an
/// abstract base, since that base is non-family and this is the only
/// family-keyed paged list in the app so far.
class GuardVisitorLogsController extends AutoDisposeFamilyAsyncNotifier<PagedListState<GuardAccessLog>, String> {
  @override
  Future<PagedListState<GuardAccessLog>> build(String arg) async {
    final result = await _fetchPage(1);
    return PagedListState(items: result.items, pageNumber: 1, hasNextPage: result.hasNextPage);
  }

  Future<PagedResult<GuardAccessLog>> _fetchPage(int pageNumber) {
    return ref.read(guardVisitorAccessApiProvider).logs(arg, pageNumber: pageNumber);
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasNextPage || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));
    final nextPage = current.pageNumber + 1;
    try {
      final result = await _fetchPage(nextPage);
      state = AsyncData(current.copyWith(
        items: [...current.items, ...result.items],
        pageNumber: nextPage,
        hasNextPage: result.hasNextPage,
        isLoadingMore: false,
      ));
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _fetchPage(1);
      return PagedListState(items: result.items, pageNumber: 1, hasNextPage: result.hasNextPage);
    });
  }
}

final guardVisitorLogsControllerProvider = AutoDisposeAsyncNotifierProviderFamily<GuardVisitorLogsController,
    PagedListState<GuardAccessLog>, String>(GuardVisitorLogsController.new);
