// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SpeakerModel _$$_SpeakerModelFromJson(Map<String, dynamic> json) =>
    _$_SpeakerModel(
      name: json['name'] as String,
      confIds:
          (json['confIds'] as List<dynamic>).map((e) => e as String).toList(),
      role: json['role'] as String,
      bio: json['bio'] as String,
      photoFileUrl: json['photoFileUrl'] as String?,
      photoTitle: json['photoTitle'] as String?,
      photoDescription: json['photoDescription'] as String?,
      email: json['email'] as String?,
      urlGithub: json['urlGithub'] as String?,
      urlLinkedIn: json['urlLinkedIn'] as String?,
      urlTwitter: json['urlTwitter'] as String?,
      urlWww: json['urlWww'] as String?,
    );

Map<String, dynamic> _$$_SpeakerModelToJson(_$_SpeakerModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'confIds': instance.confIds,
      'role': instance.role,
      'bio': instance.bio,
      'photoFileUrl': instance.photoFileUrl,
      'photoTitle': instance.photoTitle,
      'photoDescription': instance.photoDescription,
      'email': instance.email,
      'urlGithub': instance.urlGithub,
      'urlLinkedIn': instance.urlLinkedIn,
      'urlTwitter': instance.urlTwitter,
      'urlWww': instance.urlWww,
    };
