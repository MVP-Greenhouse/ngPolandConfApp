// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InfoItemsModel _$$_InfoItemsModelFromJson(Map<String, dynamic> json) =>
    _$_InfoItemsModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => InfoItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_InfoItemsModelToJson(_$_InfoItemsModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
