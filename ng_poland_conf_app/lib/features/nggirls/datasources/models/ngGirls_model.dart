import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';

part 'ngGirls_model.freezed.dart';
part 'ngGirls_model.g.dart';

@freezed
@HiveType(typeId: 5)
class NgGirlsModel with _$NgGirlsModel {
  const NgGirlsModel._();

  const factory NgGirlsModel({
    @HiveField(0) required String myId,
    @HiveField(1) required String title,
    @HiveField(2) required String text,
    @HiveField(3) required String confId,
  }) = _NgGirlsModel;

  factory NgGirlsModel.fromJson(Map<String, dynamic> json) => _$NgGirlsModelFromJson(json['items'][0]['fields']);

  NgGirls toEntity() => NgGirls(
        myId: myId,
        title: title,
        text: text,
      );
}
