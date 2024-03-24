// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i23;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'config/app_config.dart' as _i21;
import 'config/raw_config.dart' as _i9;
import 'config/register_module.dart' as _i54;
import 'core/blocks/conferences/conferences_cubit.dart' as _i5;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i15;
import 'features/authentication/datasources/repositories/authentication_repository.dart'
    as _i4;
import 'features/authentication/domains/repositories/authentication_repository.dart'
    as _i3;
import 'features/authentication/domains/usecases/sign_in_apple.dart' as _i12;
import 'features/authentication/domains/usecases/sign_in_google.dart' as _i13;
import 'features/authentication/presentation/cubit/authentication_cubit.dart'
    as _i22;
import 'features/home/datasources/data/conferences_local_datasource.dart'
    as _i6;
import 'features/home/datasources/data/conferences_remote_datasource.dart'
    as _i40;
import 'features/home/datasources/data/theme_mode_local_datasource.dart'
    as _i16;
import 'features/home/datasources/repositories/conferences_repository.dart'
    as _i42;
import 'features/home/datasources/repositories/theme_mode_repository.dart'
    as _i18;
import 'features/home/domains/repositories/conferences_repository.dart' as _i41;
import 'features/home/domains/repositories/theme_mode_repository.dart' as _i17;
import 'features/home/domains/usecases/get_all_conferences.dart' as _i43;
import 'features/home/domains/usecases/get_theme_mode.dart' as _i24;
import 'features/home/domains/usecases/update_theme_mode.dart' as _i19;
import 'features/info/datasources/data/info_local_datasource.dart' as _i7;
import 'features/info/datasources/data/info_remote_datasource.dart' as _i25;
import 'features/info/datasources/repositories/info_repository.dart' as _i27;
import 'features/info/domains/repositories/info_repository.dart' as _i26;
import 'features/info/domains/usecases/get_all_info_items_for_conference.dart'
    as _i45;
import 'features/info/presentation/cubit/info_cubit.dart' as _i49;
import 'features/nggirls/datasources/data/ngGirls_local_datasource.dart' as _i8;
import 'features/nggirls/datasources/data/ngGirls_remote_datasource.dart'
    as _i28;
import 'features/nggirls/datasources/repositories/ngGirls_repository.dart'
    as _i30;
import 'features/nggirls/domains/repositories/ngGirls_repository.dart' as _i29;
import 'features/nggirls/domains/usecases/get_ngGirls_for_conference.dart'
    as _i47;
import 'features/nggirls/presentation/cubit/ngGirls_cubit.dart' as _i50;
import 'features/schedule/datasources/data/schedule_local_datasource.dart'
    as _i11;
import 'features/schedule/datasources/data/schedule_remote_datasource.dart'
    as _i31;
import 'features/schedule/datasources/repositories/schedule_repository.dart'
    as _i33;
import 'features/schedule/domains/repositories/schedule_repository.dart'
    as _i32;
import 'features/schedule/domains/usecases/get_all_events_for_conference.dart'
    as _i44;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i51;
import 'features/speakers/datasources/data/speakers_local_datasource.dart'
    as _i14;
import 'features/speakers/datasources/data/speakers_remote_datasource.dart'
    as _i34;
import 'features/speakers/datasources/repositories/speakers_repository.dart'
    as _i36;
import 'features/speakers/domains/repositories/speakers_repository.dart'
    as _i35;
import 'features/speakers/domains/usecases/get_all_speakers_for_conference.dart'
    as _i46;
import 'features/speakers/presentation/cubit/speakers_cubit.dart' as _i52;
import 'features/workshops/datasources/data/workshops_local_datasource.dart'
    as _i20;
import 'features/workshops/datasources/data/workshops_remote_datasource.dart'
    as _i37;
import 'features/workshops/datasources/repositories/workshops_repository.dart'
    as _i39;
import 'features/workshops/domains/repositories/workshops_repository.dart'
    as _i38;
import 'features/workshops/domains/usecases/get_workshops_for_conference.dart'
    as _i48;
import 'features/workshops/presentation/cubit/workshop_cubit.dart' as _i53;
import 'routing/routing.dart' as _i10;

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
    gh.singleton<_i3.AuthenticationRepository>(
        const _i4.AuthenticationRepositoryImpl());
    gh.singleton<_i5.ConferencesCubit>(_i5.ConferencesCubit());
    gh.singleton<_i6.ConferencesLocalDataSource>(
        _i6.ConferencesLocalDataSourceImpl());
    gh.singleton<_i7.InfoLocalDataSource>(_i7.InfoLocalDataSourceImpl());
    gh.singleton<_i8.NgGirlsLocalDataSource>(_i8.NgGirlsLocalDataSourceImpl());
    await gh.singletonAsync<_i9.RawConfig>(
      () => registerModule.config(),
      preResolve: true,
    );
    gh.singleton<_i10.Routing>(_i10.Routing());
    gh.singleton<_i11.ScheduleLocalDataSource>(
        _i11.ScheduleLocalDataSourceImpl());
    gh.factory<_i12.SignInAppleUseCase>(
        () => _i12.SignInAppleUseCase(gh<_i3.AuthenticationRepository>()));
    gh.factory<_i13.SignInGoogleUseCase>(
        () => _i13.SignInGoogleUseCase(gh<_i3.AuthenticationRepository>()));
    gh.singleton<_i14.SpeakersLocalDataSource>(
        _i14.SpeakersLocalDataSourceImpl());
    gh.singleton<_i15.ThemeModeCubit>(_i15.ThemeModeCubit());
    gh.singleton<_i16.ThemeModeLocalDataSource>(
        _i16.ThemeModeLocalDataSourceImpl());
    gh.singleton<_i17.ThemeModeRepository>(
        _i18.ThemeModeImpl(gh<_i16.ThemeModeLocalDataSource>()));
    gh.factory<_i19.UpdateThemeMode>(
        () => _i19.UpdateThemeMode(gh<_i17.ThemeModeRepository>()));
    gh.singleton<_i20.WorkshopsLocalDataSource>(
        _i20.WorkshopsLocalDataSourceImpl());
    gh.singleton<_i21.AppConfig>(_i21.AppConfig(gh<_i9.RawConfig>()));
    gh.factory<_i22.AuthenticationCubit>(() => _i22.AuthenticationCubit(
          gh<_i12.SignInAppleUseCase>(),
          gh<_i13.SignInGoogleUseCase>(),
        ));
    gh.singleton<_i23.Dio>(registerModule.dio(gh<_i21.AppConfig>()));
    gh.factory<_i24.GetThemeMode>(
        () => _i24.GetThemeMode(gh<_i17.ThemeModeRepository>()));
    gh.factory<_i25.InfoRemoteDataSource>(
        () => _i25.InfoRemoteDataSource(gh<_i23.Dio>()));
    gh.singleton<_i26.InfoRepository>(_i27.InfoRepositoryImpl(
      gh<_i25.InfoRemoteDataSource>(),
      gh<_i7.InfoLocalDataSource>(),
    ));
    gh.factory<_i28.NgGirlsRemoteDataSource>(
        () => _i28.NgGirlsRemoteDataSource(gh<_i23.Dio>()));
    gh.singleton<_i29.NgGirlsRepository>(_i30.NgGirlsImpl(
      gh<_i28.NgGirlsRemoteDataSource>(),
      gh<_i8.NgGirlsLocalDataSource>(),
    ));
    gh.factory<_i31.ScheduleRemoteDataSource>(
        () => _i31.ScheduleRemoteDataSource(gh<_i23.Dio>()));
    gh.singleton<_i32.ScheduleRepository>(_i33.ScheduleRepositoryImpl(
      gh<_i31.ScheduleRemoteDataSource>(),
      gh<_i11.ScheduleLocalDataSource>(),
    ));
    gh.factory<_i34.SpeakersRemoteDataSource>(
        () => _i34.SpeakersRemoteDataSource(gh<_i23.Dio>()));
    gh.singleton<_i35.SpeakersRepository>(_i36.SpeakersRepositoryImpl(
      gh<_i34.SpeakersRemoteDataSource>(),
      gh<_i14.SpeakersLocalDataSource>(),
    ));
    gh.factory<_i37.WorkshopsRemoteDataSource>(
        () => _i37.WorkshopsRemoteDataSource(gh<_i23.Dio>()));
    gh.singleton<_i38.WorkshopsRepository>(_i39.WorkshopsRepositoryImpl(
      gh<_i37.WorkshopsRemoteDataSource>(),
      gh<_i20.WorkshopsLocalDataSource>(),
    ));
    gh.factory<_i40.ConferencesRemoteDataSource>(
        () => _i40.ConferencesRemoteDataSource(gh<_i23.Dio>()));
    gh.singleton<_i41.ConferencesRepository>(_i42.ConferencesRepositoryImpl(
      gh<_i40.ConferencesRemoteDataSource>(),
      gh<_i6.ConferencesLocalDataSource>(),
    ));
    gh.factory<_i43.GetAllConferences>(
        () => _i43.GetAllConferences(gh<_i41.ConferencesRepository>()));
    gh.factory<_i44.GetAllEventsForConference>(
        () => _i44.GetAllEventsForConference(gh<_i32.ScheduleRepository>()));
    gh.factory<_i45.GetAllInfoItemsForConference>(
        () => _i45.GetAllInfoItemsForConference(gh<_i26.InfoRepository>()));
    gh.factory<_i46.GetAllSpeakersForConference>(
        () => _i46.GetAllSpeakersForConference(gh<_i35.SpeakersRepository>()));
    gh.factory<_i47.GetNgGirlsForConference>(
        () => _i47.GetNgGirlsForConference(gh<_i29.NgGirlsRepository>()));
    gh.factory<_i48.GetWorkshopsForConference>(
        () => _i48.GetWorkshopsForConference(gh<_i38.WorkshopsRepository>()));
    gh.factory<_i49.InfoCubit>(() => _i49.InfoCubit(
          conferencesCubit: gh<_i5.ConferencesCubit>(),
          getAllSpeakerGetAllInfoItemsForConference:
              gh<_i45.GetAllInfoItemsForConference>(),
        ));
    gh.factory<_i50.NgGirlsCubit>(() => _i50.NgGirlsCubit(
          conferencesCubit: gh<_i5.ConferencesCubit>(),
          getNgGirlsForConference: gh<_i47.GetNgGirlsForConference>(),
        ));
    gh.factory<_i51.ScheduleCubit>(() => _i51.ScheduleCubit(
          conferencesCubit: gh<_i5.ConferencesCubit>(),
          getAllEventsForConference: gh<_i44.GetAllEventsForConference>(),
        ));
    gh.factory<_i52.SpeakersCubit>(() => _i52.SpeakersCubit(
          conferencesCubit: gh<_i5.ConferencesCubit>(),
          getAllSpeakerGetAllSpeakersForConference:
              gh<_i46.GetAllSpeakersForConference>(),
        ));
    gh.factory<_i53.WorkshopCubit>(() => _i53.WorkshopCubit(
          conferencesCubit: gh<_i5.ConferencesCubit>(),
          getWorkshopsForConference: gh<_i48.GetWorkshopsForConference>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i54.RegisterModule {}
