// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WorkshopModel _$$_WorkshopModelFromJson(Map<String, dynamic> json) =>
    _$_WorkshopModel(
      title: json['title'] as String,
      confId: json['confId'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      locationDescription: json['locationDescription'] as String,
      pricePln: json['pricePln'] as int?,
    );

Map<String, dynamic> _$$_WorkshopModelToJson(_$_WorkshopModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'confId': instance.confId,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'locationDescription': instance.locationDescription,
      'pricePln': instance.pricePln,
    };
