import 'package:ng_poland_conf_app/core/domain/app_exception.dart';

class SpeakerNotFoundException extends AppException {
  const SpeakerNotFoundException([
    super.message = 'This speaker is no longer in the agenda.',
  ]);
}
