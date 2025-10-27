// ignore_for_file: file_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';

part 'ngGirls_model.freezed.dart';
part 'ngGirls_model.g.dart';

@freezed
@HiveType(typeId: 5)
abstract class NgGirlsModel with _$NgGirlsModel {
  const NgGirlsModel._();

  const factory NgGirlsModel({
    @HiveField(0) required String myId,
    @HiveField(1) required String? title,
    @HiveField(2) required String? text,
    @HiveField(3) required String confId,
    @HiveField(4) DateTime? lastUpdate,
  }) = _NgGirlsModel;

  factory NgGirlsModel.fromJson(Map<String, dynamic> json) =>
      _$NgGirlsModelFromJson(json['items'][0]['fields']);

  NgGirls toEntity() =>
      NgGirls(myId: myId, title: title ?? '', text: text ?? '');
}
