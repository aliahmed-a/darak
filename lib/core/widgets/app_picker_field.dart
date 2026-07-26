import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Number of options past which the sheet grows a search box. Below this a
/// search field is just clutter — a resident normally has one or two units.
const _searchThreshold = 8;

/// One selectable row in an [AppPickerField]'s sheet.
class PickerOption<T> {
  const PickerOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
    this.iconColor,
  });

  final T value;
  final String label;

  /// Second line under [label] — building/floor for a unit, the amount for a
  /// bill. The old dropdown menu had no room for this.
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;

  bool _matches(String query) =>
      label.toLowerCase().contains(query) || (subtitle?.toLowerCase().contains(query) ?? false);
}

/// Replacement for `DropdownButtonFormField` that opens a bottom sheet instead
/// of an overlay menu.
///
/// It's a real [FormField], so `Form.validate()` picks it up and a required
/// field renders its error under the box exactly like a [TextFormField] does.
/// The dropdowns this replaces had no validator at all, so an unfilled form
/// just silently refused to submit.
class AppPickerField<T> extends FormField<T> {
  AppPickerField({
    super.key,
    required this.options,
    required String label,
    required ValueChanged<T?> onChanged,
    T? value,
    String? sheetTitle,
    super.enabled = true,
    super.validator,
    super.onSaved,
  }) : super(
          initialValue: value,
          builder: (field) => _PickerFieldBody<T>(
            state: field,
            options: options,
            label: label,
            sheetTitle: sheetTitle ?? label,
            enabled: enabled,
            onChanged: onChanged,
          ),
        );

  final List<PickerOption<T>> options;

  @override
  FormFieldState<T> createState() => _AppPickerFieldState<T>();
}

class _AppPickerFieldState<T> extends FormFieldState<T> {
  @override
  void didUpdateWidget(AppPickerField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The owning screen drives the value (e.g. the dispute screen clears the
    // selected item when the target type changes). Without this the field
    // would keep rendering its own stale copy.
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }
}

class _PickerFieldBody<T> extends StatelessWidget {
  const _PickerFieldBody({
    required this.state,
    required this.options,
    required this.label,
    required this.sheetTitle,
    required this.enabled,
    required this.onChanged,
  });

  final FormFieldState<T> state;
  final List<PickerOption<T>> options;
  final String label;
  final String sheetTitle;
  final bool enabled;
  final ValueChanged<T?> onChanged;

  PickerOption<T>? get _selected {
    for (final option in options) {
      if (option.value == state.value) return option;
    }
    return null;
  }

  Future<void> _open(BuildContext context) async {
    final result = await showModalBottomSheet<_PickerResult<T>>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => _PickerSheet<T>(
        title: sheetTitle,
        options: options,
        selected: state.value,
      ),
    );
    if (result == null) return;
    state.didChange(result.value);
    onChanged(result.value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = _selected;

    return InkWell(
      onTap: enabled && options.isNotEmpty ? () => _open(context) : null,
      borderRadius: BorderRadius.circular(14),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          errorText: state.errorText,
          enabled: enabled,
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        ).applyDefaults(theme.inputDecorationTheme),
        // Keeps the label resting inside the box while nothing is chosen, so
        // the field matches the empty text fields sitting next to it.
        isEmpty: selected == null,
        child: selected == null
            ? const SizedBox(height: 24)
            : Row(
                children: [
                  if (selected.icon != null) ...[
                    Icon(selected.icon, size: 20, color: selected.iconColor ?? theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Text(
                      selected.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Wrapper so "sheet dismissed" (null) stays distinguishable from "the user
/// picked the option whose value is null".
class _PickerResult<T> {
  const _PickerResult(this.value);
  final T? value;
}

class _PickerSheet<T> extends StatefulWidget {
  const _PickerSheet({required this.title, required this.options, required this.selected});

  final String title;
  final List<PickerOption<T>> options;
  final T? selected;

  @override
  State<_PickerSheet<T>> createState() => _PickerSheetState<T>();
}

class _PickerSheetState<T> extends State<_PickerSheet<T>> {
  final _searchController = TextEditingController();
  String _query = '';

  bool get _isSearchable => widget.options.length > _searchThreshold;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<PickerOption<T>> get _visibleOptions {
    if (_query.isEmpty) return widget.options;
    return widget.options.where((option) => option._matches(_query)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final visible = _visibleOptions;

    return SafeArea(
      child: Padding(
        // Lifts the sheet clear of the keyboard when the search box is focused.
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Text(widget.title, style: theme.textTheme.titleMedium),
              ),
              if (_isSearchable)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: TextField(
                    controller: _searchController,
                    autofocus: false,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: l10n.commonSearch,
                      prefixIcon: const Icon(Icons.search_rounded),
                      isDense: true,
                    ),
                    onChanged: (value) => setState(() => _query = value.trim().toLowerCase()),
                  ),
                ),
              Flexible(
                child: visible.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          l10n.commonNoMatches,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: theme.colorScheme.outline),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                        itemCount: visible.length,
                        itemBuilder: (context, index) {
                          final option = visible[index];
                          return _PickerRow<T>(
                            option: option,
                            isSelected: option.value == widget.selected,
                            onTap: () => Navigator.of(context).pop(_PickerResult<T>(option.value)),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerRow<T> extends StatelessWidget {
  const _PickerRow({required this.option, required this.isSelected, required this.onTap});

  final PickerOption<T> option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final foreground = isSelected ? scheme.onPrimaryContainer : scheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: isSelected ? scheme.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                if (option.icon != null) ...[
                  Icon(
                    option.icon,
                    size: 22,
                    color: isSelected ? foreground : (option.iconColor ?? scheme.onSurfaceVariant),
                  ),
                  const SizedBox(width: 14),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.label,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: foreground,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                      if (option.subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          option.subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isSelected ? foreground.withValues(alpha: 0.8) : scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isSelected) Icon(Icons.check_rounded, size: 20, color: foreground),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
