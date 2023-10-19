import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/models/speaker_model.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

part 'speakers_model.freezed.dart';

@freezed
class SpeakersModel with _$SpeakersModel {
  const SpeakersModel._();

  const factory SpeakersModel({
    required List<SpeakerModel>? items,
  }) = _SpeakersModel;

  factory SpeakersModel.fromJson(Map<String, dynamic> json) {
    final List<SpeakerModel> speakers = [];
    for (final dynamic item in json['items']) {
      String photoFileUrl = '';
      for (final dynamic asset in json['includes']['Asset']) {
        if (asset['sys']['id'] == item['fields']['photo']['sys']['id']) {
          photoFileUrl = asset['fields']['file']['url'] as String;
        }
      }

      speakers.add(
        SpeakerModel(
          name: item['fields']['name'] as String,
          confIds: [], // item['fields']['confIds'] as List<String>,
          role: item['fields']['role'] as String,
          bio: item['fields']['bio'] as String,
          photoFileUrl: photoFileUrl,
          photoTitle: item['fields']['photoTitle'] ?? '',
          photoDescription: item['fields']['photoDescription'] ?? '',
          email: item['fields']['email'] ?? '',
          urlGithub: item['fields']['urlGithub'] ?? '',
          urlLinkedIn: item['fields']['urlLinkedIn'] ?? '',
          urlTwitter: item['fields']['urlTwitter'] ?? '',
          urlWww: item['fields']['urlWww'] ?? '',
        ),
      );
    }

    return SpeakersModel(
      items: speakers,
    );

    // return _$SpeakersModelFromJson(json);
  }

  List<Speaker> toEntity() =>
      items
          ?.map(
            (speakerModel) => speakerModel.toEntity(),
          )
          .toList() ??
      [];
}
