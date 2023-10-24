import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecases.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

@injectable
class GetSettings implements UseCase<Settings, NoParams> {
  final SettingsRepository settingsRepository;

  GetSettings(this.settingsRepository);

  @override
  Future<Settings> call([NoParams? params]) async {
    return await settingsRepository.getSettings();
  }
}
