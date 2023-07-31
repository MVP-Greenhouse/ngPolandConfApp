import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';

part 'ngGirls_model.freezed.dart';
part 'ngGirls_model.g.dart';

@freezed
class NgGirlsModel with _$NgGirlsModel {
  const NgGirlsModel._();

  const factory NgGirlsModel({
    required String myId,
    required String title,
    required String text,
    required String confId,
  }) = _NgGirlsModel;

  factory NgGirlsModel.fromJson(Map<String, dynamic> json) => _$NgGirlsModelFromJson(json['items'][0]['fields']);

  NgGirls toEntity() => NgGirls(
        myId: myId,
        title: title,
        text: text,
      );
}
