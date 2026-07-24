import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/family_contacts_api.dart';
import '../../data/models/emergency_contact.dart';
import '../../data/models/family_member.dart';

final familyContactsApiProvider = Provider<FamilyContactsApi>((ref) {
  return FamilyContactsApi(ref.watch(apiClientProvider));
});

final familyMembersProvider = FutureProvider.autoDispose<List<FamilyMember>>((ref) {
  return ref.watch(familyContactsApiProvider).getFamilyMembers();
});

final emergencyContactsProvider = FutureProvider.autoDispose<List<EmergencyContact>>((ref) {
  return ref.watch(familyContactsApiProvider).getEmergencyContacts();
});
