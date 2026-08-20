enum UserRole {
  user,
  admin;

  static UserRole fromId(String? raw) {
    if (raw == 'admin') return UserRole.admin;
    return UserRole.user;
  }

  String get id => name;
}
