import 'package:ng_poland_conf_app/core/domain/app_exception.dart';

class EventNotFoundException extends AppException {
  const EventNotFoundException([
    super.message = 'This session is no longer in the agenda.',
  ]);
}
