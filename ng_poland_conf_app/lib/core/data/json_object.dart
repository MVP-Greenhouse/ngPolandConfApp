import 'package:ng_poland_conf_app/core/utils/object_extensions.dart';

/// Typed, zero-cost view over a decoded JSON object.
///
/// Missing keys and values of an unexpected type read as empty values, which
/// matches how the ng-poland API treats optional fields.
extension type const JsonObject(Map<String, Object?> _json) {
  factory JsonObject.from(Object? raw) => switch (raw) {
    final Map<String, Object?> map => JsonObject(map),
    final Map<Object?, Object?> map => JsonObject({
      for (final MapEntry(:key, :value) in map.entries) '$key': value,
    }),
    _ => const JsonObject({}),
  };

  bool get isEmpty => _json.isEmpty;

  String string(String key) => _json[key].castOrNull<String>() ?? '';

  /// Like [string] but maps an empty value to `null`.
  String? optionalString(String key) =>
      string(key).let((value) => value.isEmpty ? null : value);

  int? integer(String key) => switch (_json[key]) {
    final int value => value,
    final num value => value.toInt(),
    final String value => int.tryParse(value),
    _ => null,
  };

  bool flag(String key) => _json[key] == true;

  JsonObject object(String key) => JsonObject.from(_json[key]);

  List<Object?> list(String key) =>
      _json[key].castOrNull<List<Object?>>() ?? const [];

  Iterable<JsonObject> objects(String key) => list(key).map(JsonObject.from);
}
