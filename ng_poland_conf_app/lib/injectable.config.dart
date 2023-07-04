// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/blocks/conferences/conferences_cubit.dart' as _i3;
import 'core/blocks/themeMode/theme_mode_cubit.dart' as _i9;
import 'datasources/data/conferences_remote_datasource.dart' as _i4;
import 'datasources/data/theme_mode_local_datasource.dart' as _i10;
import 'datasources/repositories/conferences_repository.dart' as _i6;
import 'datasources/repositories/theme_mode_repository.dart' as _i12;
import 'domains/repositories/conferences_repository.dart' as _i5;
import 'domains/repositories/theme_mode_repository.dart' as _i11;
import 'domains/usecases/get_all_conferences.dart' as _i7;
import 'domains/usecases/get_newest_conferences.dart' as _i8;
import 'domains/usecases/get_theme_mode.dart' as _i14;
import 'domains/usecases/update_theme_mode.dart' as _i13;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ConferencesCubit>(_i3.ConferencesCubit());
    gh.singleton<_i4.ConferencesRemoteDataSource>(
        _i4.ConferencesRemoteDataSourceImpl());
    gh.singleton<_i5.ConferencesRepository>(
        _i6.ConferencesRepositoryImpl(gh<_i4.ConferencesRemoteDataSource>()));
    gh.factory<_i7.GetAllConference>(
        () => _i7.GetAllConference(gh<_i5.ConferencesRepository>()));
    gh.factory<_i8.GetNewestConference>(
        () => _i8.GetNewestConference(gh<_i5.ConferencesRepository>()));
    gh.singleton<_i9.ThemeModeCubit>(_i9.ThemeModeCubit());
    gh.singleton<_i10.ThemeModeLocalDataSource>(
        _i10.ThemeModeLocalDataSourceImpl());
    gh.singleton<_i11.ThemeModeRepository>(
        _i12.ThemeModeImpl(gh<_i10.ThemeModeLocalDataSource>()));
    gh.factory<_i13.UpdateThemeMode>(
        () => _i13.UpdateThemeMode(gh<_i11.ThemeModeRepository>()));
    gh.factory<_i14.GetThemeMode>(
        () => _i14.GetThemeMode(gh<_i11.ThemeModeRepository>()));
    return this;
  }
}
