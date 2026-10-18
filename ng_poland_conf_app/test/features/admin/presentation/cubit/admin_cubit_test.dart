import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/app_notice.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/edition/data/mappers/edition_parser.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';
import 'package:timezone/data/latest.dart' as tzdata;

import '../../../../helpers/admin_cubit_factory.dart';
import '../../../../helpers/fakes.dart';

TrackEngagementConfig _track({
  bool votingEnabled = true,
  bool top5Enabled = false,
}) {
  return TrackEngagementConfig(
    votingEnabled: votingEnabled,
    votingStartsAt: DateTime.utc(2026, 1, 1),
    votingEndsAt: DateTime.utc(2026, 12, 31),
    top5Enabled: top5Enabled,
  );
}

EngagementConfig _config(TrackEngagementConfig track) {
  return EngagementConfig(
    tracks: {for (final type in EventItemType.values) type: track},
  );
}

void main() {
  setUpAll(tzdata.initializeTimeZones);

  late FakeEngagementConfigRepository configRepo;
  late FakeConferenceRepository conferences;
  late FakeUserSessionRepository sessions;
  late FakeVotableEventRepository votableEvents;
  late FakeEditionRepository editions;
  late AdminCubit cubit;

  setUp(() async {
    configRepo = FakeEngagementConfigRepository(_config(_track()));
    conferences = FakeConferenceRepository(
      const Conference(confId: '2026', confName: 'NG', listItems: []),
    );
    sessions = FakeUserSessionRepository(
      const UserSession.signedIn(adminProfile),
    );
    votableEvents = FakeVotableEventRepository();
    editions = FakeEditionRepository();
    cubit = buildAdminCubit(
      sessions: sessions,
      conferences: conferences,
      configs: configRepo,
      editions: editions,
      votableEvents: votableEvents,
    );
    await pumpUntil(
      () => cubit.state.selectedConfId == '2026' && cubit.state.config != null,
    );
  });

  tearDown(() async {
    await cubit.close();
    await sessions.dispose();
    await conferences.dispose();
    await configRepo.dispose();
  });

  test('non-admins get an empty dashboard', () async {
    sessions.emit(const UserSession.signedIn(userProfile));
    await pumpUntil(() => !cubit.state.isAdmin);

    expect(cubit.state.isAdmin, isFalse);
    expect(cubit.state.config, isNull);
  });

  test('endVotingNow sets votingEndsAt to now for selected track', () async {
    final before = DateTime.now().toUtc();
    await cubit.endVotingNow();

    final saved = configRepo.lastSavedTrack;
    expect(saved, isNotNull);
    expect(configRepo.lastSavedTrackType, EventItemType.ngPoland);
    expect(
      saved!.votingEndsAt.isAfter(before.subtract(const Duration(seconds: 2))),
      isTrue,
    );
  });

  test('saveTop5Enabled persists flag for selected track', () async {
    await cubit.saveTop5Enabled(true);

    expect(configRepo.lastSavedTrack?.top5Enabled, isTrue);
    expect(configRepo.lastSavedTrackType, EventItemType.ngPoland);
  });

  test('selectTrack switches the edited track', () async {
    expect(cubit.state.availableTracks, contains(EventItemType.aiPoland));
    cubit.selectTrack(EventItemType.jsPoland);
    await pumpUntil(() => cubit.state.selectedTrack == EventItemType.jsPoland);

    await cubit.saveTop5Enabled(true);

    expect(configRepo.lastSavedTrackType, EventItemType.jsPoland);
  });

  test('syncVotableEvents writes the agenda allowlist', () async {
    editions.refreshed = parseEditionBodies((
      agenda: _syncAgenda,
      speakers: _syncSpeakers,
    ));

    await cubit.syncVotableEvents();

    expect(votableEvents.replaceCalls, 1);
    expect(votableEvents.lastConfId, '2026');
    expect(votableEvents.lastEvents?.single.eventId, '2');
    expect(cubit.state.notice?.tone, AppNoticeTone.success);
    expect(cubit.state.notice?.body, 'Synced 1 votable event');
  });

  test(
    'syncVotableEvents does not write when the agenda request fails',
    () async {
      await cubit.syncVotableEvents();

      expect(votableEvents.replaceCalls, 0);
      expect(cubit.state.notice?.tone, AppNoticeTone.error);
    },
  );
}

const _syncAgenda = '''
{
  "year": 2026,
  "days": [
    {
      "key": "ng",
      "kind": "conference",
      "conference": "ng",
      "date": "2026-11-17",
      "published": true,
      "items": [
        {
          "id": 2,
          "isBreak": false,
          "start": "09:00",
          "end": "09:40",
          "title": "Opening Keynote",
          "speakers": [{"name": "Anna", "slug": "anna"}]
        },
        {
          "id": 3,
          "isBreak": true,
          "start": "09:40",
          "end": "10:00",
          "title": "Break",
          "speakers": []
        }
      ]
    },
    {
      "key": "workshops",
      "kind": "workshops",
      "date": "2026-11-16",
      "published": true,
      "items": [
        {"id": 20, "title": "Workshop", "speakers": [{"name": "Anna", "slug": "anna"}]}
      ]
    }
  ]
}
''';

const _syncSpeakers = '{"year": 2026, "speakers": []}';
