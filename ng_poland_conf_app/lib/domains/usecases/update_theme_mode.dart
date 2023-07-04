import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/domains/repositories/theme_mode_repository.dart';

@injectable
class UpdateThemeMode implements UseCase<void, ThemeMode> {
  final ThemeModeRepository themeModeRepository;

  UpdateThemeMode(this.themeModeRepository);

  @override
  Future<void> call(ThemeMode params) async {
    return await themeModeRepository.updateThemeMode(params);
  }
}
