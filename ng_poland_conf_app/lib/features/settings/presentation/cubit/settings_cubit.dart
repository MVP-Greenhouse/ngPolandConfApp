import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/settings/domains/usecases/get_settings.dart';
import '../../../../injectable.dart';
import '../../domains/entities/settings.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

@singleton
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState.initial());

  Future<void> getAppSettings() async {
    emit(const SettingsState.loading());
    final Settings settings = await getIt.get<GetSettings>().call();
    emit(SettingsState.loaded(settings: settings));
  }

  // Future<void> updateSettings(Settings settings) async {
  //   await getIt.get<UpdateSettings>().call(settings);

  //   emit(SettingsState.loaded(settings: settings));
  // }
}
