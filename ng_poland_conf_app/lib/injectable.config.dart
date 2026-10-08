// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_links/app_links.dart' as _i327;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import 'config/app_config.dart' as _i297;
import 'config/raw_config.dart' as _i242;
import 'config/register_module.dart' as _i733;
import 'core/blocks/conferences/conferences_cubit.dart' as _i933;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i399;
import 'features/admin/presentation/cubit/admin_cubit.dart' as _i152;
import 'features/authentication/datasources/data/magic_link_email_local_datasource.dart'
    as _i995;
import 'features/authentication/datasources/data/user_remote_datasource.dart'
    as _i273;
import 'features/authentication/datasources/repositories/authentication_repository.dart'
    as _i113;
import 'features/authentication/datasources/repositories/user_repository.dart'
    as _i137;
import 'features/authentication/domains/repositories/authentication_repository.dart'
    as _i38;
import 'features/authentication/domains/repositories/user_repository.dart'
    as _i476;
import 'features/authentication/domains/usecases/complete_magic_link.dart'
    as _i771;
import 'features/authentication/domains/usecases/ensure_user_profile.dart'
    as _i834;
import 'features/authentication/domains/usecases/send_magic_link.dart' as _i369;
import 'features/authentication/domains/usecases/sign_in_apple.dart' as _i241;
import 'features/authentication/domains/usecases/sign_in_google.dart' as _i631;
import 'features/authentication/presentation/cubit/authentication_cubit.dart'
    as _i48;
import 'features/authentication/presentation/cubit/user_session_cubit.dart'
    as _i793;
import 'features/authentication/presentation/services/magic_link_deep_link_listener.dart'
    as _i419;
import 'features/edition/datasources/data/edition_hive_cache.dart' as _i526;
import 'features/edition/datasources/data/ng_poland_api.dart' as _i5;
import 'features/edition/datasources/repositories/edition_repository.dart'
    as _i417;
import 'features/edition/domains/repositories/edition_store.dart' as _i105;
import 'features/edition/presentation/edition_cubit.dart' as _i1023;
import 'features/engagement/datasources/data/engagement_config_remote_datasource.dart'
    as _i1016;
import 'features/engagement/datasources/data/event_vote_remote_datasource.dart'
    as _i785;
import 'features/engagement/datasources/repositories/engagement_config_repository.dart'
    as _i408;
import 'features/engagement/datasources/repositories/event_vote_repository.dart'
    as _i838;
import 'features/engagement/domains/repositories/engagement_config_repository.dart'
    as _i419;
import 'features/engagement/domains/repositories/event_vote_repository.dart'
    as _i670;
import 'features/event/datasources/data/local/rate_event_local_datasource.dart'
    as _i234;
import 'features/event/datasources/data/remote/rate_event_remote_datasource.dart'
    as _i429;
import 'features/event/datasources/repositories/rate_event_repository.dart'
    as _i608;
import 'features/event/domains/repositories/rate_event_repository.dart'
    as _i563;
import 'features/event/domains/usecases/get_event.dart' as _i231;
import 'features/event/domains/usecases/get_rate_for_event.dart' as _i473;
import 'features/event/domains/usecases/rate_event.dart' as _i589;
import 'features/event/presentation/bloc/event_rating_bloc.dart' as _i730;
import 'features/event/presentation/cubit/event_cubit.dart' as _i224;
import 'features/event/presentation/cubit/event_vote_cubit.dart' as _i217;
import 'features/home/datasources/data/theme_mode_local_datasource.dart'
    as _i397;
import 'features/home/datasources/repositories/theme_mode_repository.dart'
    as _i877;
import 'features/home/domains/repositories/theme_mode_repository.dart' as _i905;
import 'features/home/domains/usecases/get_theme_mode.dart' as _i189;
import 'features/home/domains/usecases/update_theme_mode.dart' as _i184;
import 'features/schedule/datasources/repositories/schedule_repository.dart'
    as _i732;
import 'features/schedule/domains/repositories/schedule_repository.dart'
    as _i458;
import 'features/schedule/domains/usecases/get_all_events_for_conference.dart'
    as _i797;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i211;
import 'features/schedule/presentation/cubit/schedule_top5_cubit.dart' as _i960;
import 'features/schedule/presentation/cubit/schedule_voting_banner_cubit.dart'
    as _i1039;
import 'features/speakers/presentation/cubit/speakers_cubit.dart' as _i181;
import 'routing/routing.dart' as _i883;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i273.UserRemoteDataSource>(() => _i273.UserRemoteDataSource());
    gh.factory<_i1016.EngagementConfigRemoteDataSource>(
      () => _i1016.EngagementConfigRemoteDataSource(),
    );
    gh.factory<_i785.EventVoteRemoteDataSource>(
      () => _i785.EventVoteRemoteDataSource(),
    );
    await gh.singletonAsync<_i242.RawConfig>(
      () => registerModule.config(),
      preResolve: true,
    );
    gh.singleton<_i933.ConferencesCubit>(() => _i933.ConferencesCubit());
    gh.singleton<_i399.ThemeModeCubit>(() => _i399.ThemeModeCubit());
    gh.singleton<_i883.Routing>(() => _i883.Routing());
    gh.lazySingleton<_i327.AppLinks>(() => registerModule.appLinks());
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth());
    gh.lazySingleton<_i974.Logger>(() => registerModule.logger());
    gh.singleton<_i234.RateEventLocalDataSource>(
      () => _i234.RateEventLocalDataSourceImpl(),
    );
    gh.singleton<_i995.MagicLinkEmailLocalDataSource>(
      () => _i995.MagicLinkEmailLocalDataSourceImpl(),
    );
    gh.singleton<_i670.EventVoteRepository>(
      () =>
          _i838.EventVoteRepositoryImpl(gh<_i785.EventVoteRemoteDataSource>()),
    );
    gh.singleton<_i297.AppConfig>(() => _i297.AppConfig(gh<_i242.RawConfig>()));
    gh.singleton<_i429.RateEventRemoteDataSource>(
      () => _i429.RateEventRemoteDataSourceImpl(),
    );
    gh.singleton<_i397.ThemeModeLocalDataSource>(
      () => _i397.ThemeModeLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i105.EditionCache>(() => _i526.EditionHiveCache());
    gh.singleton<_i476.UserRepository>(
      () => _i137.UserRepositoryImpl(gh<_i273.UserRemoteDataSource>()),
    );
    gh.factory<_i834.EnsureUserProfile>(
      () => _i834.EnsureUserProfile(gh<_i476.UserRepository>()),
    );
    gh.singleton<_i38.AuthenticationRepository>(
      () => _i113.AuthenticationRepositoryImpl(
        gh<_i995.MagicLinkEmailLocalDataSource>(),
      ),
    );
    gh.singleton<_i563.RateEventRepository>(
      () => _i608.RateEventRepositoryImpl(
        gh<_i429.RateEventRemoteDataSource>(),
        gh<_i234.RateEventLocalDataSource>(),
      ),
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio(gh<_i297.AppConfig>()));
    gh.singleton<_i419.EngagementConfigRepository>(
      () => _i408.EngagementConfigRepositoryImpl(
        gh<_i1016.EngagementConfigRemoteDataSource>(),
      ),
    );
    gh.singleton<_i905.ThemeModeRepository>(
      () => _i877.ThemeModeImpl(gh<_i397.ThemeModeLocalDataSource>()),
    );
    gh.singleton<_i793.UserSessionCubit>(
      () => _i793.UserSessionCubit(
        gh<_i834.EnsureUserProfile>(),
        gh<_i476.UserRepository>(),
      ),
    );
    gh.factory<_i771.CompleteMagicLinkUseCase>(
      () => _i771.CompleteMagicLinkUseCase(gh<_i38.AuthenticationRepository>()),
    );
    gh.factory<_i369.SendMagicLinkUseCase>(
      () => _i369.SendMagicLinkUseCase(gh<_i38.AuthenticationRepository>()),
    );
    gh.factory<_i241.SignInAppleUseCase>(
      () => _i241.SignInAppleUseCase(gh<_i38.AuthenticationRepository>()),
    );
    gh.factory<_i631.SignInGoogleUseCase>(
      () => _i631.SignInGoogleUseCase(gh<_i38.AuthenticationRepository>()),
    );
    gh.factory<_i473.GetRateForEvent>(
      () => _i473.GetRateForEvent(gh<_i563.RateEventRepository>()),
    );
    gh.factory<_i589.RateEvent>(
      () => _i589.RateEvent(gh<_i563.RateEventRepository>()),
    );
    gh.lazySingleton<_i105.EditionRemote>(
      () => _i5.NgPolandApi(gh<_i361.Dio>()),
    );
    gh.factory<_i189.GetThemeMode>(
      () => _i189.GetThemeMode(gh<_i905.ThemeModeRepository>()),
    );
    gh.factory<_i184.UpdateThemeMode>(
      () => _i184.UpdateThemeMode(gh<_i905.ThemeModeRepository>()),
    );
    gh.factory<_i730.EventRatingBloc>(
      () => _i730.EventRatingBloc(
        gh<_i933.ConferencesCubit>(),
        gh<_i473.GetRateForEvent>(),
        gh<_i589.RateEvent>(),
        gh<String>(),
        gh<String>(),
      ),
    );
    gh.factory<_i48.AuthenticationCubit>(
      () => _i48.AuthenticationCubit(
        gh<_i241.SignInAppleUseCase>(),
        gh<_i631.SignInGoogleUseCase>(),
        gh<_i369.SendMagicLinkUseCase>(),
        gh<_i771.CompleteMagicLinkUseCase>(),
        gh<_i834.EnsureUserProfile>(),
      ),
    );
    gh.lazySingleton<_i417.EditionRepository>(
      () => _i417.EditionRepository(
        gh<_i105.EditionRemote>(),
        gh<_i105.EditionCache>(),
      ),
    );
    gh.factory<_i1039.ScheduleVotingBannerCubit>(
      () => _i1039.ScheduleVotingBannerCubit(
        gh<_i419.EngagementConfigRepository>(),
        gh<_i933.ConferencesCubit>(),
      ),
    );
    gh.factoryParam<_i217.EventVoteCubit, String, String>(
      (eventId, trackName) => _i217.EventVoteCubit(
        gh<_i670.EventVoteRepository>(),
        gh<_i419.EngagementConfigRepository>(),
        gh<_i793.UserSessionCubit>(),
        gh<_i933.ConferencesCubit>(),
        eventId,
        trackName,
      ),
    );
    gh.lazySingleton<_i419.MagicLinkDeepLinkListener>(
      () => _i419.MagicLinkDeepLinkListener(
        gh<_i771.CompleteMagicLinkUseCase>(),
        gh<_i834.EnsureUserProfile>(),
        gh<_i327.AppLinks>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i458.ScheduleRepository>(
      () => _i732.ScheduleRepositoryImpl(gh<_i417.EditionRepository>()),
    );
    gh.factory<_i231.GetEvent>(
      () => _i231.GetEvent(gh<_i458.ScheduleRepository>()),
    );
    gh.factory<_i797.GetAllEventsForConference>(
      () => _i797.GetAllEventsForConference(gh<_i458.ScheduleRepository>()),
    );
    gh.singleton<_i1023.EditionCubit>(
      () => _i1023.EditionCubit(gh<_i417.EditionRepository>()),
    );
    gh.factory<_i211.ScheduleCubit>(
      () => _i211.ScheduleCubit(
        conferencesCubit: gh<_i933.ConferencesCubit>(),
        getAllEventsForConference: gh<_i797.GetAllEventsForConference>(),
      ),
    );
    gh.factory<_i960.ScheduleTop5Cubit>(
      () => _i960.ScheduleTop5Cubit(
        gh<_i419.EngagementConfigRepository>(),
        gh<_i670.EventVoteRepository>(),
        gh<_i933.ConferencesCubit>(),
        gh<_i793.UserSessionCubit>(),
        gh<_i797.GetAllEventsForConference>(),
      ),
    );
    gh.factory<_i224.EventCubit>(
      () => _i224.EventCubit(
        conferencesCubit: gh<_i933.ConferencesCubit>(),
        getEvent: gh<_i231.GetEvent>(),
      ),
    );
    gh.factory<_i152.AdminCubit>(
      () => _i152.AdminCubit(
        gh<_i419.EngagementConfigRepository>(),
        gh<_i670.EventVoteRepository>(),
        gh<_i797.GetAllEventsForConference>(),
        gh<_i793.UserSessionCubit>(),
        gh<_i933.ConferencesCubit>(),
      ),
    );
    gh.factory<_i181.SpeakersCubit>(
      () => _i181.SpeakersCubit(gh<_i1023.EditionCubit>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i733.RegisterModule {}
