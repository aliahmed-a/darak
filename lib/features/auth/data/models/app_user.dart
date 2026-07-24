class AppUser {
  const AppUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.roles,
  });

  final String id;
  final String email;
  final String fullName;
  final List<String> roles;

  bool get isResident => roles.contains('Resident');
  bool get isGuard => roles.contains('Guard');

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['id'] as String,
        email: json['email'] as String,
        fullName: json['fullName'] as String,
        roles: List<String>.from(json['roles'] as List),
      );
}
