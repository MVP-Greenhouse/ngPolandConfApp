// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contentful.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InfoItem _$$_InfoItemFromJson(Map<String, dynamic> json) => _$_InfoItem(
      title: json['title'] as String,
      order: json['order'] as int,
      icon: json['icon'] as String,
      description: json['description'] as String,
      confId: json['confId'] as String,
      urlLink: json['urlLink'] as String,
    );

Map<String, dynamic> _$$_InfoItemToJson(_$_InfoItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'order': instance.order,
      'icon': instance.icon,
      'description': instance.description,
      'confId': instance.confId,
      'urlLink': instance.urlLink,
    };

_$_EventItem _$$_EventItemFromJson(Map<String, dynamic> json) => _$_EventItem(
      title: json['title'] as String,
      confId: json['confId'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      shortDescription: json['shortDescription'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      speaker: Speaker.fromJson(json['speaker'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EventItemToJson(_$_EventItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'confId': instance.confId,
      'type': instance.type,
      'category': instance.category,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'speaker': instance.speaker,
    };

_$_Speaker _$$_SpeakerFromJson(Map<String, dynamic> json) => _$_Speaker(
      name: json['name'] as String,
      confIds: json['confIds'] as String,
      role: json['role'] as String,
      bio: json['bio'] as String,
      photoFileUrl: json['photoFileUrl'] as String,
      photoTitle: json['photoTitle'] as String,
      photoDescription: json['photoDescription'] as String,
      email: json['email'] as String,
      urlGithub: json['urlGithub'] as String,
      urlLinkedIn: json['urlLinkedIn'] as String,
      urlTwitter: json['urlTwitter'] as String,
      urlWww: json['urlWww'] as String,
    );

Map<String, dynamic> _$$_SpeakerToJson(_$_Speaker instance) =>
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

_$_SimpleContent _$$_SimpleContentFromJson(Map<String, dynamic> json) =>
    _$_SimpleContent(
      myId: json['myId'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
      confId: json['confId'] as String,
    );

Map<String, dynamic> _$$_SimpleContentToJson(_$_SimpleContent instance) =>
    <String, dynamic>{
      'myId': instance.myId,
      'title': instance.title,
      'text': instance.text,
      'confId': instance.confId,
    };

_$_Workshop _$$_WorkshopFromJson(Map<String, dynamic> json) => _$_Workshop(
      title: json['title'] as String,
      confId: json['confId'] as String,
      description: json['description'] as String,
      speaker: Speaker.fromJson(json['speaker'] as Map<String, dynamic>),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      locationDescription: json['locationDescription'] as String,
      pricePln: json['pricePln'] as String,
    );

Map<String, dynamic> _$$_WorkshopToJson(_$_Workshop instance) =>
    <String, dynamic>{
      'title': instance.title,
      'confId': instance.confId,
      'description': instance.description,
      'speaker': instance.speaker,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'locationDescription': instance.locationDescription,
      'pricePln': instance.pricePln,
    };
