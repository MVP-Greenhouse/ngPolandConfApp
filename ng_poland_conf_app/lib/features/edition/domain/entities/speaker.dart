import 'package:freezed_annotation/freezed_annotation.dart';

part 'speaker.freezed.dart';

@freezed
abstract class Speaker with _$Speaker {
  const factory Speaker({
    required String? id,
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
    required String? urlWww,
    @Default('') String conferenceKey,
    @Default('') String talkTitle,
  }) = _Speaker;
}
