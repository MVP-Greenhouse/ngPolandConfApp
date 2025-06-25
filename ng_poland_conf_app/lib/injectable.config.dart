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
    gh.singleton<_i3.ConferencesCubit>(() => _i3.ConferencesCubit());
    gh.singleton<_i4.ConferencesLocalDataSource>(
        () => _i4.ConferencesLocalDataSourceImpl());
    gh.singleton<_i5.InfoLocalDataSource>(() => _i5.InfoLocalDataSourceImpl());
    gh.singleton<_i6.NgGirlsLocalDataSource>(
        () => _i6.NgGirlsLocalDataSourceImpl());
    await gh.singletonAsync<_i7.RawConfig>(
      () => registerModule.config(),
      preResolve: true,
    );
    gh.singleton<_i8.Routing>(() => _i8.Routing());
    gh.singleton<_i9.ScheduleLocalDataSource>(
        () => _i9.ScheduleLocalDataSourceImpl());
    gh.singleton<_i10.SpeakersLocalDataSource>(
        () => _i10.SpeakersLocalDataSourceImpl());
    gh.singleton<_i11.ThemeModeCubit>(() => _i11.ThemeModeCubit());
    gh.singleton<_i12.ThemeModeLocalDataSource>(
        () => _i12.ThemeModeLocalDataSourceImpl());
    gh.singleton<_i13.ThemeModeRepository>(
        () => _i14.ThemeModeImpl(gh<_i12.ThemeModeLocalDataSource>()));
    gh.factory<_i15.UpdateThemeMode>(
        () => _i15.UpdateThemeMode(gh<_i13.ThemeModeRepository>()));
    gh.singleton<_i16.WorkshopsLocalDataSource>(
        () => _i16.WorkshopsLocalDataSourceImpl());
    gh.singleton<_i17.AppConfig>(() => _i17.AppConfig(gh<_i7.RawConfig>()));
    gh.singleton<_i18.Dio>(() => registerModule.dio(gh<_i17.AppConfig>()));
    gh.factory<_i19.GetThemeMode>(
        () => _i19.GetThemeMode(gh<_i13.ThemeModeRepository>()));
    gh.factory<_i20.InfoRemoteDataSource>(
        () => _i20.InfoRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i21.InfoRepository>(() => _i22.InfoRepositoryImpl(
          gh<_i20.InfoRemoteDataSource>(),
          gh<_i5.InfoLocalDataSource>(),
        ));
    gh.factory<_i23.NgGirlsRemoteDataSource>(
        () => _i23.NgGirlsRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i24.NgGirlsRepository>(() => _i25.NgGirlsImpl(
          gh<_i23.NgGirlsRemoteDataSource>(),
          gh<_i6.NgGirlsLocalDataSource>(),
        ));
    gh.factory<_i26.ScheduleRemoteDataSource>(
        () => _i26.ScheduleRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i27.ScheduleRepository>(() => _i28.ScheduleRepositoryImpl(
          gh<_i26.ScheduleRemoteDataSource>(),
          gh<_i9.ScheduleLocalDataSource>(),
        ));
    gh.factory<_i29.SpeakersRemoteDataSource>(
        () => _i29.SpeakersRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i30.SpeakersRepository>(() => _i31.SpeakersRepositoryImpl(
          gh<_i29.SpeakersRemoteDataSource>(),
          gh<_i10.SpeakersLocalDataSource>(),
        ));
    gh.factory<_i32.WorkshopsRemoteDataSource>(
        () => _i32.WorkshopsRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i33.WorkshopsRepository>(() => _i34.WorkshopsRepositoryImpl(
          gh<_i32.WorkshopsRemoteDataSource>(),
          gh<_i16.WorkshopsLocalDataSource>(),
        ));
    gh.factory<_i35.ConferencesRemoteDataSource>(
        () => _i35.ConferencesRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i36.ConferencesRepository>(
        () => _i37.ConferencesRepositoryImpl(
              gh<_i35.ConferencesRemoteDataSource>(),
              gh<_i4.ConferencesLocalDataSource>(),
            ));
    gh.factory<_i38.GetAllConferences>(
        () => _i38.GetAllConferences(gh<_i36.ConferencesRepository>()));
    gh.factory<_i39.GetAllEventsForConference>(
        () => _i39.GetAllEventsForConference(gh<_i27.ScheduleRepository>()));
    gh.factory<_i40.GetAllInfoItemsForConference>(
        () => _i40.GetAllInfoItemsForConference(gh<_i21.InfoRepository>()));
    gh.factory<_i41.GetAllSpeakersForConference>(
        () => _i41.GetAllSpeakersForConference(gh<_i30.SpeakersRepository>()));
    gh.factory<_i42.GetNgGirlsForConference>(
        () => _i42.GetNgGirlsForConference(gh<_i24.NgGirlsRepository>()));
    gh.factory<_i43.GetWorkshopsForConference>(
        () => _i43.GetWorkshopsForConference(gh<_i33.WorkshopsRepository>()));
    gh.factory<_i44.InfoCubit>(() => _i44.InfoCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
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
