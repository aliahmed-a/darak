import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/settings_providers.dart';
import '../../../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionLabel(l10n.settingsAppearance),
          Card(
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: Text(l10n.settingsThemeSystem),
                  value: ThemeMode.system,
                  groupValue: themeMode,
                  onChanged: (value) => ref.read(themeModeProvider.notifier).setThemeMode(value!),
                ),
                RadioListTile<ThemeMode>(
                  title: Text(l10n.settingsThemeLight),
                  value: ThemeMode.light,
                  groupValue: themeMode,
                  onChanged: (value) => ref.read(themeModeProvider.notifier).setThemeMode(value!),
                ),
                RadioListTile<ThemeMode>(
                  title: Text(l10n.settingsThemeDark),
                  value: ThemeMode.dark,
                  groupValue: themeMode,
                  onChanged: (value) => ref.read(themeModeProvider.notifier).setThemeMode(value!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _SectionLabel(l10n.settingsLanguage),
          Card(
            child: Column(
              children: [
                RadioListTile<Locale?>(
                  title: Text(l10n.settingsThemeSystem),
                  value: null,
                  groupValue: locale,
                  onChanged: (value) => ref.read(localeProvider.notifier).setLocale(value),
                ),
                RadioListTile<Locale?>(
                  title: Text(l10n.settingsLanguageEnglish),
                  value: const Locale('en'),
                  groupValue: locale,
                  onChanged: (value) => ref.read(localeProvider.notifier).setLocale(value),
                ),
                RadioListTile<Locale?>(
                  title: Text(l10n.settingsLanguageArabic),
                  value: const Locale('ar'),
                  groupValue: locale,
                  onChanged: (value) => ref.read(localeProvider.notifier).setLocale(value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 8, start: 4),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
