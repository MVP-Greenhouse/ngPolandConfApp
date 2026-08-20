import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_participant.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';

class EngagementMappers {
  const EngagementMappers._();

  static final DateTime _epochUtc = DateTime.fromMillisecondsSinceEpoch(
    0,
    isUtc: true,
  );

  static EngagementConfig configFromMap(Map<String, dynamic>? data) {
    if (data == null) return EngagementConfig.missing;
    return EngagementConfig(
      votingEnabled: data['votingEnabled'] as bool? ?? false,
      votingStartsAt: _dateTime(data['votingStartsAt']),
      votingEndsAt: _dateTime(data['votingEndsAt']),
      contestEnabled: data['contestEnabled'] as bool? ?? false,
      contestStartsAt: _dateTime(data['contestStartsAt']),
      contestEndsAt: _dateTime(data['contestEndsAt']),
      contestStatus: ContestStatusX.fromId(data['contestStatus'] as String?),
    );
  }

  static Map<String, dynamic> configToMap(EngagementConfig config) {
    return {
      'votingEnabled': config.votingEnabled,
      'votingStartsAt': config.votingStartsAt,
      'votingEndsAt': config.votingEndsAt,
      'contestEnabled': config.contestEnabled,
      'contestStartsAt': config.contestStartsAt,
      'contestEndsAt': config.contestEndsAt,
      'contestStatus': config.contestStatus.id,
    };
  }

  static SpeakerVoteValue? voteFromMap(Map<String, dynamic>? data) {
    if (data == null) return null;
    return SpeakerVoteValue.fromFirestore(readInt(data['value']));
  }

  static ContestParticipant? participantFromMap(
    String uid,
    Map<String, dynamic>? data,
  ) {
    if (data == null) return null;
    return ContestParticipant(
      uid: uid,
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
    );
  }

  static ContestWinner? winnerFromMap(String uid, Map<String, dynamic>? data) {
    if (data == null) return null;
    return ContestWinner(
      uid: uid,
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      order: readInt(data['order']) ?? 0,
    );
  }

  static int? readInt(Object? value) {
    return value is int ? value : (value is num ? value.toInt() : null);
  }

  static DateTime _dateTime(dynamic value) {
    if (value is DateTime) return value;
    return _epochUtc;
  }
}
