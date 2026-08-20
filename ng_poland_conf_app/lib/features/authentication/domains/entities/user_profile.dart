import 'user_role.dart';

class UserProfile {
  const UserProfile({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.role,
  });

  final String uid;
  final String displayName;
  final String email;
  final UserRole role;

  bool get isAdmin => role == UserRole.admin;
}
