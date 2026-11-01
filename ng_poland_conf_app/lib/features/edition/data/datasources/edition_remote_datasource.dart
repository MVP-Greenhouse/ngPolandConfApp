import 'package:ng_poland_conf_app/features/edition/data/models/edition_fetch.dart';

abstract interface class EditionRemote {
  Future<EditionFetch> agenda({String? etag});

  Future<EditionFetch> speakers({String? etag});
}
