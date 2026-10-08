import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/edition/domains/repositories/edition_store.dart';

@LazySingleton(as: EditionRemote)
class NgPolandApi implements EditionRemote {
  NgPolandApi(this._dio);

  final Dio _dio;

  static const host = 'https://ng-poland.pl';

  @override
  Future<EditionFetch> get(String path, {String? etag}) async {
    final response = await _dio.get<String>(
      '$host$path',
      options: Options(
        responseType: ResponseType.plain,
        headers: {
          if (etag != null && etag.isNotEmpty) 'If-None-Match': etag,
        },
        validateStatus: (code) => code == 200 || code == 304,
      ),
    );
    final responseEtag = response.headers.value('etag');
    if (response.statusCode == 304) {
      return EditionFetch.notModified(etag: responseEtag ?? etag);
    }
    return EditionFetch.ok(body: response.data ?? '', etag: responseEtag);
  }
}
