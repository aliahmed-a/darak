import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/emergency_contact.dart';
import '../providers/family_contacts_provider.dart';

class EmergencyContactsScreen extends ConsumerWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(emergencyContactsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.emergencyContactsTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.emergencyContactForm),
        child: const Icon(Icons.add),
      ),
      body: AsyncValueView(
        value: contacts,
        onRetry: () => ref.invalidate(emergencyContactsProvider),
        data: (context, data) {
          if (data.isEmpty) {
            return Center(child: Text(l10n.emergencyContactsEmpty));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(emergencyContactsProvider),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _ContactCard(contact: data[index]),
            ),
          );
        },
      ),
    );
  }
}

class _ContactCard extends ConsumerWidget {
  const _ContactCard({required this.contact});

  final EmergencyContact contact;

  Future<void> _deactivate(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.emergencyContactRemoveTitle),
        content: Text(l10n.emergencyContactRemoveConfirm(contact.fullName)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonCancel)),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonRemove)),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref.read(familyContactsApiProvider).deactivateEmergencyContact(contact.id);
      ref.invalidate(emergencyContactsProvider);
    } on ApiException catch (e) {
      if (!context.mounted) return;
      showErrorSnack(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(contact.fullName.isNotEmpty ? contact.fullName[0] : '?')),
        title: Text(contact.fullName, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text([
          contact.relationship,
          contact.phoneNumber,
          if (!contact.isActive) l10n.commonInactive,
        ].join(' · ')),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => context.push(Routes.emergencyContactForm, extra: contact),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _deactivate(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
