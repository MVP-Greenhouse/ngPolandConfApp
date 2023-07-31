// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InfoItemModel _$$_InfoItemModelFromJson(Map<String, dynamic> json) =>
    _$_InfoItemModel(
      title: json['title'] as String,
      order: json['order'] as int,
      icon: json['icon'] as String,
      description: json['description'] as String,
      confId: json['confId'] as String,
      urlLink: json['urlLink'] as String,
    );

Map<String, dynamic> _$$_InfoItemModelToJson(_$_InfoItemModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'order': instance.order,
      'icon': instance.icon,
      'description': instance.description,
      'confId': instance.confId,
      'urlLink': instance.urlLink,
    };
