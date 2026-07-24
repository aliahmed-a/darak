import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../network/api_exception.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.error, this.onRetry});

  final Object error;
  final VoidCallback? onRetry;

  String _message(BuildContext context) =>
      error is ApiException ? (error as ApiException).message : AppLocalizations.of(context)!.commonSomethingWentWrong;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: scheme.error.withValues(alpha: 0.12), shape: BoxShape.circle),
            child: Icon(Icons.error_outline, color: scheme.error, size: 32),
          ),
          const SizedBox(height: 16),
          Text(_message(context), textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onRetry, child: Text(l10n.commonTryAgain)),
          ],
        ],
      ),
    );
  }
}
