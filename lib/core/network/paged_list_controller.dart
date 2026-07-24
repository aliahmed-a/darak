import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'paged_result.dart';

class PagedListState<T> {
  const PagedListState({
    required this.items,
    required this.pageNumber,
    required this.hasNextPage,
    this.isLoadingMore = false,
  });

  final List<T> items;
  final int pageNumber;
  final bool hasNextPage;
  final bool isLoadingMore;

  PagedListState<T> copyWith({
    List<T>? items,
    int? pageNumber,
    bool? hasNextPage,
    bool? isLoadingMore,
  }) {
    return PagedListState(
      items: items ?? this.items,
      pageNumber: pageNumber ?? this.pageNumber,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

/// Base for a Riverpod `AsyncNotifier` backing a paginated list screen.
/// Subclasses only need to implement [fetchPage]; this handles the initial
/// load, `loadMore()` accumulation, and `hasNextPage` bookkeeping.
abstract class PagedListNotifier<T> extends AutoDisposeAsyncNotifier<PagedListState<T>> {
  Future<PagedResult<T>> fetchPage(int pageNumber);

  @override
  Future<PagedListState<T>> build() async {
    final result = await fetchPage(1);
    return PagedListState(items: result.items, pageNumber: 1, hasNextPage: result.hasNextPage);
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasNextPage || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));
    final nextPage = current.pageNumber + 1;
    try {
      final result = await fetchPage(nextPage);
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
      final result = await fetchPage(1);
      return PagedListState(items: result.items, pageNumber: 1, hasNextPage: result.hasNextPage);
    });
  }
}
