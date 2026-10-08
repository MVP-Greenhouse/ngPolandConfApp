String networkPhotoUrl(String? raw) {
  if (raw == null || raw.isEmpty) return '';
  if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
  if (raw.startsWith('//')) return 'https:$raw';
  return raw;
}
