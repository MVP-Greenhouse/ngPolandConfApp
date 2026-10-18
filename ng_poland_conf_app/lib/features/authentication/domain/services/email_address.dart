/// Minimal sanity check before asking Firebase to send a sign-in link.
bool isValidEmailAddress(String email) {
  final trimmed = email.trim();
  return trimmed.isNotEmpty && trimmed.contains('@');
}
