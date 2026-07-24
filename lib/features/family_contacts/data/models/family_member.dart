class FamilyMember {
  const FamilyMember({
    required this.id,
    required this.fullName,
    required this.relationship,
    required this.isActive,
    required this.createdAt,
    this.dateOfBirth,
    this.phoneNumber,
    this.updatedAt,
  });

  final String id;
  final String fullName;
  final String relationship;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        relationship: json['relationship'] as String,
        dateOfBirth: json['dateOfBirth'] == null ? null : DateTime.parse(json['dateOfBirth'] as String),
        phoneNumber: json['phoneNumber'] as String?,
        isActive: json['isActive'] as bool,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
      );
}
