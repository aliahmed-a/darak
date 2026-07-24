import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'core_providers.dart';

const _supportedLanguageCodes = ['en', 'ar'];

/// Keeps `intl`'s [Intl.defaultLocale] (used by [Formatters], which has no
/// [BuildContext] to read the resolved app locale from) in sync with the
/// locale the user picked, falling back to the device locale when following
/// system.
void _applyIntlLocale(Locale? locale) {
  if (locale != null) {
    Intl.defaultLocale = locale.languageCode;
    return;
  }
  final systemCode = PlatformDispatcher.instance.locale.languageCode;
  Intl.defaultLocale = _supportedLanguageCodes.contains(systemCode) ? systemCode : 'en';
}

/// Persisted theme mode (System/Light/Dark), defaulting to System until the
/// stored value loads from secure storage. Starting synchronous with a
/// sensible default (rather than an [AsyncNotifier]) keeps `MaterialApp`'s
/// `themeMode:` simple — it needs a plain [ThemeMode], not an [AsyncValue].
class ThemeModeController extends Notifier<ThemeMode> {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    _load();
    return ThemeMode.system;
  }

  Future<void> _load() async {
    final stored = await ref.read(secureStorageProvider).read(key: _key);
    state = switch (stored) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await ref.read(secureStorageProvider).write(key: _key, value: mode.name);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(ThemeModeController.new);

/// Persisted locale override. `null` means "follow system" (resolved by
/// `MaterialApp`'s `localeResolutionCallback` against the two supported
/// locales, English and Arabic).
class LocaleController extends Notifier<Locale?> {
  static const _key = 'locale';

  @override
  Locale? build() {
    _applyIntlLocale(null);
    _load();
    return null;
  }

  Future<void> _load() async {
    final stored = await ref.read(secureStorageProvider).read(key: _key);
    final locale = stored == null ? null : Locale(stored);
    state = locale;
    _applyIntlLocale(locale);
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    _applyIntlLocale(locale);
    final storage = ref.read(secureStorageProvider);
    if (locale == null) {
      await storage.delete(key: _key);
    } else {
      await storage.write(key: _key, value: locale.languageCode);
    }
  }
}

final localeProvider = NotifierProvider<LocaleController, Locale?>(LocaleController.new);
