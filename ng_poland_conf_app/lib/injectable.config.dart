// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'config/app_config.dart' as _i11;
import 'config/raw_config.dart' as _i4;
import 'config/register_module.dart' as _i43;
import 'core/blocks/conferences/conferences_cubit.dart' as _i3;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i6;
import 'features/home/datasources/data/conferences_remote_datasource.dart'
    as _i29;
import 'features/home/datasources/data/theme_mode_local_datasource.dart' as _i7;
import 'features/home/datasources/repositories/conferences_repository.dart'
    as _i31;
import 'features/home/datasources/repositories/theme_mode_repository.dart'
    as _i9;
import 'features/home/domains/repositories/conferences_repository.dart' as _i30;
import 'features/home/domains/repositories/theme_mode_repository.dart' as _i8;
import 'features/home/domains/usecases/get_all_conferences.dart' as _i32;
import 'features/home/domains/usecases/get_theme_mode.dart' as _i13;
import 'features/home/domains/usecases/update_theme_mode.dart' as _i10;
import 'features/info/datasources/data/info_remote_datasource.dart' as _i14;
import 'features/info/datasources/repositories/info_repository.dart' as _i16;
import 'features/info/domains/repositories/info_repository.dart' as _i15;
import 'features/info/domains/usecases/get_all_info_items_for_conference.dart'
    as _i34;
import 'features/info/presentation/cubit/info_cubit.dart' as _i38;
import 'features/nggirls/datasources/data/ngGirls_remote_datasource.dart'
    as _i17;
import 'features/nggirls/datasources/repositories/ngGirls_repository.dart'
    as _i19;
import 'features/nggirls/domains/repositories/ngGirls_repository.dart' as _i18;
import 'features/nggirls/domains/usecases/get_ngGirls_for_conference.dart'
    as _i36;
import 'features/nggirls/presentation/cubit/ngGirls_cubit.dart' as _i39;
import 'features/schedule/datasources/data/schedule_remote_datasource.dart'
    as _i20;
import 'features/schedule/datasources/repositories/schedule_repository.dart'
    as _i22;
import 'features/schedule/domains/repositories/schedule_repository.dart'
    as _i21;
import 'features/schedule/domains/usecases/get_all_events_for_conference.dart'
    as _i33;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i40;
import 'features/speakers/datasources/data/speakers_remote_datasource.dart'
    as _i23;
import 'features/speakers/datasources/repositories/speakers_repository.dart'
    as _i25;
import 'features/speakers/domains/repositories/speakers_repository.dart'
    as _i24;
import 'features/speakers/domains/usecases/get_all_speakers_for_conference.dart'
    as _i35;
import 'features/speakers/presentation/cubit/speakers_cubit.dart' as _i41;
import 'features/workshops/datasources/data/workshops_remote_datasource.dart'
    as _i26;
import 'features/workshops/datasources/repositories/workshops_repository.dart'
    as _i28;
import 'features/workshops/domains/repositories/workshops_repository.dart'
    as _i27;
import 'features/workshops/domains/usecases/get_workshops_for_conference.dart'
    as _i37;
import 'features/workshops/presentation/cubit/workshop_cubit.dart' as _i42;
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
    gh.singleton<_i6.ThemeModeCubit>(_i6.ThemeModeCubit());
    gh.singleton<_i7.ThemeModeLocalDataSource>(
        _i7.ThemeModeLocalDataSourceImpl());
    gh.singleton<_i8.ThemeModeRepository>(
        _i9.ThemeModeImpl(gh<_i7.ThemeModeLocalDataSource>()));
    gh.factory<_i10.UpdateThemeMode>(
        () => _i10.UpdateThemeMode(gh<_i8.ThemeModeRepository>()));
    gh.singleton<_i11.AppConfig>(_i11.AppConfig(gh<_i4.RawConfig>()));
    gh.singleton<_i12.Dio>(registerModule.dio(gh<_i11.AppConfig>()));
    gh.factory<_i13.GetThemeMode>(
        () => _i13.GetThemeMode(gh<_i8.ThemeModeRepository>()));
    gh.factory<_i14.InfoRemoteDataSource>(
        () => _i14.InfoRemoteDataSource(gh<_i12.Dio>()));
    gh.singleton<_i15.InfoRepository>(
        _i16.InfoRepositoryImpl(gh<_i14.InfoRemoteDataSource>()));
    gh.factory<_i17.NgGirlsRemoteDataSource>(
        () => _i17.NgGirlsRemoteDataSource(gh<_i12.Dio>()));
    gh.singleton<_i18.NgGirlsRepository>(
        _i19.NgGirlsImpl(gh<_i17.NgGirlsRemoteDataSource>()));
    gh.factory<_i20.ScheduleRemoteDataSource>(
        () => _i20.ScheduleRemoteDataSource(gh<_i12.Dio>()));
    gh.singleton<_i21.ScheduleRepository>(
        _i22.ScheduleRepositoryImpl(gh<_i20.ScheduleRemoteDataSource>()));
    gh.factory<_i23.SpeakersRemoteDataSource>(
        () => _i23.SpeakersRemoteDataSource(gh<_i12.Dio>()));
    gh.singleton<_i24.SpeakersRepository>(
        _i25.SpeakersRepositoryImpl(gh<_i23.SpeakersRemoteDataSource>()));
    gh.factory<_i26.WorkshopsRemoteDataSource>(
        () => _i26.WorkshopsRemoteDataSource(gh<_i12.Dio>()));
    gh.singleton<_i27.WorkshopsRepository>(
        _i28.WorkshopsRepositoryImpl(gh<_i26.WorkshopsRemoteDataSource>()));
    gh.factory<_i29.ConferencesRemoteDataSource>(
        () => _i29.ConferencesRemoteDataSource(gh<_i12.Dio>()));
    gh.singleton<_i30.ConferencesRepository>(
        _i31.ConferencesRepositoryImpl(gh<_i29.ConferencesRemoteDataSource>()));
    gh.factory<_i32.GetAllConferences>(
        () => _i32.GetAllConferences(gh<_i30.ConferencesRepository>()));
    gh.factory<_i33.GetAllEventsForConference>(
        () => _i33.GetAllEventsForConference(gh<_i21.ScheduleRepository>()));
    gh.factory<_i34.GetAllInfoItemsForConference>(
        () => _i34.GetAllInfoItemsForConference(gh<_i15.InfoRepository>()));
    gh.factory<_i35.GetAllSpeakersForConference>(
        () => _i35.GetAllSpeakersForConference(gh<_i24.SpeakersRepository>()));
    gh.factory<_i36.GetNgGirlsForConference>(
        () => _i36.GetNgGirlsForConference(gh<_i18.NgGirlsRepository>()));
    gh.factory<_i37.GetWorkshopsForConference>(
        () => _i37.GetWorkshopsForConference(gh<_i27.WorkshopsRepository>()));
    gh.factory<_i38.InfoCubit>(() => _i38.InfoCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllSpeakerGetAllInfoItemsForConference:
              gh<_i34.GetAllInfoItemsForConference>(),
        ));
    gh.factory<_i39.NgGirlsCubit>(() => _i39.NgGirlsCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getNgGirlsForConference: gh<_i36.GetNgGirlsForConference>(),
        ));
    gh.factory<_i40.ScheduleCubit>(() => _i40.ScheduleCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllEventsForConference: gh<_i33.GetAllEventsForConference>(),
        ));
    gh.factory<_i41.SpeakersCubit>(() => _i41.SpeakersCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllSpeakerGetAllSpeakersForConference:
              gh<_i35.GetAllSpeakersForConference>(),
        ));
    gh.factory<_i42.WorkshopCubit>(() => _i42.WorkshopCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getWorkshopsForConference: gh<_i37.GetWorkshopsForConference>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i43.RegisterModule {}
