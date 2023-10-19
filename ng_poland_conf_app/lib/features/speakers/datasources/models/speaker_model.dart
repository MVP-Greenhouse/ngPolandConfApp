import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

part 'speaker_model.freezed.dart';
part 'speaker_model.g.dart';

@freezed
class SpeakerModel with _$SpeakerModel {
  const SpeakerModel._();

  const factory SpeakerModel({
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
    print('`**************************');
    print(json['includes']);
    return _$SpeakerModelFromJson(json['fields']);
  }

  Speaker toEntity() {
    return Speaker(
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
