// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_items_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InfoItemsModelAdapter extends TypeAdapter<InfoItemsModel> {
  @override
  final typeId = 3;

  @override
  InfoItemsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InfoItemsModel(
      items: (fields[0] as List?)?.cast<InfoItemModel>(),
      lastUpdate: fields[1] as DateTime?,
      confId: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, InfoItemsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.items)
      ..writeByte(1)
      ..write(obj.lastUpdate)
      ..writeByte(2)
      ..write(obj.confId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoItemsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InfoItemsModel _$InfoItemsModelFromJson(Map<String, dynamic> json) =>
    _InfoItemsModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => InfoItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdate: json['lastUpdate'] == null
          ? null
          : DateTime.parse(json['lastUpdate'] as String),
      confId: json['confId'],
    );

Map<String, dynamic> _$InfoItemsModelToJson(_InfoItemsModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'lastUpdate': instance.lastUpdate?.toIso8601String(),
      'confId': instance.confId,
    };
