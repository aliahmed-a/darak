import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/family_member.dart';
import '../providers/family_contacts_provider.dart';

class FamilyMembersScreen extends ConsumerWidget {
  const FamilyMembersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(familyMembersProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.familyMembersTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.familyMemberForm),
        child: const Icon(Icons.add),
      ),
      body: AsyncValueView(
        value: members,
        onRetry: () => ref.invalidate(familyMembersProvider),
        data: (context, data) {
          if (data.isEmpty) {
            return Center(child: Text(l10n.familyMembersEmpty));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(familyMembersProvider),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _MemberCard(member: data[index]),
            ),
          );
        },
      ),
    );
  }
}

class _MemberCard extends ConsumerWidget {
  const _MemberCard({required this.member});

  final FamilyMember member;

  Future<void> _deactivate(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.familyMemberRemoveTitle),
        content: Text(l10n.familyMemberRemoveConfirm(member.fullName)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonCancel)),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonRemove)),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref.read(familyContactsApiProvider).deactivateFamilyMember(member.id);
      ref.invalidate(familyMembersProvider);
    } on ApiException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(member.fullName.isNotEmpty ? member.fullName[0] : '?')),
        title: Text(member.fullName, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text([
          member.relationship,
          if (member.dateOfBirth != null) l10n.familyMemberBorn(Formatters.date(member.dateOfBirth!)),
          if (member.phoneNumber != null) member.phoneNumber!,
          if (!member.isActive) l10n.commonInactive,
        ].join(' · ')),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => context.push(Routes.familyMemberForm, extra: member),
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
