// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_items_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InfoItemsModelAdapter extends TypeAdapter<InfoItemsModel> {
  @override
  final int typeId = 3;

  @override
  InfoItemsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InfoItemsModel(
      items: (fields[0] as List?)?.cast<InfoItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, InfoItemsModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.items);
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
