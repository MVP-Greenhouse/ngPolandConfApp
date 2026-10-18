/// Identity returned by the authentication provider.
class AuthUser {
  const AuthUser({required this.uid, this.displayName = '', this.email = ''});

  final String uid;
  final String displayName;
  final String email;
}
