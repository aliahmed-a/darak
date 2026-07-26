import 'package:flutter/material.dart';

import '../../../../core/widgets/app_picker_field.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../dashboard/data/models/resident_property_summary.dart';

/// Builds the picker rows for a resident's units, shared by every screen that
/// asks "which unit is this about?".
///
/// The building and floor already come down with each unit but the old
/// dropdown had nowhere to put them, so a resident with two units in different
/// blocks saw two identical-looking rows.
List<PickerOption<String>> propertyPickerOptions(
  BuildContext context,
  List<ResidentPropertySummary> properties,
) {
  final l10n = AppLocalizations.of(context)!;
  return properties
      .map(
        (property) => PickerOption<String>(
          value: property.propertyUnitId,
          label: l10n.unitOnly(property.unitNumber),
          subtitle: _subtitle(l10n, property),
          icon: Icons.apartment_outlined,
        ),
      )
      .toList();
}

String? _subtitle(AppLocalizations l10n, ResidentPropertySummary property) {
  final parts = <String>[
    if (property.buildingName != null && property.buildingName!.isNotEmpty) property.buildingName!,
    if (property.floorNumber != null) l10n.propertyFloor('${property.floorNumber}'),
  ];
  return parts.isEmpty ? null : parts.join(' · ');
}
