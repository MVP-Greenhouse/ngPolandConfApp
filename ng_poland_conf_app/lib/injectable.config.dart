// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i22;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'config/app_config.dart' as _i21;
import 'config/raw_config.dart' as _i11;
import 'config/register_module.dart' as _i56;
import 'core/blocks/conferences/conferences_cubit.dart' as _i3;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i15;
import 'features/home/datasources/data/conferences_local_datasource.dart'
    as _i4;
import 'features/home/datasources/data/conferences_remote_datasource.dart'
    as _i42;
import 'features/home/datasources/data/theme_mode_local_datasource.dart'
    as _i16;
import 'features/home/datasources/repositories/conferences_repository.dart'
    as _i44;
import 'features/home/datasources/repositories/theme_mode_repository.dart'
    as _i18;
import 'features/home/domains/repositories/conferences_repository.dart' as _i43;
import 'features/home/domains/repositories/theme_mode_repository.dart' as _i17;
import 'features/home/domains/usecases/get_all_conferences.dart' as _i45;
import 'features/home/domains/usecases/get_theme_mode.dart' as _i24;
import 'features/home/domains/usecases/update_theme_mode.dart' as _i19;
import 'features/info/datasources/data/info_local_datasource.dart' as _i5;
import 'features/info/datasources/data/info_remote_datasource.dart' as _i25;
import 'features/info/datasources/repositories/info_repository.dart' as _i27;
import 'features/info/domains/repositories/info_repository.dart' as _i26;
import 'features/info/domains/usecases/get_all_info_items_for_conference.dart'
    as _i47;
import 'features/info/presentation/cubit/info_cubit.dart' as _i51;
import 'features/nggirls/datasources/data/ngGirls_local_datasource.dart' as _i6;
import 'features/nggirls/datasources/data/ngGirls_remote_datasource.dart'
    as _i28;
import 'features/nggirls/datasources/repositories/ngGirls_repository.dart'
    as _i30;
import 'features/nggirls/domains/repositories/ngGirls_repository.dart' as _i29;
import 'features/nggirls/domains/usecases/get_ngGirls_for_conference.dart'
    as _i49;
import 'features/nggirls/presentation/cubit/ngGirls_cubit.dart' as _i52;
import 'features/schedule/datasources/data/schedule_local_datasource.dart'
    as _i13;
import 'features/schedule/datasources/data/schedule_remote_datasource.dart'
    as _i32;
import 'features/schedule/datasources/repositories/schedule_repository.dart'
    as _i34;
import 'features/schedule/domains/repositories/schedule_repository.dart'
    as _i33;
import 'features/schedule/domains/usecases/get_all_events_for_conference.dart'
    as _i46;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i53;
import 'features/speakers/datasources/data/local/rate_speakers_local_datasource.dart'
    as _i7;
import 'features/speakers/datasources/data/local/speakers_local_datasource.dart'
    as _i14;
import 'features/speakers/datasources/data/remote/rate_speakers_remote_datasource.dart'
    as _i8;
import 'features/speakers/datasources/data/remote/speakers_remote_datasource.dart'
    as _i36;
import 'features/speakers/datasources/repositories/rate_speaker_repository.dart'
    as _i10;
import 'features/speakers/datasources/repositories/speakers_repository.dart'
    as _i38;
import 'features/speakers/domains/repositories/rate_speakers_repository.dart'
    as _i9;
import 'features/speakers/domains/repositories/speakers_repository.dart'
    as _i37;
import 'features/speakers/domains/usecases/get_all_speakers_for_conference.dart'
    as _i48;
import 'features/speakers/domains/usecases/get_rate_for_speaker.dart' as _i23;
import 'features/speakers/domains/usecases/rate_speaker.dart' as _i31;
import 'features/speakers/presentation/bloc/speaker_rating_bloc.dart' as _i35;
import 'features/speakers/presentation/cubit/speakers_cubit.dart' as _i54;
import 'features/workshops/datasources/data/workshops_local_datasource.dart'
    as _i20;
import 'features/workshops/datasources/data/workshops_remote_datasource.dart'
    as _i39;
import 'features/workshops/datasources/repositories/workshops_repository.dart'
    as _i41;
import 'features/workshops/domains/repositories/workshops_repository.dart'
    as _i40;
import 'features/workshops/domains/usecases/get_workshops_for_conference.dart'
    as _i50;
import 'features/workshops/presentation/cubit/workshop_cubit.dart' as _i55;
import 'routing/routing.dart' as _i12;

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
    gh.singleton<_i7.RateSpeakersLocalDataSource>(
        _i7.RateSpeakersLocalDataSourceImpl());
    gh.singleton<_i8.RateSpeakersRemoteDataSource>(
        _i8.RateSpeakersRemoteDataSourceImpl());
    gh.singleton<_i9.RateSpeakersRepository>(_i10.RateSpeakersRepositoryImpl(
      gh<_i8.RateSpeakersRemoteDataSource>(),
      gh<_i7.RateSpeakersLocalDataSource>(),
    ));
    await gh.singletonAsync<_i11.RawConfig>(
      () => registerModule.config(),
      preResolve: true,
    );
    gh.singleton<_i12.Routing>(_i12.Routing());
    gh.singleton<_i13.ScheduleLocalDataSource>(
        _i13.ScheduleLocalDataSourceImpl());
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
    gh.singleton<_i21.AppConfig>(_i21.AppConfig(gh<_i11.RawConfig>()));
    gh.singleton<_i22.Dio>(registerModule.dio(gh<_i21.AppConfig>()));
    gh.factory<_i23.GetRateForSpeaker>(
        () => _i23.GetRateForSpeaker(gh<_i9.RateSpeakersRepository>()));
    gh.factory<_i24.GetThemeMode>(
        () => _i24.GetThemeMode(gh<_i17.ThemeModeRepository>()));
    gh.factory<_i25.InfoRemoteDataSource>(
        () => _i25.InfoRemoteDataSource(gh<_i22.Dio>()));
    gh.singleton<_i26.InfoRepository>(_i27.InfoRepositoryImpl(
      gh<_i25.InfoRemoteDataSource>(),
      gh<_i5.InfoLocalDataSource>(),
    ));
    gh.factory<_i28.NgGirlsRemoteDataSource>(
        () => _i28.NgGirlsRemoteDataSource(gh<_i22.Dio>()));
    gh.singleton<_i29.NgGirlsRepository>(_i30.NgGirlsImpl(
      gh<_i28.NgGirlsRemoteDataSource>(),
      gh<_i6.NgGirlsLocalDataSource>(),
    ));
    gh.factory<_i31.RateSpeaker>(
        () => _i31.RateSpeaker(gh<_i9.RateSpeakersRepository>()));
    gh.factory<_i32.ScheduleRemoteDataSource>(
        () => _i32.ScheduleRemoteDataSource(gh<_i22.Dio>()));
    gh.singleton<_i33.ScheduleRepository>(_i34.ScheduleRepositoryImpl(
      gh<_i32.ScheduleRemoteDataSource>(),
      gh<_i13.ScheduleLocalDataSource>(),
    ));
    gh.factory<_i35.SpeakerRatingBloc>(() => _i35.SpeakerRatingBloc(
          gh<_i3.ConferencesCubit>(),
          gh<_i23.GetRateForSpeaker>(),
          gh<_i31.RateSpeaker>(),
          gh<String>(),
        ));
    gh.factory<_i36.SpeakersRemoteDataSource>(
        () => _i36.SpeakersRemoteDataSource(gh<_i22.Dio>()));
    gh.singleton<_i37.SpeakersRepository>(_i38.SpeakersRepositoryImpl(
      gh<_i36.SpeakersRemoteDataSource>(),
      gh<_i14.SpeakersLocalDataSource>(),
    ));
    gh.factory<_i39.WorkshopsRemoteDataSource>(
        () => _i39.WorkshopsRemoteDataSource(gh<_i22.Dio>()));
    gh.singleton<_i40.WorkshopsRepository>(_i41.WorkshopsRepositoryImpl(
      gh<_i39.WorkshopsRemoteDataSource>(),
      gh<_i20.WorkshopsLocalDataSource>(),
    ));
    gh.factory<_i42.ConferencesRemoteDataSource>(
        () => _i42.ConferencesRemoteDataSource(gh<_i22.Dio>()));
    gh.singleton<_i43.ConferencesRepository>(_i44.ConferencesRepositoryImpl(
      gh<_i42.ConferencesRemoteDataSource>(),
      gh<_i4.ConferencesLocalDataSource>(),
    ));
    gh.factory<_i45.GetAllConferences>(
        () => _i45.GetAllConferences(gh<_i43.ConferencesRepository>()));
    gh.factory<_i46.GetAllEventsForConference>(
        () => _i46.GetAllEventsForConference(gh<_i33.ScheduleRepository>()));
    gh.factory<_i47.GetAllInfoItemsForConference>(
        () => _i47.GetAllInfoItemsForConference(gh<_i26.InfoRepository>()));
    gh.factory<_i48.GetAllSpeakersForConference>(
        () => _i48.GetAllSpeakersForConference(gh<_i37.SpeakersRepository>()));
    gh.factory<_i49.GetNgGirlsForConference>(
        () => _i49.GetNgGirlsForConference(gh<_i29.NgGirlsRepository>()));
    gh.factory<_i50.GetWorkshopsForConference>(
        () => _i50.GetWorkshopsForConference(gh<_i40.WorkshopsRepository>()));
    gh.factory<_i51.InfoCubit>(() => _i51.InfoCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllSpeakerGetAllInfoItemsForConference:
              gh<_i47.GetAllInfoItemsForConference>(),
        ));
    gh.factory<_i52.NgGirlsCubit>(() => _i52.NgGirlsCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getNgGirlsForConference: gh<_i49.GetNgGirlsForConference>(),
        ));
    gh.factory<_i53.ScheduleCubit>(() => _i53.ScheduleCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllEventsForConference: gh<_i46.GetAllEventsForConference>(),
        ));
    gh.factory<_i54.SpeakersCubit>(() => _i54.SpeakersCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getAllSpeakerGetAllSpeakersForConference:
              gh<_i48.GetAllSpeakersForConference>(),
        ));
    gh.factory<_i55.WorkshopCubit>(() => _i55.WorkshopCubit(
          conferencesCubit: gh<_i3.ConferencesCubit>(),
          getWorkshopsForConference: gh<_i50.GetWorkshopsForConference>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i56.RegisterModule {}
