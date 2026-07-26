import 'package:flutter/material.dart';

/// Solid fill rather than a `ColorScheme` role because the seed palette has no
/// success color, and a tinted container reads as washed-out in dark mode.
const _successColor = Color(0xFF1E7D57);

/// Confirmation message — a create screen closing on its own gave the resident
/// no sign anything had been submitted.
void showSuccessSnack(BuildContext context, String message) {
  _show(context, message, background: _successColor, foreground: Colors.white, icon: Icons.check_circle_outline);
}

/// Failure message. Distinct color and icon so it can't be mistaken for the
/// confirmation above — every message in the app used to look the same.
void showErrorSnack(BuildContext context, String message) {
  final scheme = Theme.of(context).colorScheme;
  _show(context, message, background: scheme.error, foreground: scheme.onError, icon: Icons.error_outline);
}

void _show(
  BuildContext context,
  String message, {
  required Color background,
  required Color foreground,
  required IconData icon,
}) {
  ScaffoldMessenger.of(context)
    // Without this a queued message from the previous screen can sit in front
    // of the one the user just triggered.
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: foreground, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: TextStyle(color: foreground))),
          ],
        ),
        backgroundColor: background,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
}
