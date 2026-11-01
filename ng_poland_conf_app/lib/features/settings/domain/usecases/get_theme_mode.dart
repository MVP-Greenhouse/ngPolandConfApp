import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/settings/domain/entities/app_theme_mode.dart';
import 'package:ng_poland_conf_app/features/settings/domain/repositories/theme_mode_repository.dart';

@injectable
class GetThemeMode implements NoParamsUseCase<AppThemeMode> {
  const GetThemeMode(this._repository);

  final ThemeModeRepository _repository;

  @override
  Future<AppThemeMode> call() => _repository.getThemeMode();
}
