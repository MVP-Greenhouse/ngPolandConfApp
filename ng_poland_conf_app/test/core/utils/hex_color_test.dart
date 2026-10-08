import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/utils/hex_color.dart';

void main() {
  test('parses a six digit hex color', () {
    expect(colorFromHex('#FF2D87'), const Color(0xFFFF2D87));
    expect(colorFromHex('1A1024'), const Color(0xFF1A1024));
  });

  test('returns null for an empty or invalid value', () {
    expect(colorFromHex(''), isNull);
    expect(colorFromHex('#'), isNull);
    expect(colorFromHex('xyz'), isNull);
    expect(colorFromHex('#FFF'), isNull);
  });
}
