/// Top-level destinations shown in the drawer and bottom navigation.
enum Pages {
  home('/', 'Home'),
  schedule('/schedule', 'Schedule'),
  workshops('/workshops', 'Workshops'),
  speakers('/speakers', 'Speakers'),
  questions('/questions', 'Q&A'),
  info('/info', 'Info'),
  about('/about', 'About');

  const Pages(this.path, this.nameKey);

  final String path;
  final String nameKey;
}

/// Paths of routes that are not [Pages].
abstract final class AppPaths {
  static const auth = '/auth';
  static const admin = '/admin';
}
