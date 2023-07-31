// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConferencesModel _$$_ConferencesModelFromJson(Map<String, dynamic> json) =>
    _$_ConferencesModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ConferenceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ConferencesModelToJson(_$_ConferencesModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
