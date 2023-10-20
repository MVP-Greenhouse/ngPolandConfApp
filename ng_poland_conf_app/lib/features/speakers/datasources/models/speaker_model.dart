import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

part 'speaker_model.freezed.dart';

@freezed
class SpeakerModel with _$SpeakerModel {
  const SpeakerModel._();

  const factory SpeakerModel({
    required String id,
    required String name,
    required List<String> confIds,
    required String role,
    required String bio,
    required String? photoFileUrl,
    required String? photoTitle,
    required String? photoDescription,
    required String? email,
    required String? urlGithub,
    required String? urlLinkedIn,
    required String? urlTwitter,
    required String? urlWww,
  }) = _SpeakerModel;

  factory SpeakerModel.fromJson(Map<String, dynamic> json) {
    String photoFileUrl = '';
    for (final dynamic asset in json['includes']['Asset']) {
      if (asset['sys']['id'] == json['fields']['photo']['sys']['id']) {
        photoFileUrl = asset['fields']['file']['url'] as String;
      }
    }

    return SpeakerModel(
      id: json['sys']['id'] as String,
      name: json['fields']['name'] as String,
      confIds: json['fields']['confIds'],
      role: json['fields']['role'] as String,
      bio: json['fields']['bio'] as String,
      photoFileUrl: photoFileUrl,
      photoTitle: json['fields']['photoTitle'] ?? '',
      photoDescription: json['fields']['photoDescription'] ?? '',
      email: json['fields']['email'] ?? '',
      urlGithub: json['fields']['urlGithub'] ?? '',
      urlLinkedIn: json['fields']['urlLinkedIn'] ?? '',
      urlTwitter: json['fields']['urlTwitter'] ?? '',
      urlWww: json['fields']['urlWww'] ?? '',
    );
    //  return _$SpeakerModelFromJson(json['fields']);
  }

  Speaker toEntity() {
    return Speaker(
      id: id,
      name: name,
      role: role,
      bio: bio,
      photoFileUrl: photoFileUrl ?? '',
      photoTitle: photoTitle ?? '',
      photoDescription: photoDescription ?? '',
      email: email ?? '',
      urlGithub: urlGithub ?? '',
      urlLinkedIn: urlLinkedIn ?? '',
      urlTwitter: urlTwitter ?? '',
      urlWww: urlWww ?? '',
    );
  }
}
