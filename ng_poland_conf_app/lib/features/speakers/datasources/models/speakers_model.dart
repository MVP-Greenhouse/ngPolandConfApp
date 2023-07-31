import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/models/speaker_model.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

part 'speakers_model.freezed.dart';
part 'speakers_model.g.dart';

@freezed
class SpeakersModel with _$SpeakersModel {
  const SpeakersModel._();

  const factory SpeakersModel({
    required List<SpeakerModel>? items,
  }) = _SpeakersModel;

  factory SpeakersModel.fromJson(Map<String, dynamic> json) => _$SpeakersModelFromJson(json);

  List<Speaker> toEntity() =>
      items
          ?.map(
            (speakerModel) => speakerModel.toEntity(),
          )
          .toList() ??
      [];
}
