import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_banner.dart';

/// Renders the three states of an [AsyncValue] consistently across screens:
/// a centered spinner while loading, an [ErrorBanner] with retry on failure,
/// and [data] once a value is available.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(BuildContext context, T data) data;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (value) => data(context, value),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: ErrorBanner(error: error, onRetry: onRetry)),
    );
  }
}
