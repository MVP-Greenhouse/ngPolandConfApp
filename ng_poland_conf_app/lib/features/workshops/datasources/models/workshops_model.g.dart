// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshops_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WorkshopsModel _$$_WorkshopsModelFromJson(Map<String, dynamic> json) =>
    _$_WorkshopsModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => WorkshopModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_WorkshopsModelToJson(_$_WorkshopsModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
