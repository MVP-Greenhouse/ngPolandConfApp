// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'config/app_config.dart' as _i297;
import 'config/raw_config.dart' as _i242;
import 'config/register_module.dart' as _i733;
import 'core/blocks/conferences/conferences_cubit.dart' as _i933;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i399;
import 'features/authentication/datasources/repositories/authentication_repository.dart'
    as _i113;
import 'features/authentication/domains/repositories/authentication_repository.dart'
    as _i38;
import 'features/authentication/domains/usecases/sign_in_apple.dart' as _i241;
import 'features/authentication/domains/usecases/sign_in_google.dart' as _i631;
import 'features/authentication/presentation/cubit/authentication_cubit.dart'
    as _i48;
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
import 'features/home/datasources/data/conferences_local_datasource.dart'
    as _i924;
import 'features/home/datasources/data/conferences_remote_datasource.dart'
    as _i800;
import 'features/home/datasources/data/theme_mode_local_datasource.dart'
    as _i397;
import 'features/home/datasources/repositories/conferences_repository.dart'
    as _i912;
import 'features/home/datasources/repositories/theme_mode_repository.dart'
    as _i877;
import 'features/home/domains/repositories/conferences_repository.dart'
    as _i958;
import 'features/home/domains/repositories/theme_mode_repository.dart' as _i905;
import 'features/home/domains/usecases/get_all_conferences.dart' as _i359;
import 'features/home/domains/usecases/get_theme_mode.dart' as _i189;
import 'features/home/domains/usecases/update_theme_mode.dart' as _i184;
import 'features/info/datasources/data/info_local_datasource.dart' as _i1041;
import 'features/info/datasources/data/info_remote_datasource.dart' as _i369;
import 'features/info/datasources/repositories/info_repository.dart' as _i123;
import 'features/info/domains/repositories/info_repository.dart' as _i600;
import 'features/info/domains/usecases/get_all_info_items_for_conference.dart'
    as _i816;
import 'features/info/presentation/cubit/info_cubit.dart' as _i800;
import 'features/nggirls/datasources/data/ngGirls_local_datasource.dart'
    as _i214;
import 'features/nggirls/datasources/data/ngGirls_remote_datasource.dart'
    as _i818;
import 'features/nggirls/datasources/repositories/ngGirls_repository.dart'
    as _i472;
import 'features/nggirls/domains/repositories/ngGirls_repository.dart' as _i33;
import 'features/nggirls/domains/usecases/get_ngGirls_for_conference.dart'
    as _i642;
import 'features/nggirls/presentation/cubit/ngGirls_cubit.dart' as _i685;
import 'features/schedule/datasources/data/schedule_local_datasource.dart'
    as _i878;
import 'features/schedule/datasources/data/schedule_remote_datasource.dart'
    as _i221;
import 'features/schedule/datasources/repositories/schedule_repository.dart'
    as _i732;
import 'features/schedule/domains/repositories/schedule_repository.dart'
    as _i458;
import 'features/schedule/domains/usecases/get_all_events_for_conference.dart'
    as _i797;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i211;
import 'features/speakers/datasources/data/local/speakers_local_datasource.dart'
    as _i71;
import 'features/speakers/datasources/data/remote/speakers_remote_datasource.dart'
    as _i332;
import 'features/speakers/datasources/repositories/speakers_repository.dart'
    as _i927;
import 'features/speakers/domains/repositories/speakers_repository.dart'
    as _i1005;
import 'features/speakers/domains/usecases/get_all_speakers_for_conference.dart'
    as _i350;
import 'features/speakers/presentation/cubit/speakers_cubit.dart' as _i181;
import 'features/workshops/datasources/data/workshops_local_datasource.dart'
    as _i636;
import 'features/workshops/datasources/data/workshops_remote_datasource.dart'
    as _i545;
import 'features/workshops/datasources/repositories/workshops_repository.dart'
    as _i704;
import 'features/workshops/domains/repositories/workshops_repository.dart'
    as _i343;
import 'features/workshops/domains/usecases/get_workshops_for_conference.dart'
    as _i343;
import 'features/workshops/presentation/cubit/workshop_cubit.dart' as _i236;
import 'routing/routing.dart' as _i883;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.singletonAsync<_i242.RawConfig>(
      () => registerModule.config(),
      preResolve: true,
    );
    gh.singleton<_i933.ConferencesCubit>(() => _i933.ConferencesCubit());
    gh.singleton<_i399.ThemeModeCubit>(() => _i399.ThemeModeCubit());
    gh.singleton<_i883.Routing>(() => _i883.Routing());
    gh.singleton<_i234.RateEventLocalDataSource>(
        () => _i234.RateEventLocalDataSourceImpl());
    gh.singleton<_i924.ConferencesLocalDataSource>(
        () => _i924.ConferencesLocalDataSourceImpl());
    gh.singleton<_i1041.InfoLocalDataSource>(
        () => _i1041.InfoLocalDataSourceImpl());
    gh.singleton<_i71.SpeakersLocalDataSource>(
        () => _i71.SpeakersLocalDataSourceImpl());
    gh.singleton<_i38.AuthenticationRepository>(
        () => const _i113.AuthenticationRepositoryImpl());
    gh.singleton<_i429.RateEventRemoteDataSource>(
        () => _i429.RateEventRemoteDataSourceImpl());
    gh.singleton<_i214.NgGirlsLocalDataSource>(
        () => _i214.NgGirlsLocalDataSourceImpl());
    gh.singleton<_i636.WorkshopsLocalDataSource>(
        () => _i636.WorkshopsLocalDataSourceImpl());
    gh.singleton<_i397.ThemeModeLocalDataSource>(
        () => _i397.ThemeModeLocalDataSourceImpl());
    gh.singleton<_i878.ScheduleLocalDataSource>(
        () => _i878.ScheduleLocalDataSourceImpl());
    gh.singleton<_i297.AppConfig>(() => _i297.AppConfig(gh<_i242.RawConfig>()));
    gh.singleton<_i563.RateEventRepository>(() => _i608.RateEventRepositoryImpl(
          gh<_i429.RateEventRemoteDataSource>(),
          gh<_i234.RateEventLocalDataSource>(),
        ));
    gh.factory<_i241.SignInAppleUseCase>(
        () => _i241.SignInAppleUseCase(gh<_i38.AuthenticationRepository>()));
    gh.factory<_i631.SignInGoogleUseCase>(
        () => _i631.SignInGoogleUseCase(gh<_i38.AuthenticationRepository>()));
    gh.singleton<_i361.Dio>(() => registerModule.dio(gh<_i297.AppConfig>()));
    gh.factory<_i48.AuthenticationCubit>(() => _i48.AuthenticationCubit(
          gh<_i241.SignInAppleUseCase>(),
          gh<_i631.SignInGoogleUseCase>(),
        ));
    gh.factory<_i473.GetRateForEvent>(
        () => _i473.GetRateForEvent(gh<_i563.RateEventRepository>()));
    gh.factory<_i589.RateEvent>(
        () => _i589.RateEvent(gh<_i563.RateEventRepository>()));
    gh.factory<_i800.ConferencesRemoteDataSource>(
        () => _i800.ConferencesRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i369.InfoRemoteDataSource>(
        () => _i369.InfoRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i818.NgGirlsRemoteDataSource>(
        () => _i818.NgGirlsRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i221.ScheduleRemoteDataSource>(
        () => _i221.ScheduleRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i332.SpeakersRemoteDataSource>(
        () => _i332.SpeakersRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i545.WorkshopsRemoteDataSource>(
        () => _i545.WorkshopsRemoteDataSource(gh<_i361.Dio>()));
    gh.singleton<_i343.WorkshopsRepository>(() => _i704.WorkshopsRepositoryImpl(
          gh<_i545.WorkshopsRemoteDataSource>(),
          gh<_i636.WorkshopsLocalDataSource>(),
        ));
    gh.singleton<_i905.ThemeModeRepository>(
        () => _i877.ThemeModeImpl(gh<_i397.ThemeModeLocalDataSource>()));
    gh.factory<_i730.EventRatingBloc>(() => _i730.EventRatingBloc(
          gh<_i933.ConferencesCubit>(),
          gh<_i473.GetRateForEvent>(),
          gh<_i589.RateEvent>(),
          gh<String>(),
          gh<String>(),
        ));
    gh.singleton<_i958.ConferencesRepository>(
        () => _i912.ConferencesRepositoryImpl(
              gh<_i800.ConferencesRemoteDataSource>(),
              gh<_i924.ConferencesLocalDataSource>(),
            ));
    gh.factory<_i189.GetThemeMode>(
        () => _i189.GetThemeMode(gh<_i905.ThemeModeRepository>()));
    gh.factory<_i184.UpdateThemeMode>(
        () => _i184.UpdateThemeMode(gh<_i905.ThemeModeRepository>()));
    gh.singleton<_i458.ScheduleRepository>(() => _i732.ScheduleRepositoryImpl(
          gh<_i221.ScheduleRemoteDataSource>(),
          gh<_i878.ScheduleLocalDataSource>(),
        ));
    gh.factory<_i231.GetEvent>(
        () => _i231.GetEvent(gh<_i458.ScheduleRepository>()));
    gh.factory<_i797.GetAllEventsForConference>(
        () => _i797.GetAllEventsForConference(gh<_i458.ScheduleRepository>()));
    gh.singleton<_i600.InfoRepository>(() => _i123.InfoRepositoryImpl(
          gh<_i369.InfoRemoteDataSource>(),
          gh<_i1041.InfoLocalDataSource>(),
        ));
    gh.singleton<_i33.NgGirlsRepository>(() => _i472.NgGirlsImpl(
          gh<_i818.NgGirlsRemoteDataSource>(),
          gh<_i214.NgGirlsLocalDataSource>(),
        ));
    gh.factory<_i343.GetWorkshopsForConference>(
        () => _i343.GetWorkshopsForConference(gh<_i343.WorkshopsRepository>()));
    gh.factory<_i359.GetAllConferences>(
        () => _i359.GetAllConferences(gh<_i958.ConferencesRepository>()));
    gh.singleton<_i1005.SpeakersRepository>(() => _i927.SpeakersRepositoryImpl(
          gh<_i332.SpeakersRemoteDataSource>(),
          gh<_i71.SpeakersLocalDataSource>(),
        ));
    gh.factory<_i224.EventCubit>(() => _i224.EventCubit(
          conferencesCubit: gh<_i933.ConferencesCubit>(),
          getEvent: gh<_i231.GetEvent>(),
        ));
    gh.factory<_i236.WorkshopCubit>(() => _i236.WorkshopCubit(
          conferencesCubit: gh<_i933.ConferencesCubit>(),
          getWorkshopsForConference: gh<_i343.GetWorkshopsForConference>(),
        ));
    gh.factory<_i816.GetAllInfoItemsForConference>(
        () => _i816.GetAllInfoItemsForConference(gh<_i600.InfoRepository>()));
    gh.factory<_i800.InfoCubit>(() => _i800.InfoCubit(
          conferencesCubit: gh<_i933.ConferencesCubit>(),
          getAllSpeakerGetAllInfoItemsForConference:
              gh<_i816.GetAllInfoItemsForConference>(),
        ));
    gh.factory<_i211.ScheduleCubit>(() => _i211.ScheduleCubit(
          conferencesCubit: gh<_i933.ConferencesCubit>(),
          getAllEventsForConference: gh<_i797.GetAllEventsForConference>(),
        ));
    gh.factory<_i350.GetAllSpeakersForConference>(() =>
        _i350.GetAllSpeakersForConference(gh<_i1005.SpeakersRepository>()));
    gh.factory<_i642.GetNgGirlsForConference>(
        () => _i642.GetNgGirlsForConference(gh<_i33.NgGirlsRepository>()));
    gh.factory<_i685.NgGirlsCubit>(() => _i685.NgGirlsCubit(
          conferencesCubit: gh<_i933.ConferencesCubit>(),
          getNgGirlsForConference: gh<_i642.GetNgGirlsForConference>(),
        ));
    gh.factory<_i181.SpeakersCubit>(() => _i181.SpeakersCubit(
          conferencesCubit: gh<_i933.ConferencesCubit>(),
          getAllSpeakerGetAllSpeakersForConference:
              gh<_i350.GetAllSpeakersForConference>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i733.RegisterModule {}
