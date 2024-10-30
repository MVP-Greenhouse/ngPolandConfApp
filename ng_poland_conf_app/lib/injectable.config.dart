// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i18;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'config/app_config.dart' as _i17;
import 'config/raw_config.dart' as _i7;
import 'config/register_module.dart' as _i49;
import 'core/blocks/conferences/conferences_cubit.dart' as _i3;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i11;
import 'features/home/datasources/data/conferences_local_datasource.dart'
    as _i4;
import 'features/home/datasources/data/conferences_remote_datasource.dart'
    as _i35;
import 'features/home/datasources/data/theme_mode_local_datasource.dart'
    as _i12;
import 'features/home/datasources/repositories/conferences_repository.dart'
    as _i37;
import 'features/home/datasources/repositories/theme_mode_repository.dart'
    as _i14;
import 'features/home/domains/repositories/conferences_repository.dart' as _i36;
import 'features/home/domains/repositories/theme_mode_repository.dart' as _i13;
import 'features/home/domains/usecases/get_all_conferences.dart' as _i38;
import 'features/home/domains/usecases/get_theme_mode.dart' as _i19;
import 'features/home/domains/usecases/update_theme_mode.dart' as _i15;
import 'features/info/datasources/data/info_local_datasource.dart' as _i5;
import 'features/info/datasources/data/info_remote_datasource.dart' as _i20;
import 'features/info/datasources/repositories/info_repository.dart' as _i22;
import 'features/info/domains/repositories/info_repository.dart' as _i21;
import 'features/info/domains/usecases/get_all_info_items_for_conference.dart'
    as _i40;
import 'features/info/presentation/cubit/info_cubit.dart' as _i44;
import 'features/nggirls/datasources/data/ngGirls_local_datasource.dart' as _i6;
import 'features/nggirls/datasources/data/ngGirls_remote_datasource.dart'
    as _i23;
import 'features/nggirls/datasources/repositories/ngGirls_repository.dart'
    as _i25;
import 'features/nggirls/domains/repositories/ngGirls_repository.dart' as _i24;
import 'features/nggirls/domains/usecases/get_ngGirls_for_conference.dart'
    as _i42;
import 'features/nggirls/presentation/cubit/ngGirls_cubit.dart' as _i45;
import 'features/schedule/datasources/data/schedule_local_datasource.dart'
    as _i9;
import 'features/schedule/datasources/data/schedule_remote_datasource.dart'
    as _i26;
import 'features/schedule/datasources/repositories/schedule_repository.dart'
    as _i28;
import 'features/schedule/domains/repositories/schedule_repository.dart'
    as _i27;
import 'features/schedule/domains/usecases/get_all_events_for_conference.dart'
    as _i39;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i46;
import 'features/speakers/datasources/data/speakers_local_datasource.dart'
    as _i10;
import 'features/speakers/datasources/data/speakers_remote_datasource.dart'
    as _i29;
import 'features/speakers/datasources/repositories/speakers_repository.dart'
    as _i31;
import 'features/speakers/domains/repositories/speakers_repository.dart'
    as _i30;
import 'features/speakers/domains/usecases/get_all_speakers_for_conference.dart'
    as _i41;
import 'features/speakers/presentation/cubit/speakers_cubit.dart' as _i47;
import 'features/workshops/datasources/data/workshops_local_datasource.dart'
    as _i16;
import 'features/workshops/datasources/data/workshops_remote_datasource.dart'
    as _i32;
import 'features/workshops/datasources/repositories/workshops_repository.dart'
    as _i34;
import 'features/workshops/domains/repositories/workshops_repository.dart'
    as _i33;
import 'features/workshops/domains/usecases/get_workshops_for_conference.dart'
    as _i43;
import 'features/workshops/presentation/cubit/workshop_cubit.dart' as _i48;
import 'routing/routing.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
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
              gh<_i40.GetAllInfoItemsForConference>(),
        ));
    gh.factory<_i45.NgGirlsCubit>(() => _i45.NgGirlsCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getNgGirlsForConference: gh<_i42.GetNgGirlsForConference>(),
        ));
    gh.factory<_i46.ScheduleCubit>(() => _i46.ScheduleCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllEventsForConference: gh<_i39.GetAllEventsForConference>(),
        ));
    gh.factory<_i47.SpeakersCubit>(() => _i47.SpeakersCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllSpeakerGetAllSpeakersForConference:
              gh<_i41.GetAllSpeakersForConference>(),
        ));
    gh.factory<_i48.WorkshopCubit>(() => _i48.WorkshopCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getWorkshopsForConference: gh<_i43.GetWorkshopsForConference>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i49.RegisterModule {}
