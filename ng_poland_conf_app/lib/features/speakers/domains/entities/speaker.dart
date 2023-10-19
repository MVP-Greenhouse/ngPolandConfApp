import 'package:freezed_annotation/freezed_annotation.dart';

part 'speaker.freezed.dart';
part 'speaker.g.dart';

@freezed
class Speaker with _$Speaker {
  const factory Speaker(
      {required String? name,
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

  factory Speaker.fromJson(Map<String, dynamic> json) => _$SpeakerFromJson(json);
}
