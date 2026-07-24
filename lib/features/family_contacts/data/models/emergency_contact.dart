class EmergencyContact {
  const EmergencyContact({
    required this.id,
    required this.fullName,
    required this.relationship,
    required this.phoneNumber,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String fullName;
  final String relationship;
  final String phoneNumber;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  factory EmergencyContact.fromJson(Map<String, dynamic> json) => EmergencyContact(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        relationship: json['relationship'] as String,
        phoneNumber: json['phoneNumber'] as String,
        isActive: json['isActive'] as bool,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
      );
}
