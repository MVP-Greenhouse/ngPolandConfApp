// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:app_links/app_links.dart' as _i327;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../../core/data/connectivity_repository_impl.dart' as _i125;
import '../../core/data/hive_store.dart' as _i1002;
import '../../core/domain/repositories/connectivity_repository.dart' as _i307;
import '../../core/domain/usecases/watch_connectivity.dart' as _i339;
import '../../core/presentation/cubit/connectivity_cubit.dart' as _i766;
import '../../features/admin/presentation/cubit/admin_cubit.dart' as _i684;
import '../../features/authentication/data/datasources/magic_link_email_local_datasource.dart'
    as _i235;
import '../../features/authentication/data/datasources/user_remote_datasource.dart'
    as _i833;
import '../../features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i195;
import '../../features/authentication/data/repositories/incoming_links_repository_impl.dart'
    as _i623;
import '../../features/authentication/data/repositories/user_repository_impl.dart'
    as _i629;
import '../../features/authentication/data/repositories/user_session_repository_impl.dart'
    as _i1;
import '../../features/authentication/domain/repositories/authentication_repository.dart'
    as _i1048;
import '../../features/authentication/domain/repositories/incoming_links_repository.dart'
    as _i148;
import '../../features/authentication/domain/repositories/user_repository.dart'
    as _i875;
import '../../features/authentication/domain/repositories/user_session_repository.dart'
    as _i879;
import '../../features/authentication/domain/usecases/complete_magic_link.dart'
    as _i24;
import '../../features/authentication/domain/usecases/delete_account.dart'
    as _i1059;
import '../../features/authentication/domain/usecases/ensure_user_profile.dart'
    as _i537;
import '../../features/authentication/domain/usecases/get_user_session.dart'
    as _i419;
import '../../features/authentication/domain/usecases/handle_magic_link.dart'
    as _i965;
import '../../features/authentication/domain/usecases/send_magic_link.dart'
    as _i790;
import '../../features/authentication/domain/usecases/sign_in_with_apple.dart'
    as _i136;
import '../../features/authentication/domain/usecases/sign_in_with_google.dart'
    as _i185;
import '../../features/authentication/domain/usecases/sign_out.dart' as _i559;
import '../../features/authentication/domain/usecases/watch_incoming_links.dart'
    as _i722;
import '../../features/authentication/domain/usecases/watch_user_session.dart'
    as _i233;
import '../../features/authentication/presentation/cubit/authentication_cubit.dart'
    as _i675;
import '../../features/authentication/presentation/cubit/user_session_cubit.dart'
    as _i399;
import '../../features/authentication/presentation/magic_link_listener.dart'
    as _i244;
import '../../features/edition/data/datasources/edition_cache_datasource.dart'
    as _i953;
import '../../features/edition/data/datasources/edition_hive_cache.dart'
    as _i708;
import '../../features/edition/data/datasources/edition_remote_datasource.dart'
    as _i530;
import '../../features/edition/data/datasources/ng_poland_api.dart' as _i486;
import '../../features/edition/data/repositories/edition_repository_impl.dart'
    as _i434;
import '../../features/edition/domain/entities/event_item_type.dart' as _i1046;
import '../../features/edition/domain/repositories/edition_repository.dart'
    as _i232;
import '../../features/edition/domain/usecases/get_edition.dart' as _i473;
import '../../features/edition/domain/usecases/refresh_edition.dart' as _i989;
import '../../features/edition/presentation/cubit/edition_cubit.dart' as _i309;
import '../../features/engagement/data/datasources/engagement_config_remote_datasource.dart'
    as _i382;
import '../../features/engagement/data/datasources/event_vote_remote_datasource.dart'
    as _i67;
import '../../features/engagement/data/datasources/votable_event_remote_datasource.dart'
    as _i420;
import '../../features/engagement/data/repositories/engagement_config_repository_impl.dart'
    as _i1067;
import '../../features/engagement/data/repositories/event_vote_repository_impl.dart'
    as _i266;
import '../../features/engagement/data/repositories/votable_event_repository_impl.dart'
    as _i136;
import '../../features/engagement/domain/repositories/engagement_config_repository.dart'
    as _i678;
import '../../features/engagement/domain/repositories/event_vote_repository.dart'
    as _i289;
import '../../features/engagement/domain/repositories/votable_event_repository.dart'
    as _i545;
import '../../features/engagement/domain/usecases/cast_event_vote.dart'
    as _i136;
import '../../features/engagement/domain/usecases/load_vote_ranking.dart'
    as _i961;
import '../../features/engagement/domain/usecases/sync_votable_events.dart'
    as _i350;
import '../../features/engagement/domain/usecases/update_track_engagement_config.dart'
    as _i77;
import '../../features/engagement/domain/usecases/watch_engagement_config.dart'
    as _i253;
import '../../features/engagement/domain/usecases/watch_event_vote.dart'
    as _i746;
import '../../features/engagement/domain/usecases/watch_top5.dart' as _i130;
import '../../features/engagement/domain/usecases/watch_track_engagement.dart'
    as _i28;
import '../../features/event/domain/usecases/get_event.dart' as _i564;
import '../../features/event/presentation/cubit/event_cubit.dart' as _i980;
import '../../features/event/presentation/cubit/event_vote_cubit.dart' as _i408;
import '../../features/home/data/repositories/conference_repository_impl.dart'
    as _i713;
import '../../features/home/domain/repositories/conference_repository.dart'
    as _i268;
import '../../features/home/domain/usecases/load_current_conference.dart'
    as _i842;
import '../../features/home/domain/usecases/watch_current_conference.dart'
    as _i1007;
import '../../features/home/presentation/cubit/conferences_cubit.dart' as _i994;
import '../../features/info/domain/usecases/get_venue_info.dart' as _i132;
import '../../features/info/presentation/cubit/info_cubit.dart' as _i52;
import '../../features/schedule/domain/usecases/get_track_schedule.dart'
    as _i552;
import '../../features/schedule/presentation/cubit/schedule_cubit.dart'
    as _i324;
import '../../features/schedule/presentation/cubit/schedule_top5_cubit.dart'
    as _i807;
import '../../features/schedule/presentation/cubit/schedule_voting_banner_cubit.dart'
    as _i362;
import '../../features/settings/data/datasources/theme_mode_local_datasource.dart'
    as _i412;
import '../../features/settings/data/repositories/theme_mode_repository_impl.dart'
    as _i249;
import '../../features/settings/domain/repositories/theme_mode_repository.dart'
    as _i789;
import '../../features/settings/domain/usecases/get_theme_mode.dart' as _i867;
import '../../features/settings/domain/usecases/set_theme_mode.dart' as _i743;
import '../../features/settings/presentation/cubit/theme_mode_cubit.dart'
    as _i963;
import '../../features/speakers/domain/usecases/get_speaker_details.dart'
    as _i35;
import '../../features/speakers/domain/usecases/get_track_speakers.dart'
    as _i496;
import '../../features/speakers/presentation/cubit/speaker_details_cubit.dart'
    as _i1053;
import '../../features/speakers/presentation/cubit/speakers_cubit.dart'
    as _i266;
import '../../features/workshops/domain/usecases/get_workshop_days.dart'
    as _i508;
import '../../features/workshops/presentation/cubit/workshops_cubit.dart'
    as _i526;
import '../config/app_config.dart' as _i650;
import '../config/raw_config.dart' as _i142;
import '../routing/app_router.dart' as _i282;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i833.UserRemoteDataSource>(() => _i833.UserRemoteDataSource());
    gh.factory<_i382.EngagementConfigRemoteDataSource>(
      () => _i382.EngagementConfigRemoteDataSource(),
    );
    gh.factory<_i67.EventVoteRemoteDataSource>(
      () => _i67.EventVoteRemoteDataSource(),
    );
    gh.factory<_i420.VotableEventRemoteDataSource>(
      () => _i420.VotableEventRemoteDataSource(),
    );
    await gh.singletonAsync<_i142.RawConfig>(
      () => registerModule.config(),
      preResolve: true,
    );
    gh.lazySingleton<_i327.AppLinks>(() => registerModule.appLinks());
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity());
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth());
    gh.lazySingleton<_i974.Logger>(() => registerModule.logger());
    gh.singleton<_i875.UserRepository>(
      () => _i629.UserRepositoryImpl(
        gh<_i833.UserRemoteDataSource>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i545.VotableEventRepository>(
      () => _i136.VotableEventRepositoryImpl(
        gh<_i420.VotableEventRemoteDataSource>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i678.EngagementConfigRepository>(
      () => _i1067.EngagementConfigRepositoryImpl(
        gh<_i382.EngagementConfigRemoteDataSource>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i289.EventVoteRepository>(
      () => _i266.EventVoteRepositoryImpl(
        gh<_i67.EventVoteRemoteDataSource>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i1002.HiveStore>(
      () => _i1002.HiveStore(gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i148.IncomingLinksRepository>(
      () => _i623.IncomingLinksRepositoryImpl(
        gh<_i327.AppLinks>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i412.ThemeModeLocalDataSource>(
      () => _i412.ThemeModeLocalDataSourceImpl(gh<_i1002.HiveStore>()),
    );
    gh.singleton<_i235.MagicLinkEmailLocalDataSource>(
      () => _i235.MagicLinkEmailLocalDataSourceImpl(gh<_i1002.HiveStore>()),
    );
    gh.lazySingleton<_i307.ConnectivityRepository>(
      () => _i125.ConnectivityRepositoryImpl(gh<_i895.Connectivity>()),
    );
    gh.factory<_i77.UpdateTrackEngagementConfig>(
      () => _i77.UpdateTrackEngagementConfig(
        gh<_i678.EngagementConfigRepository>(),
      ),
    );
    gh.factory<_i253.WatchEngagementConfig>(
      () => _i253.WatchEngagementConfig(gh<_i678.EngagementConfigRepository>()),
    );
    gh.singleton<_i650.AppConfig>(() => _i650.AppConfig(gh<_i142.RawConfig>()));
    gh.singleton<_i1048.AuthenticationRepository>(
      () => _i195.AuthenticationRepositoryImpl(
        gh<_i235.MagicLinkEmailLocalDataSource>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i953.EditionCache>(
      () => _i708.EditionHiveCache(gh<_i1002.HiveStore>()),
    );
    gh.factory<_i537.EnsureUserProfile>(
      () => _i537.EnsureUserProfile(gh<_i875.UserRepository>()),
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio(gh<_i650.AppConfig>()));
    gh.singleton<_i789.ThemeModeRepository>(
      () => _i249.ThemeModeRepositoryImpl(gh<_i412.ThemeModeLocalDataSource>()),
    );
    gh.factory<_i24.CompleteMagicLink>(
      () => _i24.CompleteMagicLink(
        gh<_i1048.AuthenticationRepository>(),
        gh<_i537.EnsureUserProfile>(),
      ),
    );
    gh.factory<_i136.SignInWithApple>(
      () => _i136.SignInWithApple(
        gh<_i1048.AuthenticationRepository>(),
        gh<_i537.EnsureUserProfile>(),
      ),
    );
    gh.factory<_i185.SignInWithGoogle>(
      () => _i185.SignInWithGoogle(
        gh<_i1048.AuthenticationRepository>(),
        gh<_i537.EnsureUserProfile>(),
      ),
    );
    gh.factory<_i1059.DeleteAccount>(
      () => _i1059.DeleteAccount(
        gh<_i1048.AuthenticationRepository>(),
        gh<_i875.UserRepository>(),
      ),
    );
    gh.factory<_i722.WatchIncomingLinks>(
      () => _i722.WatchIncomingLinks(gh<_i148.IncomingLinksRepository>()),
    );
    gh.factory<_i790.SendMagicLink>(
      () => _i790.SendMagicLink(gh<_i1048.AuthenticationRepository>()),
    );
    gh.factory<_i559.SignOut>(
      () => _i559.SignOut(gh<_i1048.AuthenticationRepository>()),
    );
    gh.factory<_i867.GetThemeMode>(
      () => _i867.GetThemeMode(gh<_i789.ThemeModeRepository>()),
    );
    gh.factory<_i743.SetThemeMode>(
      () => _i743.SetThemeMode(gh<_i789.ThemeModeRepository>()),
    );
    gh.factory<_i965.HandleMagicLink>(
      () => _i965.HandleMagicLink(
        gh<_i1048.AuthenticationRepository>(),
        gh<_i24.CompleteMagicLink>(),
      ),
    );
    gh.factory<_i339.WatchConnectivity>(
      () => _i339.WatchConnectivity(gh<_i307.ConnectivityRepository>()),
    );
    gh.lazySingleton<_i879.UserSessionRepository>(
      () => _i1.UserSessionRepositoryImpl(
        gh<_i1048.AuthenticationRepository>(),
        gh<_i875.UserRepository>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i530.EditionRemote>(
      () => _i486.NgPolandApi(gh<_i361.Dio>()),
    );
    gh.singleton<_i963.ThemeModeCubit>(
      () => _i963.ThemeModeCubit(
        gh<_i867.GetThemeMode>(),
        gh<_i743.SetThemeMode>(),
      ),
    );
    gh.factory<_i419.GetUserSession>(
      () => _i419.GetUserSession(gh<_i879.UserSessionRepository>()),
    );
    gh.factory<_i233.WatchUserSession>(
      () => _i233.WatchUserSession(gh<_i879.UserSessionRepository>()),
    );
    gh.lazySingleton<_i244.MagicLinkListener>(
      () => _i244.MagicLinkListener(
        gh<_i722.WatchIncomingLinks>(),
        gh<_i965.HandleMagicLink>(),
        gh<_i974.Logger>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i232.EditionRepository>(
      () => _i434.EditionRepositoryImpl(
        gh<_i530.EditionRemote>(),
        gh<_i953.EditionCache>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i399.UserSessionCubit>(
      () => _i399.UserSessionCubit(
        gh<_i233.WatchUserSession>(),
        gh<_i559.SignOut>(),
        gh<_i1059.DeleteAccount>(),
      ),
    );
    gh.factory<_i675.AuthenticationCubit>(
      () => _i675.AuthenticationCubit(
        gh<_i185.SignInWithGoogle>(),
        gh<_i136.SignInWithApple>(),
        gh<_i790.SendMagicLink>(),
        gh<_i24.CompleteMagicLink>(),
        gh<_i244.MagicLinkListener>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i766.ConnectivityCubit>(
      () => _i766.ConnectivityCubit(gh<_i339.WatchConnectivity>()),
    );
    gh.factory<_i564.GetEvent>(
      () => _i564.GetEvent(gh<_i232.EditionRepository>()),
    );
    gh.factory<_i132.GetVenueInfo>(
      () => _i132.GetVenueInfo(gh<_i232.EditionRepository>()),
    );
    gh.factory<_i552.GetTrackSchedule>(
      () => _i552.GetTrackSchedule(gh<_i232.EditionRepository>()),
    );
    gh.factory<_i35.GetSpeakerDetails>(
      () => _i35.GetSpeakerDetails(gh<_i232.EditionRepository>()),
    );
    gh.factory<_i496.GetTrackSpeakers>(
      () => _i496.GetTrackSpeakers(gh<_i232.EditionRepository>()),
    );
    gh.factory<_i508.GetWorkshopDays>(
      () => _i508.GetWorkshopDays(gh<_i232.EditionRepository>()),
    );
    gh.lazySingleton<_i268.ConferenceRepository>(
      () => _i713.ConferenceRepositoryImpl(gh<_i232.EditionRepository>()),
    );
    gh.factory<_i961.LoadVoteRanking>(
      () => _i961.LoadVoteRanking(
        gh<_i232.EditionRepository>(),
        gh<_i289.EventVoteRepository>(),
        gh<_i545.VotableEventRepository>(),
      ),
    );
    gh.factory<_i473.GetEdition>(
      () => _i473.GetEdition(gh<_i232.EditionRepository>()),
    );
    gh.factory<_i989.RefreshEdition>(
      () => _i989.RefreshEdition(gh<_i232.EditionRepository>()),
    );
    gh.factory<_i1053.SpeakerDetailsCubit>(
      () => _i1053.SpeakerDetailsCubit(
        gh<_i35.GetSpeakerDetails>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i309.EditionCubit>(
      () => _i309.EditionCubit(gh<_i473.GetEdition>(), gh<_i974.Logger>()),
    );
    gh.factory<_i842.LoadCurrentConference>(
      () => _i842.LoadCurrentConference(gh<_i268.ConferenceRepository>()),
    );
    gh.factory<_i1007.WatchCurrentConference>(
      () => _i1007.WatchCurrentConference(gh<_i268.ConferenceRepository>()),
    );
    gh.factory<_i266.SpeakersCubit>(
      () =>
          _i266.SpeakersCubit(gh<_i496.GetTrackSpeakers>(), gh<_i974.Logger>()),
    );
    gh.factory<_i324.ScheduleCubit>(
      () =>
          _i324.ScheduleCubit(gh<_i552.GetTrackSchedule>(), gh<_i974.Logger>()),
    );
    gh.factory<_i526.WorkshopsCubit>(
      () =>
          _i526.WorkshopsCubit(gh<_i508.GetWorkshopDays>(), gh<_i974.Logger>()),
    );
    gh.factory<_i350.SyncVotableEvents>(
      () => _i350.SyncVotableEvents(
        gh<_i232.EditionRepository>(),
        gh<_i545.VotableEventRepository>(),
      ),
    );
    gh.factory<_i28.WatchTrackEngagement>(
      () => _i28.WatchTrackEngagement(
        gh<_i268.ConferenceRepository>(),
        gh<_i678.EngagementConfigRepository>(),
      ),
    );
    gh.singleton<_i282.AppRouter>(
      () => _i282.AppRouter(gh<_i399.UserSessionCubit>()),
    );
    gh.factory<_i746.WatchEventVote>(
      () => _i746.WatchEventVote(
        gh<_i28.WatchTrackEngagement>(),
        gh<_i879.UserSessionRepository>(),
        gh<_i545.VotableEventRepository>(),
        gh<_i289.EventVoteRepository>(),
      ),
    );
    gh.factory<_i136.CastEventVote>(
      () => _i136.CastEventVote(
        gh<_i879.UserSessionRepository>(),
        gh<_i268.ConferenceRepository>(),
        gh<_i289.EventVoteRepository>(),
      ),
    );
    gh.factory<_i980.EventCubit>(
      () => _i980.EventCubit(gh<_i564.GetEvent>(), gh<_i974.Logger>()),
    );
    gh.factory<_i52.InfoCubit>(
      () => _i52.InfoCubit(gh<_i132.GetVenueInfo>(), gh<_i974.Logger>()),
    );
    gh.singleton<_i994.ConferencesCubit>(
      () => _i994.ConferencesCubit(
        gh<_i842.LoadCurrentConference>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.factoryParam<_i408.EventVoteCubit, String, _i1046.EventItemType>(
      (eventId, track) => _i408.EventVoteCubit(
        gh<_i746.WatchEventVote>(),
        gh<_i136.CastEventVote>(),
        gh<_i974.Logger>(),
        eventId,
        track,
      ),
    );
    gh.factory<_i130.WatchTop5>(
      () => _i130.WatchTop5(
        gh<_i28.WatchTrackEngagement>(),
        gh<_i961.LoadVoteRanking>(),
        gh<_i879.UserSessionRepository>(),
        gh<_i289.EventVoteRepository>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.factory<_i362.ScheduleVotingBannerCubit>(
      () => _i362.ScheduleVotingBannerCubit(
        gh<_i28.WatchTrackEngagement>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.factory<_i684.AdminCubit>(
      () => _i684.AdminCubit(
        gh<_i233.WatchUserSession>(),
        gh<_i1007.WatchCurrentConference>(),
        gh<_i253.WatchEngagementConfig>(),
        gh<_i961.LoadVoteRanking>(),
        gh<_i77.UpdateTrackEngagementConfig>(),
        gh<_i350.SyncVotableEvents>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.factory<_i807.ScheduleTop5Cubit>(
      () => _i807.ScheduleTop5Cubit(
        gh<_i130.WatchTop5>(),
        gh<_i136.CastEventVote>(),
        gh<_i419.GetUserSession>(),
        gh<_i974.Logger>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
