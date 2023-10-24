import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
@HiveType(typeId: 0)
class Settings extends HiveObject with _$Settings {
  Settings._();

  factory Settings({
    @HiveField(0) required bool isConnectionEnabled,
  }) = _Settings;

  factory Settings.initial() => Settings(
        isConnectionEnabled: false,
      );
}
