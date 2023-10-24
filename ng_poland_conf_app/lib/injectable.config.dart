// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i18;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'config/app_config.dart' as _i17;
import 'config/raw_config.dart' as _i6;
import 'config/register_module.dart' as _i54;
import 'core/blocks/conferences/conferences_cubit.dart' as _i3;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i12;
import 'features/home/datasources/data/conferences_local_datasource.dart'
    as _i4;
import 'features/home/datasources/data/conferences_remote_datasource.dart'
    as _i38;
import 'features/home/datasources/data/theme_mode_local_datasource.dart'
    as _i13;
import 'features/home/datasources/repositories/conferences_repository.dart'
    as _i40;
import 'features/home/datasources/repositories/theme_mode_repository.dart'
    as _i15;
import 'features/home/domains/repositories/conferences_repository.dart' as _i39;
import 'features/home/domains/repositories/theme_mode_repository.dart' as _i14;
import 'features/home/domains/usecases/get_all_conferences.dart' as _i41;
import 'features/home/domains/usecases/get_theme_mode.dart' as _i20;
import 'features/home/domains/usecases/query_conferences.dart' as _i49;
import 'features/home/domains/usecases/save_conferences.dart' as _i50;
import 'features/home/domains/usecases/update_theme_mode.dart' as _i16;
import 'features/info/datasources/data/info_local_datasource.dart' as _i5;
import 'features/info/datasources/data/info_remote_datasource.dart' as _i21;
import 'features/info/datasources/repositories/info_repository.dart' as _i23;
import 'features/info/domains/repositories/info_repository.dart' as _i22;
import 'features/info/domains/usecases/get_all_info_items_for_conference.dart'
    as _i43;
import 'features/info/domains/usecases/query_info_items.dart' as _i27;
import 'features/info/domains/usecases/save_info_items.dart' as _i28;
import 'features/info/presentation/cubit/info_cubit.dart' as _i47;
import 'features/nggirls/datasources/data/ngGirls_remote_datasource.dart'
    as _i24;
import 'features/nggirls/datasources/repositories/ngGirls_repository.dart'
    as _i26;
import 'features/nggirls/domains/repositories/ngGirls_repository.dart' as _i25;
import 'features/nggirls/domains/usecases/get_ngGirls_for_conference.dart'
    as _i45;
import 'features/nggirls/presentation/cubit/ngGirls_cubit.dart' as _i48;
import 'features/schedule/datasources/data/schedule_remote_datasource.dart'
    as _i29;
import 'features/schedule/datasources/repositories/schedule_repository.dart'
    as _i31;
import 'features/schedule/domains/repositories/schedule_repository.dart'
    as _i30;
import 'features/schedule/domains/usecases/get_all_events_for_conference.dart'
    as _i42;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i51;
import 'features/settings/datasources/data/repositiories/settings_repository.dart'
    as _i11;
import 'features/settings/datasources/data/settings_local_datasource.dart'
    as _i9;
import 'features/settings/domains/repositories/settings_repository.dart'
    as _i10;
import 'features/settings/domains/usecases/get_settings.dart' as _i19;
import 'features/settings/presentation/cubit/settings_cubit.dart' as _i8;
import 'features/speakers/datasources/data/speakers_remote_datasource.dart'
    as _i32;
import 'features/speakers/datasources/repositories/speakers_repository.dart'
    as _i34;
import 'features/speakers/domains/repositories/speakers_repository.dart'
    as _i33;
import 'features/speakers/domains/usecases/get_all_speakers_for_conference.dart'
    as _i44;
import 'features/speakers/presentation/cubit/speakers_cubit.dart' as _i52;
import 'features/workshops/datasources/data/workshops_remote_datasource.dart'
    as _i35;
import 'features/workshops/datasources/repositories/workshops_repository.dart'
    as _i37;
import 'features/workshops/domains/repositories/workshops_repository.dart'
    as _i36;
import 'features/workshops/domains/usecases/get_workshops_for_conference.dart'
    as _i46;
import 'features/workshops/presentation/cubit/workshop_cubit.dart' as _i53;
import 'routing/routing.dart' as _i7;

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
    gh.singleton<_i3.ConferencesCubit>(_i3.ConferencesCubit());
    gh.singleton<_i4.ConferencesLocalDataSource>(
        _i4.ConferencesLocalDataSourceImpl());
    gh.singleton<_i5.InfoLocalDataSource>(_i5.InfoLocalDataSourceImpl());
    await gh.singletonAsync<_i6.RawConfig>(
      () => registerModule.config(),
      preResolve: true,
    );
    gh.singleton<_i7.Routing>(_i7.Routing());
    gh.singleton<_i8.SettingsCubit>(_i8.SettingsCubit());
    gh.singleton<_i9.SettingsLocalDataSource>(
        _i9.SettingsLocalDataSourceImpl());
    gh.singleton<_i10.SettingsRepository>(
        _i11.SettingsImpl(gh<_i9.SettingsLocalDataSource>()));
    gh.singleton<_i12.ThemeModeCubit>(_i12.ThemeModeCubit());
    gh.singleton<_i13.ThemeModeLocalDataSource>(
        _i13.ThemeModeLocalDataSourceImpl());
    gh.singleton<_i14.ThemeModeRepository>(
        _i15.ThemeModeImpl(gh<_i13.ThemeModeLocalDataSource>()));
    gh.factory<_i16.UpdateThemeMode>(
        () => _i16.UpdateThemeMode(gh<_i14.ThemeModeRepository>()));
    gh.singleton<_i17.AppConfig>(_i17.AppConfig(gh<_i6.RawConfig>()));
    gh.singleton<_i18.Dio>(registerModule.dio(gh<_i17.AppConfig>()));
    gh.factory<_i19.GetSettings>(
        () => _i19.GetSettings(gh<_i10.SettingsRepository>()));
    gh.factory<_i20.GetThemeMode>(
        () => _i20.GetThemeMode(gh<_i14.ThemeModeRepository>()));
    gh.factory<_i21.InfoRemoteDataSource>(
        () => _i21.InfoRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i22.InfoRepository>(_i23.InfoRepositoryImpl(
      gh<_i21.InfoRemoteDataSource>(),
      gh<_i5.InfoLocalDataSource>(),
    ));
    gh.factory<_i24.NgGirlsRemoteDataSource>(
        () => _i24.NgGirlsRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i25.NgGirlsRepository>(
        _i26.NgGirlsImpl(gh<_i24.NgGirlsRemoteDataSource>()));
    gh.factory<_i27.QueryInfoItems>(
        () => _i27.QueryInfoItems(gh<_i22.InfoRepository>()));
    gh.factory<_i28.SaveInfoItems>(
        () => _i28.SaveInfoItems(gh<_i22.InfoRepository>()));
    gh.factory<_i29.ScheduleRemoteDataSource>(
        () => _i29.ScheduleRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i30.ScheduleRepository>(
        _i31.ScheduleRepositoryImpl(gh<_i29.ScheduleRemoteDataSource>()));
    gh.factory<_i32.SpeakersRemoteDataSource>(
        () => _i32.SpeakersRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i33.SpeakersRepository>(
        _i34.SpeakersRepositoryImpl(gh<_i32.SpeakersRemoteDataSource>()));
    gh.factory<_i35.WorkshopsRemoteDataSource>(
        () => _i35.WorkshopsRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i36.WorkshopsRepository>(
        _i37.WorkshopsRepositoryImpl(gh<_i35.WorkshopsRemoteDataSource>()));
    gh.factory<_i38.ConferencesRemoteDataSource>(
        () => _i38.ConferencesRemoteDataSource(gh<_i18.Dio>()));
    gh.singleton<_i39.ConferencesRepository>(_i40.ConferencesRepositoryImpl(
      gh<_i38.ConferencesRemoteDataSource>(),
      gh<_i4.ConferencesLocalDataSource>(),
    ));
    gh.factory<_i41.GetAllConferences>(
        () => _i41.GetAllConferences(gh<_i39.ConferencesRepository>()));
    gh.factory<_i42.GetAllEventsForConference>(
        () => _i42.GetAllEventsForConference(gh<_i30.ScheduleRepository>()));
    gh.factory<_i43.GetAllInfoItemsForConference>(
        () => _i43.GetAllInfoItemsForConference(gh<_i22.InfoRepository>()));
    gh.factory<_i44.GetAllSpeakersForConference>(
        () => _i44.GetAllSpeakersForConference(gh<_i33.SpeakersRepository>()));
    gh.factory<_i45.GetNgGirlsForConference>(
        () => _i45.GetNgGirlsForConference(gh<_i25.NgGirlsRepository>()));
    gh.factory<_i46.GetWorkshopsForConference>(
        () => _i46.GetWorkshopsForConference(gh<_i36.WorkshopsRepository>()));
    gh.factory<_i47.InfoCubit>(() => _i47.InfoCubit(
          gh<_i27.QueryInfoItems>(),
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllSpeakerGetAllInfoItemsForConference:
              gh<_i43.GetAllInfoItemsForConference>(),
        ));
    gh.factory<_i48.NgGirlsCubit>(() => _i48.NgGirlsCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getNgGirlsForConference: gh<_i45.GetNgGirlsForConference>(),
        ));
    gh.factory<_i49.QueryConferences>(
        () => _i49.QueryConferences(gh<_i39.ConferencesRepository>()));
    gh.factory<_i50.SaveConferences>(
        () => _i50.SaveConferences(gh<_i39.ConferencesRepository>()));
    gh.factory<_i51.ScheduleCubit>(() => _i51.ScheduleCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllEventsForConference: gh<_i42.GetAllEventsForConference>(),
        ));
    gh.factory<_i52.SpeakersCubit>(() => _i52.SpeakersCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllSpeakerGetAllSpeakersForConference:
              gh<_i44.GetAllSpeakersForConference>(),
        ));
    gh.factory<_i53.WorkshopCubit>(() => _i53.WorkshopCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getWorkshopsForConference: gh<_i46.GetWorkshopsForConference>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i54.RegisterModule {}
