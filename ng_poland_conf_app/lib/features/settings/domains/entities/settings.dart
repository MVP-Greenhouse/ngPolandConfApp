import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class Settings with _$Settings {
  const Settings._();

  const factory Settings({
    required bool isDarkMode,
    required bool isNotificationEnable,
    required bool isConnectionEnable,
  }) = _Settings;

  factory Settings.initial() => const Settings(
        isDarkMode: true,
        isNotificationEnable: false,
        isConnectionEnable: false,
      );
}
