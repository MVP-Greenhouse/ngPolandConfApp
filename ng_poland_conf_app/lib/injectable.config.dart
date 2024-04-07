// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i27;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'config/app_config.dart' as _i25;
import 'config/raw_config.dart' as _i13;
import 'config/register_module.dart' as _i61;
import 'core/blocks/conferences/conferences_cubit.dart' as _i5;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i19;
import 'features/authentication/datasources/repositories/authentication_repository.dart'
    as _i4;
import 'features/authentication/domains/repositories/authentication_repository.dart'
    as _i3;
import 'features/authentication/domains/usecases/sign_in_apple.dart' as _i16;
import 'features/authentication/domains/usecases/sign_in_google.dart' as _i17;
import 'features/authentication/presentation/cubit/authentication_cubit.dart'
    as _i26;
import 'features/home/datasources/data/conferences_local_datasource.dart'
    as _i6;
import 'features/home/datasources/data/conferences_remote_datasource.dart'
    as _i47;
import 'features/home/datasources/data/theme_mode_local_datasource.dart'
    as _i20;
import 'features/home/datasources/repositories/conferences_repository.dart'
    as _i49;
import 'features/home/datasources/repositories/theme_mode_repository.dart'
    as _i22;
import 'features/home/domains/repositories/conferences_repository.dart' as _i48;
import 'features/home/domains/repositories/theme_mode_repository.dart' as _i21;
import 'features/home/domains/usecases/get_all_conferences.dart' as _i50;
import 'features/home/domains/usecases/get_theme_mode.dart' as _i29;
import 'features/home/domains/usecases/update_theme_mode.dart' as _i23;
import 'features/info/datasources/data/info_local_datasource.dart' as _i7;
import 'features/info/datasources/data/info_remote_datasource.dart' as _i30;
import 'features/info/datasources/repositories/info_repository.dart' as _i32;
import 'features/info/domains/repositories/info_repository.dart' as _i31;
import 'features/info/domains/usecases/get_all_info_items_for_conference.dart'
    as _i52;
import 'features/info/presentation/cubit/info_cubit.dart' as _i56;
import 'features/nggirls/datasources/data/ngGirls_local_datasource.dart' as _i8;
import 'features/nggirls/datasources/data/ngGirls_remote_datasource.dart'
    as _i33;
import 'features/nggirls/datasources/repositories/ngGirls_repository.dart'
    as _i35;
import 'features/nggirls/domains/repositories/ngGirls_repository.dart' as _i34;
import 'features/nggirls/domains/usecases/get_ngGirls_for_conference.dart'
    as _i54;
import 'features/nggirls/presentation/cubit/ngGirls_cubit.dart' as _i57;
import 'features/schedule/datasources/data/schedule_local_datasource.dart'
    as _i15;
import 'features/schedule/datasources/data/schedule_remote_datasource.dart'
    as _i37;
import 'features/schedule/datasources/repositories/schedule_repository.dart'
    as _i39;
import 'features/schedule/domains/repositories/schedule_repository.dart'
    as _i38;
import 'features/schedule/domains/usecases/get_all_events_for_conference.dart'
    as _i51;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i58;
import 'features/speakers/datasources/data/local/rate_speakers_local_datasource.dart'
    as _i9;
import 'features/speakers/datasources/data/local/speakers_local_datasource.dart'
    as _i18;
import 'features/speakers/datasources/data/remote/rate_speakers_remote_datasource.dart'
    as _i10;
import 'features/speakers/datasources/data/remote/speakers_remote_datasource.dart'
    as _i41;
import 'features/speakers/datasources/repositories/rate_speaker_repository.dart'
    as _i12;
import 'features/speakers/datasources/repositories/speakers_repository.dart'
    as _i43;
import 'features/speakers/domains/repositories/rate_speakers_repository.dart'
    as _i11;
import 'features/speakers/domains/repositories/speakers_repository.dart'
    as _i42;
import 'features/speakers/domains/usecases/get_all_speakers_for_conference.dart'
    as _i53;
import 'features/speakers/domains/usecases/get_rate_for_speaker.dart' as _i28;
import 'features/speakers/domains/usecases/rate_speaker.dart' as _i36;
import 'features/speakers/presentation/bloc/speaker_rating_bloc.dart' as _i40;
import 'features/speakers/presentation/cubit/speakers_cubit.dart' as _i59;
import 'features/workshops/datasources/data/workshops_local_datasource.dart'
    as _i24;
import 'features/workshops/datasources/data/workshops_remote_datasource.dart'
    as _i44;
import 'features/workshops/datasources/repositories/workshops_repository.dart'
    as _i46;
import 'features/workshops/domains/repositories/workshops_repository.dart'
    as _i45;
import 'features/workshops/domains/usecases/get_workshops_for_conference.dart'
    as _i55;
import 'features/workshops/presentation/cubit/workshop_cubit.dart' as _i60;
import 'routing/routing.dart' as _i14;

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
    gh.singleton<_i9.RateSpeakersLocalDataSource>(
        _i9.RateSpeakersLocalDataSourceImpl());
    gh.singleton<_i10.RateSpeakersRemoteDataSource>(
        _i10.RateSpeakersRemoteDataSourceImpl());
    gh.singleton<_i11.RateSpeakersRepository>(_i12.RateSpeakersRepositoryImpl(
      gh<_i10.RateSpeakersRemoteDataSource>(),
      gh<_i9.RateSpeakersLocalDataSource>(),
    ));
    await gh.singletonAsync<_i13.RawConfig>(
      () => registerModule.config(),
      preResolve: true,
    );
    gh.singleton<_i14.Routing>(_i14.Routing());
    gh.singleton<_i15.ScheduleLocalDataSource>(
        _i15.ScheduleLocalDataSourceImpl());
    gh.factory<_i16.SignInAppleUseCase>(
        () => _i16.SignInAppleUseCase(gh<_i3.AuthenticationRepository>()));
    gh.factory<_i17.SignInGoogleUseCase>(
        () => _i17.SignInGoogleUseCase(gh<_i3.AuthenticationRepository>()));
    gh.singleton<_i18.SpeakersLocalDataSource>(
        _i18.SpeakersLocalDataSourceImpl());
    gh.singleton<_i19.ThemeModeCubit>(_i19.ThemeModeCubit());
    gh.singleton<_i20.ThemeModeLocalDataSource>(
        _i20.ThemeModeLocalDataSourceImpl());
    gh.singleton<_i21.ThemeModeRepository>(
        _i22.ThemeModeImpl(gh<_i20.ThemeModeLocalDataSource>()));
    gh.factory<_i23.UpdateThemeMode>(
        () => _i23.UpdateThemeMode(gh<_i21.ThemeModeRepository>()));
    gh.singleton<_i24.WorkshopsLocalDataSource>(
        _i24.WorkshopsLocalDataSourceImpl());
    gh.singleton<_i25.AppConfig>(_i25.AppConfig(gh<_i13.RawConfig>()));
    gh.factory<_i26.AuthenticationCubit>(() => _i26.AuthenticationCubit(
          gh<_i16.SignInAppleUseCase>(),
          gh<_i17.SignInGoogleUseCase>(),
        ));
    gh.singleton<_i27.Dio>(registerModule.dio(gh<_i25.AppConfig>()));
    gh.factory<_i28.GetRateForSpeaker>(
        () => _i28.GetRateForSpeaker(gh<_i11.RateSpeakersRepository>()));
    gh.factory<_i29.GetThemeMode>(
        () => _i29.GetThemeMode(gh<_i21.ThemeModeRepository>()));
    gh.factory<_i30.InfoRemoteDataSource>(
        () => _i30.InfoRemoteDataSource(gh<_i27.Dio>()));
    gh.singleton<_i31.InfoRepository>(_i32.InfoRepositoryImpl(
      gh<_i30.InfoRemoteDataSource>(),
      gh<_i7.InfoLocalDataSource>(),
    ));
    gh.factory<_i33.NgGirlsRemoteDataSource>(
        () => _i33.NgGirlsRemoteDataSource(gh<_i27.Dio>()));
    gh.singleton<_i34.NgGirlsRepository>(_i35.NgGirlsImpl(
      gh<_i33.NgGirlsRemoteDataSource>(),
      gh<_i8.NgGirlsLocalDataSource>(),
    ));
    gh.factory<_i36.RateSpeaker>(
        () => _i36.RateSpeaker(gh<_i11.RateSpeakersRepository>()));
    gh.factory<_i37.ScheduleRemoteDataSource>(
        () => _i37.ScheduleRemoteDataSource(gh<_i27.Dio>()));
    gh.singleton<_i38.ScheduleRepository>(_i39.ScheduleRepositoryImpl(
      gh<_i37.ScheduleRemoteDataSource>(),
      gh<_i15.ScheduleLocalDataSource>(),
    ));
    gh.factory<_i40.SpeakerRatingBloc>(() => _i40.SpeakerRatingBloc(
          gh<_i5.ConferencesCubit>(),
          gh<_i28.GetRateForSpeaker>(),
          gh<_i36.RateSpeaker>(),
          gh<String>(),
        ));
    gh.factory<_i41.SpeakersRemoteDataSource>(
        () => _i41.SpeakersRemoteDataSource(gh<_i27.Dio>()));
    gh.singleton<_i42.SpeakersRepository>(_i43.SpeakersRepositoryImpl(
      gh<_i41.SpeakersRemoteDataSource>(),
      gh<_i18.SpeakersLocalDataSource>(),
    ));
    gh.factory<_i44.WorkshopsRemoteDataSource>(
        () => _i44.WorkshopsRemoteDataSource(gh<_i27.Dio>()));
    gh.singleton<_i45.WorkshopsRepository>(_i46.WorkshopsRepositoryImpl(
      gh<_i44.WorkshopsRemoteDataSource>(),
      gh<_i24.WorkshopsLocalDataSource>(),
    ));
    gh.factory<_i47.ConferencesRemoteDataSource>(
        () => _i47.ConferencesRemoteDataSource(gh<_i27.Dio>()));
    gh.singleton<_i48.ConferencesRepository>(_i49.ConferencesRepositoryImpl(
      gh<_i47.ConferencesRemoteDataSource>(),
      gh<_i6.ConferencesLocalDataSource>(),
    ));
    gh.factory<_i50.GetAllConferences>(
        () => _i50.GetAllConferences(gh<_i48.ConferencesRepository>()));
    gh.factory<_i51.GetAllEventsForConference>(
        () => _i51.GetAllEventsForConference(gh<_i38.ScheduleRepository>()));
    gh.factory<_i52.GetAllInfoItemsForConference>(
        () => _i52.GetAllInfoItemsForConference(gh<_i31.InfoRepository>()));
    gh.factory<_i53.GetAllSpeakersForConference>(
        () => _i53.GetAllSpeakersForConference(gh<_i42.SpeakersRepository>()));
    gh.factory<_i54.GetNgGirlsForConference>(
        () => _i54.GetNgGirlsForConference(gh<_i34.NgGirlsRepository>()));
    gh.factory<_i55.GetWorkshopsForConference>(
        () => _i55.GetWorkshopsForConference(gh<_i45.WorkshopsRepository>()));
    gh.factory<_i56.InfoCubit>(() => _i56.InfoCubit(
          conferencesCubit: gh<_i5.ConferencesCubit>(),
          getAllSpeakerGetAllInfoItemsForConference:
              gh<_i52.GetAllInfoItemsForConference>(),
        ));
    gh.factory<_i57.NgGirlsCubit>(() => _i57.NgGirlsCubit(
          conferencesCubit: gh<_i5.ConferencesCubit>(),
          getNgGirlsForConference: gh<_i54.GetNgGirlsForConference>(),
        ));
    gh.factory<_i58.ScheduleCubit>(() => _i58.ScheduleCubit(
          conferencesCubit: gh<_i5.ConferencesCubit>(),
          getAllEventsForConference: gh<_i51.GetAllEventsForConference>(),
        ));
    gh.factory<_i59.SpeakersCubit>(() => _i59.SpeakersCubit(
          conferencesCubit: gh<_i5.ConferencesCubit>(),
          getAllSpeakerGetAllSpeakersForConference:
              gh<_i53.GetAllSpeakersForConference>(),
        ));
    gh.factory<_i60.WorkshopCubit>(() => _i60.WorkshopCubit(
          conferencesCubit: gh<_i5.ConferencesCubit>(),
          getWorkshopsForConference: gh<_i55.GetWorkshopsForConference>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i61.RegisterModule {}
