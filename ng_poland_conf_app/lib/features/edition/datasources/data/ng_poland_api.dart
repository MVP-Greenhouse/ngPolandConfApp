import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/edition/domains/repositories/edition_store.dart';

@LazySingleton(as: EditionRemote)
class NgPolandApi implements EditionRemote {
  NgPolandApi(this._dio);

  final Dio _dio;

  @override
  Future<EditionFetch> agenda({String? etag}) =>
      _get('/api/agenda.json', etag: etag);

  @override
  Future<EditionFetch> speakers({String? etag}) =>
      _get('/api/speakers.json', etag: etag);

  Future<EditionFetch> _get(String path, {String? etag}) async {
    final response = await _dio.get<String>(
      path,
      options: Options(
        responseType: ResponseType.plain,
        headers: {if (etag != null && etag.isNotEmpty) 'If-None-Match': etag},
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
