import 'package:freezed_annotation/freezed_annotation.dart';

part 'speaker.freezed.dart';

@freezed
class Speaker with _$Speaker {
  const factory Speaker(
      {required String? id,
      required String? name,
      required String? role,
      required String? bio,
      required String? photoFileUrl,
      required String? photoTitle,
      required String? photoDescription,
      required String? email,
      required String? urlGithub,
      required String? urlLinkedIn,
      required String? urlTwitter,
      required String? urlWww}) = _Speaker;

  factory Speaker.fromJson(Map<String, dynamic> json) {
    String photoFileUrl = '';
    for (final dynamic asset in json['includes']['Asset']) {
      if (asset['sys']['id'] == json['fields']['photo']['sys']['id']) {
        photoFileUrl = asset['fields']['file']['url'] as String;
      }
    }

    return Speaker(
      id: json['sys']['id'] as String,
      name: json['fields']['name'] as String,
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
  }

  static const empty =
      Speaker(id: '', name: '', role: '', bio: '', photoFileUrl: '', photoTitle: '', photoDescription: '', email: '', urlGithub: '', urlLinkedIn: '', urlTwitter: '', urlWww: '');
}
