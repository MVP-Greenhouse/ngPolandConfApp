// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i16;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'config/app_config.dart' as _i15;
import 'config/raw_config.dart' as _i4;
import 'config/register_module.dart' as _i48;
import 'core/blocks/conferences/conferences_cubit.dart' as _i3;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i10;
import 'features/home/datasources/data/conferences_remote_datasource.dart'
    as _i34;
import 'features/home/datasources/data/theme_mode_local_datasource.dart'
    as _i11;
import 'features/home/datasources/repositories/conferences_repository.dart'
    as _i36;
import 'features/home/datasources/repositories/theme_mode_repository.dart'
    as _i13;
import 'features/home/domains/repositories/conferences_repository.dart' as _i35;
import 'features/home/domains/repositories/theme_mode_repository.dart' as _i12;
import 'features/home/domains/usecases/get_all_conferences.dart' as _i37;
import 'features/home/domains/usecases/get_theme_mode.dart' as _i18;
import 'features/home/domains/usecases/update_theme_mode.dart' as _i14;
import 'features/info/datasources/data/info_remote_datasource.dart' as _i19;
import 'features/info/datasources/repositories/info_repository.dart' as _i21;
import 'features/info/domains/repositories/info_repository.dart' as _i20;
import 'features/info/domains/usecases/get_all_info_items_for_conference.dart'
    as _i39;
import 'features/info/presentation/cubit/info_cubit.dart' as _i43;
import 'features/nggirls/datasources/data/ngGirls_remote_datasource.dart'
    as _i22;
import 'features/nggirls/datasources/repositories/ngGirls_repository.dart'
    as _i24;
import 'features/nggirls/domains/repositories/ngGirls_repository.dart' as _i23;
import 'features/nggirls/domains/usecases/get_ngGirls_for_conference.dart'
    as _i41;
import 'features/nggirls/presentation/cubit/ngGirls_cubit.dart' as _i44;
import 'features/schedule/datasources/data/schedule_remote_datasource.dart'
    as _i25;
import 'features/schedule/datasources/repositories/schedule_repository.dart'
    as _i27;
import 'features/schedule/domains/repositories/schedule_repository.dart'
    as _i26;
import 'features/schedule/domains/usecases/get_all_events_for_conference.dart'
    as _i38;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i45;
import 'features/settings/datasources/data/repositiories/settings_repository.dart'
    as _i9;
import 'features/settings/datasources/data/settings_local_datasource.dart'
    as _i7;
import 'features/settings/domains/repositories/settings_repository.dart' as _i8;
import 'features/settings/domains/usecases/get_settings.dart' as _i17;
import 'features/settings/presentation/cubit/settings_cubit.dart' as _i6;
import 'features/speakers/datasources/data/speakers_remote_datasource.dart'
    as _i28;
import 'features/speakers/datasources/repositories/speakers_repository.dart'
    as _i30;
import 'features/speakers/domains/repositories/speakers_repository.dart'
    as _i29;
import 'features/speakers/domains/usecases/get_all_speakers_for_conference.dart'
    as _i40;
import 'features/speakers/presentation/cubit/speakers_cubit.dart' as _i46;
import 'features/workshops/datasources/data/workshops_remote_datasource.dart'
    as _i31;
import 'features/workshops/datasources/repositories/workshops_repository.dart'
    as _i33;
import 'features/workshops/domains/repositories/workshops_repository.dart'
    as _i32;
import 'features/workshops/domains/usecases/get_workshops_for_conference.dart'
    as _i42;
import 'features/workshops/presentation/cubit/workshop_cubit.dart' as _i47;
import 'routing/routing.dart' as _i5;

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
    await gh.singletonAsync<_i4.RawConfig>(
      () => registerModule.config(),
      preResolve: true,
    );
    gh.singleton<_i5.Routing>(_i5.Routing());
    gh.singleton<_i6.SettingsCubit>(_i6.SettingsCubit());
    gh.singleton<_i7.SettingsLocalDataSource>(
        _i7.SettingsLocalDataSourceImpl());
    gh.singleton<_i8.SettingsRepository>(
        _i9.SettingsImpl(gh<_i7.SettingsLocalDataSource>()));
    gh.singleton<_i10.ThemeModeCubit>(_i10.ThemeModeCubit());
    gh.singleton<_i11.ThemeModeLocalDataSource>(
        _i11.ThemeModeLocalDataSourceImpl());
    gh.singleton<_i12.ThemeModeRepository>(
        _i13.ThemeModeImpl(gh<_i11.ThemeModeLocalDataSource>()));
    gh.factory<_i14.UpdateThemeMode>(
        () => _i14.UpdateThemeMode(gh<_i12.ThemeModeRepository>()));
    gh.singleton<_i15.AppConfig>(_i15.AppConfig(gh<_i4.RawConfig>()));
    gh.singleton<_i16.Dio>(registerModule.dio(gh<_i15.AppConfig>()));
    gh.factory<_i17.GetSettings>(
        () => _i17.GetSettings(gh<_i8.SettingsRepository>()));
    gh.factory<_i18.GetThemeMode>(
        () => _i18.GetThemeMode(gh<_i12.ThemeModeRepository>()));
    gh.factory<_i19.InfoRemoteDataSource>(
        () => _i19.InfoRemoteDataSource(gh<_i16.Dio>()));
    gh.singleton<_i20.InfoRepository>(
        _i21.InfoRepositoryImpl(gh<_i19.InfoRemoteDataSource>()));
    gh.factory<_i22.NgGirlsRemoteDataSource>(
        () => _i22.NgGirlsRemoteDataSource(gh<_i16.Dio>()));
    gh.singleton<_i23.NgGirlsRepository>(
        _i24.NgGirlsImpl(gh<_i22.NgGirlsRemoteDataSource>()));
    gh.factory<_i25.ScheduleRemoteDataSource>(
        () => _i25.ScheduleRemoteDataSource(gh<_i16.Dio>()));
    gh.singleton<_i26.ScheduleRepository>(
        _i27.ScheduleRepositoryImpl(gh<_i25.ScheduleRemoteDataSource>()));
    gh.factory<_i28.SpeakersRemoteDataSource>(
        () => _i28.SpeakersRemoteDataSource(gh<_i16.Dio>()));
    gh.singleton<_i29.SpeakersRepository>(
        _i30.SpeakersRepositoryImpl(gh<_i28.SpeakersRemoteDataSource>()));
    gh.factory<_i31.WorkshopsRemoteDataSource>(
        () => _i31.WorkshopsRemoteDataSource(gh<_i16.Dio>()));
    gh.singleton<_i32.WorkshopsRepository>(
        _i33.WorkshopsRepositoryImpl(gh<_i31.WorkshopsRemoteDataSource>()));
    gh.factory<_i34.ConferencesRemoteDataSource>(
        () => _i34.ConferencesRemoteDataSource(gh<_i16.Dio>()));
    gh.singleton<_i35.ConferencesRepository>(
        _i36.ConferencesRepositoryImpl(gh<_i34.ConferencesRemoteDataSource>()));
    gh.factory<_i37.GetAllConferences>(
        () => _i37.GetAllConferences(gh<_i35.ConferencesRepository>()));
    gh.factory<_i38.GetAllEventsForConference>(
        () => _i38.GetAllEventsForConference(gh<_i26.ScheduleRepository>()));
    gh.factory<_i39.GetAllInfoItemsForConference>(
        () => _i39.GetAllInfoItemsForConference(gh<_i20.InfoRepository>()));
    gh.factory<_i40.GetAllSpeakersForConference>(
        () => _i40.GetAllSpeakersForConference(gh<_i29.SpeakersRepository>()));
    gh.factory<_i41.GetNgGirlsForConference>(
        () => _i41.GetNgGirlsForConference(gh<_i23.NgGirlsRepository>()));
    gh.factory<_i42.GetWorkshopsForConference>(
        () => _i42.GetWorkshopsForConference(gh<_i32.WorkshopsRepository>()));
    gh.factory<_i43.InfoCubit>(() => _i43.InfoCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllSpeakerGetAllInfoItemsForConference:
              gh<_i39.GetAllInfoItemsForConference>(),
        ));
    gh.factory<_i44.NgGirlsCubit>(() => _i44.NgGirlsCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getNgGirlsForConference: gh<_i41.GetNgGirlsForConference>(),
        ));
    gh.factory<_i45.ScheduleCubit>(() => _i45.ScheduleCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllEventsForConference: gh<_i38.GetAllEventsForConference>(),
        ));
    gh.factory<_i46.SpeakersCubit>(() => _i46.SpeakersCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllSpeakerGetAllSpeakersForConference:
              gh<_i40.GetAllSpeakersForConference>(),
        ));
    gh.factory<_i47.WorkshopCubit>(() => _i47.WorkshopCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getWorkshopsForConference: gh<_i42.GetWorkshopsForConference>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i48.RegisterModule {}
