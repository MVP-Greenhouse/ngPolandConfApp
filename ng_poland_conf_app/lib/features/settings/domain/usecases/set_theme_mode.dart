import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/settings/domain/entities/app_theme_mode.dart';
import 'package:ng_poland_conf_app/features/settings/domain/repositories/theme_mode_repository.dart';

@injectable
class SetThemeMode implements UseCase<void, AppThemeMode> {
  const SetThemeMode(this._repository);

  final ThemeModeRepository _repository;

  @override
  Future<void> call(AppThemeMode themeMode) =>
      _repository.setThemeMode(themeMode);
}
