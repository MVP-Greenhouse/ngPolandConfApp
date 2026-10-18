import 'package:ng_poland_conf_app/core/domain/app_exception.dart';

/// Reading or writing voting data failed.
class EngagementException extends AppException {
  const EngagementException([
    super.message = 'Voting data is not available right now.',
  ]);
}

/// The vote cannot be cast in the current session (e.g. signed out).
class VoteRejectedException extends EngagementException {
  const VoteRejectedException(super.message);
}

/// The agenda belongs to a different conference than the one being synced.
class EditionMismatchException extends EngagementException {
  EditionMismatchException({
    required String editionConfId,
    required String confId,
  }) : super('Agenda is for $editionConfId, selected conference is $confId');
}
