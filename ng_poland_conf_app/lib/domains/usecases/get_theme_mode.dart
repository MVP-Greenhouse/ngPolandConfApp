import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/domains/repositories/theme_mode_repository.dart';

@injectable
class GetThemeMode implements UseCase<ThemeMode, NoParams> {
  final ThemeModeRepository themeModeRepository;

  GetThemeMode(this.themeModeRepository);

  @override
  Future<ThemeMode> call(NoParams params) async {
    return await themeModeRepository.getThemeMode();
  }
}
