import '../../../core/network/api_client.dart';
import 'models/emergency_contact.dart';
import 'models/family_member.dart';

class FamilyContactsApi {
  const FamilyContactsApi(this._client);

  final ApiClient _client;

  String _dateOnly(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  Future<List<FamilyMember>> getFamilyMembers() => runApiCall(() async {
        final response = await _client.dio.get('/resident/account/family-members');
        return (response.data as List).map((e) => FamilyMember.fromJson(e as Map<String, dynamic>)).toList();
      });

  Future<FamilyMember> createFamilyMember({
    required String fullName,
    required String relationship,
    DateTime? dateOfBirth,
    String? phoneNumber,
  }) =>
      runApiCall(() async {
        final response = await _client.dio.post('/resident/account/family-members', data: {
          'fullName': fullName,
          'relationship': relationship,
          'dateOfBirth': dateOfBirth == null ? null : _dateOnly(dateOfBirth),
          'phoneNumber': phoneNumber,
        });
        return FamilyMember.fromJson(response.data as Map<String, dynamic>);
      });

  Future<FamilyMember> updateFamilyMember(
    String id, {
    required String fullName,
    required String relationship,
    required bool isActive,
    DateTime? dateOfBirth,
    String? phoneNumber,
  }) =>
      runApiCall(() async {
        final response = await _client.dio.put('/resident/account/family-members/$id', data: {
          'fullName': fullName,
          'relationship': relationship,
          'dateOfBirth': dateOfBirth == null ? null : _dateOnly(dateOfBirth),
          'phoneNumber': phoneNumber,
          'isActive': isActive,
        });
        return FamilyMember.fromJson(response.data as Map<String, dynamic>);
      });

  Future<void> deactivateFamilyMember(String id) => runApiCall(() async {
        await _client.dio.delete('/resident/account/family-members/$id');
      });

  Future<List<EmergencyContact>> getEmergencyContacts() => runApiCall(() async {
        final response = await _client.dio.get('/resident/account/emergency-contacts');
        return (response.data as List).map((e) => EmergencyContact.fromJson(e as Map<String, dynamic>)).toList();
      });

  Future<EmergencyContact> createEmergencyContact({
    required String fullName,
    required String relationship,
    required String phoneNumber,
  }) =>
      runApiCall(() async {
        final response = await _client.dio.post('/resident/account/emergency-contacts', data: {
          'fullName': fullName,
          'relationship': relationship,
          'phoneNumber': phoneNumber,
        });
        return EmergencyContact.fromJson(response.data as Map<String, dynamic>);
      });

  Future<EmergencyContact> updateEmergencyContact(
    String id, {
    required String fullName,
    required String relationship,
    required String phoneNumber,
    required bool isActive,
  }) =>
      runApiCall(() async {
        final response = await _client.dio.put('/resident/account/emergency-contacts/$id', data: {
          'fullName': fullName,
          'relationship': relationship,
          'phoneNumber': phoneNumber,
          'isActive': isActive,
        });
        return EmergencyContact.fromJson(response.data as Map<String, dynamic>);
      });

  Future<void> deactivateEmergencyContact(String id) => runApiCall(() async {
        await _client.dio.delete('/resident/account/emergency-contacts/$id');
      });
}
