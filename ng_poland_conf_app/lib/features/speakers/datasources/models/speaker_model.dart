import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

part 'speaker_model.freezed.dart';
part 'speaker_model.g.dart';

@freezed
@HiveType(typeId: 8)
class SpeakerModel with _$SpeakerModel {
  const SpeakerModel._();

  const factory SpeakerModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required List<String> confIds,
    @HiveField(3) String? role,
    @HiveField(4) String? bio,
    @HiveField(5) String? photoFileUrl,
    @HiveField(6) String? photoTitle,
    @HiveField(7) String? photoDescription,
    @HiveField(8) String? email,
    @HiveField(9) String? urlGithub,
    @HiveField(10) String? urlLinkedIn,
    @HiveField(11) String? urlTwitter,
    @HiveField(12) String? urlWww,
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
      name: json['fields']['name'] ?? '',
      confIds: [],
      role: json['fields']['role'] ?? '',
      bio: json['fields']['bio'] ?? '',
      photoFileUrl: photoFileUrl ?? '',
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
      name: name ?? '',
      role: role ?? '',
      bio: bio ?? '',
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
