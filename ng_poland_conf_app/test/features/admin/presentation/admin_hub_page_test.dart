import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/pages/admin_page.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';

import '../../../helpers/admin_cubit_factory.dart';
import '../../../helpers/fakes.dart';

void main() {
  final trackConfig = TrackEngagementConfig(
    votingEnabled: true,
    votingStartsAt: DateTime.utc(2026, 1, 1),
    votingEndsAt: DateTime.utc(2026, 1, 2),
    top5Enabled: true,
  );
  final config = EngagementConfig(
    tracks: {for (final type in EventItemType.values) type: trackConfig},
  );

  late FakeConferenceRepository conferences;
  late FakeUserSessionRepository sessions;
  late FakeEngagementConfigRepository configRepo;
  late AdminCubit cubit;

  setUp(() async {
    conferences = FakeConferenceRepository(
      const Conference(confId: '2026', confName: 'NG Poland', listItems: []),
    );
    sessions = FakeUserSessionRepository(
      const UserSession.signedIn(adminProfile),
    );
    configRepo = FakeEngagementConfigRepository(config);
    cubit = buildAdminCubit(
      sessions: sessions,
      conferences: conferences,
      configs: configRepo,
    );
    await pumpUntil(() => cubit.state.config != null);
  });

  tearDown(() async {
    await cubit.close();
    await sessions.dispose();
    await conferences.dispose();
    await configRepo.dispose();
  });

  testWidgets('shows voting hub without per-track status', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: const [AppPalette.light]),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AdminCubit>.value(value: cubit),
            BlocProvider(create: (_) => fakeConnectivityCubit()),
          ],
          child: const AdminPage(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Voting'), findsOneWidget);
    expect(find.byType(AdminHubNavRow), findsOneWidget);
    expect(find.text('enabled'), findsNothing);
    expect(find.textContaining('Top 5:'), findsNothing);

    final syncButton = tester.widget<ButtonStyleButton>(
      find.ancestor(
        of: find.text('Sync votable events'),
        matching: find.bySubtype<ButtonStyleButton>(),
      ),
    );
    expect(syncButton.onPressed, isNotNull);
  });
}
