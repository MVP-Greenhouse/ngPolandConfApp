import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/widgets/app_image_cache_io.dart';

void main() {
  test('a cached image stays valid when the server sends max-age 0', () {
    final response = KeptImageResponse(
      _ImmediateExpiry(),
      now: DateTime.utc(2026, 10, 10),
    );

    expect(response.validTill, DateTime.utc(2026, 11, 9));
    expect(response.statusCode, 200);
    expect(response.eTag, 'photo');
    expect(response.fileExtension, '.jpg');
  });
}

class _ImmediateExpiry implements FileServiceResponse {
  @override
  Stream<List<int>> get content => const Stream.empty();

  @override
  int? get contentLength => 12;

  @override
  String? get eTag => 'photo';

  @override
  String get fileExtension => '.jpg';

  @override
  int get statusCode => 200;

  @override
  DateTime get validTill => DateTime.fromMillisecondsSinceEpoch(0);
}
