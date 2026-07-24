import 'package:flutter/material.dart';

import '../network/paged_list_controller.dart';

/// Scrollable list for a [PagedListState]: fetches the next page when the
/// user nears the bottom, shows a footer spinner while doing so, and
/// supports pull-to-refresh.
class PagedListView<T> extends StatefulWidget {
  const PagedListView({
    super.key,
    required this.state,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.onRefresh,
    required this.emptyMessage,
    this.padding = const EdgeInsets.all(16),
  });

  final PagedListState<T> state;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Future<void> Function() onLoadMore;
  final Future<void> Function() onRefresh;
  final String emptyMessage;
  final EdgeInsets padding;

  @override
  State<PagedListView<T>> createState() => _PagedListViewState<T>();
}

class _PagedListViewState<T> extends State<PagedListView<T>> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_maybeLoadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_maybeLoadMore);
    _scrollController.dispose();
    super.dispose();
  }

  void _maybeLoadMore() {
    if (!widget.state.hasNextPage || widget.state.isLoadingMore) return;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.items.isEmpty) {
      return RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inbox_outlined, size: 40, color: Theme.of(context).colorScheme.outline),
                    const SizedBox(height: 12),
                    Text(widget.emptyMessage, style: TextStyle(color: Theme.of(context).colorScheme.outline)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.separated(
        controller: _scrollController,
        padding: widget.padding,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.state.items.length + (widget.state.hasNextPage ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index >= widget.state.items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }
          return widget.itemBuilder(context, widget.state.items[index]);
        },
      ),
    );
  }
}
