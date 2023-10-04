// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventItemModel _$$_EventItemModelFromJson(Map<String, dynamic> json) =>
    _$_EventItemModel(
      title: json['title'] as String?,
      confId: json['confId'] as String?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      shortDescription: json['shortDescription'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      speaker: json['speaker'] == null
          ? null
          : Speaker.fromJson(json['speaker'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EventItemModelToJson(_$_EventItemModel instance) =>
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
