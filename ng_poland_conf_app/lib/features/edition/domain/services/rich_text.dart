final _tags = RegExp(r'<[^>]*>');
final _entities = RegExp(r'&\w+;');

/// Whether [plain] or the text content of [html] has anything to show.
bool hasVisibleText({required String html, required String plain}) {
  if (plain.trim().isNotEmpty) return true;
  return html
      .replaceAll(_tags, ' ')
      .replaceAll(_entities, ' ')
      .trim()
      .isNotEmpty;
}
