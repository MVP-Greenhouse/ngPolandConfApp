import 'package:ng_poland_conf_app/core/domain/app_exception.dart';

/// Neither the network nor the local cache could provide the edition.
class EditionUnavailableException extends AppException {
  const EditionUnavailableException([
    super.message = 'Conference data is not available right now.',
  ]);
}
