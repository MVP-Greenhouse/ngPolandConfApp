// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speakers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SpeakersModel _$$_SpeakersModelFromJson(Map<String, dynamic> json) =>
    _$_SpeakersModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SpeakerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SpeakersModelToJson(_$_SpeakersModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
