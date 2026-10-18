import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/utils/object_extensions.dart';

void main() {
  test('let transforms a value inline', () {
    expect(' 42 '.let((it) => int.parse(it.trim())), 42);
  });

  test('let chains after a null-aware access', () {
    const String? missing = null;
    expect(missing?.let((it) => it.length), isNull);
  });

  test('castOrNull returns the value only for the requested type', () {
    const Object number = 7;
    expect(number.castOrNull<int>(), 7);
    expect(number.castOrNull<String>(), isNull);
    expect(null.castOrNull<int>(), isNull);
  });
}
