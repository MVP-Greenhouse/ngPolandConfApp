import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/data/json_object.dart';

void main() {
  const json = JsonObject({
    'name': 'NG Poland',
    'year': '2026',
    'price': 12.9,
    'published': true,
    'empty': '',
    'venue': {'city': 'Warsaw'},
    'days': [
      {'key': 'ng'},
      'not an object',
    ],
  });

  test('reads typed values and falls back for wrong types', () {
    expect(json.string('name'), 'NG Poland');
    expect(json.string('year'), '2026');
    expect(json.string('published'), isEmpty);
    expect(json.optionalString('empty'), isNull);
    expect(json.integer('year'), 2026);
    expect(json.integer('price'), 12);
    expect(json.integer('missing'), isNull);
    expect(json.flag('published'), isTrue);
    expect(json.flag('name'), isFalse);
  });

  test('wraps nested objects and lists of objects', () {
    expect(json.object('venue').string('city'), 'Warsaw');
    expect(json.object('missing').isEmpty, isTrue);
    expect(json.objects('days').map((day) => day.string('key')), ['ng', '']);
  });

  test('from accepts maps with non-string keys', () {
    expect(JsonObject.from({1: 'one'}).string('1'), 'one');
    expect(JsonObject.from('text').isEmpty, isTrue);
  });
}
