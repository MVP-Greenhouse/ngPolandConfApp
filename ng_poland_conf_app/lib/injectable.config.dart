// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i19;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'config/app_config.dart' as _i18;
import 'config/raw_config.dart' as _i7;
import 'config/register_module.dart' as _i57;
import 'core/blocks/conferences/conferences_cubit.dart' as _i3;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i13;
import 'features/home/datasources/data/conferences_local_datasource.dart'
    as _i4;
import 'features/home/datasources/data/conferences_remote_datasource.dart'
    as _i41;
import 'features/home/datasources/data/theme_mode_local_datasource.dart'
    as _i14;
import 'features/home/datasources/repositories/conferences_repository.dart'
    as _i43;
import 'features/home/datasources/repositories/theme_mode_repository.dart'
    as _i16;
import 'features/home/domains/repositories/conferences_repository.dart' as _i42;
import 'features/home/domains/repositories/theme_mode_repository.dart' as _i15;
import 'features/home/domains/usecases/get_all_conferences.dart' as _i44;
import 'features/home/domains/usecases/get_theme_mode.dart' as _i21;
import 'features/home/domains/usecases/query_conferences.dart' as _i52;
import 'features/home/domains/usecases/save_conferences.dart' as _i53;
import 'features/home/domains/usecases/update_theme_mode.dart' as _i17;
import 'features/info/datasources/data/info_local_datasource.dart' as _i5;
import 'features/info/datasources/data/info_remote_datasource.dart' as _i22;
import 'features/info/datasources/repositories/info_repository.dart' as _i24;
import 'features/info/domains/repositories/info_repository.dart' as _i23;
import 'features/info/domains/usecases/get_all_info_items_for_conference.dart'
    as _i46;
import 'features/info/domains/usecases/query_info_items.dart' as _i28;
import 'features/info/domains/usecases/save_info_items.dart' as _i30;
import 'features/info/presentation/cubit/info_cubit.dart' as _i50;
import 'features/nggirls/datasources/data/ngGirls_local_datasource.dart' as _i6;
import 'features/nggirls/datasources/data/ngGirls_remote_datasource.dart'
    as _i25;
import 'features/nggirls/datasources/repositories/ngGirls_repository.dart'
    as _i27;
import 'features/nggirls/domains/repositories/ngGirls_repository.dart' as _i26;
import 'features/nggirls/domains/usecases/get_ngGirls_for_conference.dart'
    as _i48;
import 'features/nggirls/domains/usecases/query_ngGirls.dart' as _i29;
import 'features/nggirls/domains/usecases/save_ngGirls.dart' as _i31;
import 'features/nggirls/presentation/cubit/ngGirls_cubit.dart' as _i51;
import 'features/schedule/datasources/data/schedule_remote_datasource.dart'
    as _i32;
import 'features/schedule/datasources/repositories/schedule_repository.dart'
    as _i34;
import 'features/schedule/domains/repositories/schedule_repository.dart'
    as _i33;
import 'features/schedule/domains/usecases/get_all_events_for_conference.dart'
    as _i45;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i54;
import 'features/settings/datasources/data/repositiories/settings_repository.dart'
    as _i12;
import 'features/settings/datasources/data/settings_local_datasource.dart'
    as _i10;
import 'features/settings/domains/repositories/settings_repository.dart'
    as _i11;
import 'features/settings/domains/usecases/get_settings.dart' as _i20;
import 'features/settings/presentation/cubit/settings_cubit.dart' as _i9;
import 'features/speakers/datasources/data/speakers_remote_datasource.dart'
    as _i35;
import 'features/speakers/datasources/repositories/speakers_repository.dart'
    as _i37;
import 'features/speakers/domains/repositories/speakers_repository.dart'
    as _i36;
import 'features/speakers/domains/usecases/get_all_speakers_for_conference.dart'
    as _i47;
import 'features/speakers/presentation/cubit/speakers_cubit.dart' as _i55;
import 'features/workshops/datasources/data/workshops_remote_datasource.dart'
    as _i38;
import 'features/workshops/datasources/repositories/workshops_repository.dart'
    as _i40;
import 'features/workshops/domains/repositories/workshops_repository.dart'
    as _i39;
import 'features/workshops/domains/usecases/get_workshops_for_conference.dart'
    as _i49;
import 'features/workshops/presentation/cubit/workshop_cubit.dart' as _i56;
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
    gh.singleton<_i3.ConferencesCubit>(_i3.ConferencesCubit());
    gh.singleton<_i4.ConferencesLocalDataSource>(
        _i4.ConferencesLocalDataSourceImpl());
    gh.singleton<_i5.InfoLocalDataSource>(_i5.InfoLocalDataSourceImpl());
    gh.singleton<_i6.NgGirlsLocalDataSource>(_i6.NgGirlsLocalDataSourceImpl());
    await gh.singletonAsync<_i7.RawConfig>(
      () => registerModule.config(),
      preResolve: true,
    );
    gh.singleton<_i8.Routing>(_i8.Routing());
    gh.singleton<_i9.SettingsCubit>(_i9.SettingsCubit());
    gh.singleton<_i10.SettingsLocalDataSource>(
        _i10.SettingsLocalDataSourceImpl());
    gh.singleton<_i11.SettingsRepository>(
        _i12.SettingsImpl(gh<_i10.SettingsLocalDataSource>()));
    gh.singleton<_i13.ThemeModeCubit>(_i13.ThemeModeCubit());
    gh.singleton<_i14.ThemeModeLocalDataSource>(
        _i14.ThemeModeLocalDataSourceImpl());
    gh.singleton<_i15.ThemeModeRepository>(
        _i16.ThemeModeImpl(gh<_i14.ThemeModeLocalDataSource>()));
    gh.factory<_i17.UpdateThemeMode>(
        () => _i17.UpdateThemeMode(gh<_i15.ThemeModeRepository>()));
    gh.singleton<_i18.AppConfig>(_i18.AppConfig(gh<_i7.RawConfig>()));
    gh.singleton<_i19.Dio>(registerModule.dio(gh<_i18.AppConfig>()));
    gh.factory<_i20.GetSettings>(
        () => _i20.GetSettings(gh<_i11.SettingsRepository>()));
    gh.factory<_i21.GetThemeMode>(
        () => _i21.GetThemeMode(gh<_i15.ThemeModeRepository>()));
    gh.factory<_i22.InfoRemoteDataSource>(
        () => _i22.InfoRemoteDataSource(gh<_i19.Dio>()));
    gh.singleton<_i23.InfoRepository>(_i24.InfoRepositoryImpl(
      gh<_i22.InfoRemoteDataSource>(),
      gh<_i5.InfoLocalDataSource>(),
    ));
    gh.factory<_i25.NgGirlsRemoteDataSource>(
        () => _i25.NgGirlsRemoteDataSource(gh<_i19.Dio>()));
    gh.singleton<_i26.NgGirlsRepository>(_i27.NgGirlsImpl(
      gh<_i25.NgGirlsRemoteDataSource>(),
      gh<_i6.NgGirlsLocalDataSource>(),
    ));
    gh.factory<_i28.QueryInfoItems>(
        () => _i28.QueryInfoItems(gh<_i23.InfoRepository>()));
    gh.factory<_i29.QueryNgGirls>(
        () => _i29.QueryNgGirls(gh<_i26.NgGirlsRepository>()));
    gh.factory<_i30.SaveInfoItems>(
        () => _i30.SaveInfoItems(gh<_i23.InfoRepository>()));
    gh.factory<_i31.SaveNgGirls>(
        () => _i31.SaveNgGirls(gh<_i26.NgGirlsRepository>()));
    gh.factory<_i32.ScheduleRemoteDataSource>(
        () => _i32.ScheduleRemoteDataSource(gh<_i19.Dio>()));
    gh.singleton<_i33.ScheduleRepository>(
        _i34.ScheduleRepositoryImpl(gh<_i32.ScheduleRemoteDataSource>()));
    gh.factory<_i35.SpeakersRemoteDataSource>(
        () => _i35.SpeakersRemoteDataSource(gh<_i19.Dio>()));
    gh.singleton<_i36.SpeakersRepository>(
        _i37.SpeakersRepositoryImpl(gh<_i35.SpeakersRemoteDataSource>()));
    gh.factory<_i38.WorkshopsRemoteDataSource>(
        () => _i38.WorkshopsRemoteDataSource(gh<_i19.Dio>()));
    gh.singleton<_i39.WorkshopsRepository>(
        _i40.WorkshopsRepositoryImpl(gh<_i38.WorkshopsRemoteDataSource>()));
    gh.factory<_i41.ConferencesRemoteDataSource>(
        () => _i41.ConferencesRemoteDataSource(gh<_i19.Dio>()));
    gh.singleton<_i42.ConferencesRepository>(_i43.ConferencesRepositoryImpl(
      gh<_i41.ConferencesRemoteDataSource>(),
      gh<_i4.ConferencesLocalDataSource>(),
    ));
    gh.factory<_i44.GetAllConferences>(
        () => _i44.GetAllConferences(gh<_i42.ConferencesRepository>()));
    gh.factory<_i45.GetAllEventsForConference>(
        () => _i45.GetAllEventsForConference(gh<_i33.ScheduleRepository>()));
    gh.factory<_i46.GetAllInfoItemsForConference>(
        () => _i46.GetAllInfoItemsForConference(gh<_i23.InfoRepository>()));
    gh.factory<_i47.GetAllSpeakersForConference>(
        () => _i47.GetAllSpeakersForConference(gh<_i36.SpeakersRepository>()));
    gh.factory<_i48.GetNgGirlsForConference>(
        () => _i48.GetNgGirlsForConference(gh<_i26.NgGirlsRepository>()));
    gh.factory<_i49.GetWorkshopsForConference>(
        () => _i49.GetWorkshopsForConference(gh<_i39.WorkshopsRepository>()));
    gh.factory<_i50.InfoCubit>(() => _i50.InfoCubit(
          gh<_i28.QueryInfoItems>(),
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllInfoItems: gh<_i46.GetAllInfoItemsForConference>(),
        ));
    gh.factory<_i51.NgGirlsCubit>(() => _i51.NgGirlsCubit(
          gh<_i29.QueryNgGirls>(),
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getNgGirlsForConference: gh<_i48.GetNgGirlsForConference>(),
        ));
    gh.factory<_i52.QueryConferences>(
        () => _i52.QueryConferences(gh<_i42.ConferencesRepository>()));
    gh.factory<_i53.SaveConferences>(
        () => _i53.SaveConferences(gh<_i42.ConferencesRepository>()));
    gh.factory<_i54.ScheduleCubit>(() => _i54.ScheduleCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllEventsForConference: gh<_i45.GetAllEventsForConference>(),
        ));
    gh.factory<_i55.SpeakersCubit>(() => _i55.SpeakersCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllSpeakerGetAllSpeakersForConference:
              gh<_i47.GetAllSpeakersForConference>(),
        ));
    gh.factory<_i56.WorkshopCubit>(() => _i56.WorkshopCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getWorkshopsForConference: gh<_i49.GetWorkshopsForConference>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i57.RegisterModule {}
