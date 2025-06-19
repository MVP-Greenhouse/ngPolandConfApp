// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InfoItemModelAdapter extends TypeAdapter<InfoItemModel> {
  @override
  final int typeId = 4;

  @override
  InfoItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InfoItemModel(
      title: fields[0] as String,
      order: fields[1] as int,
      icon: fields[2] as String,
      description: fields[3] as String?,
      confId: fields[4] as String,
      urlLink: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InfoItemModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.order)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.confId)
      ..writeByte(5)
      ..write(obj.urlLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InfoItemModelImpl _$$InfoItemModelImplFromJson(Map<String, dynamic> json) =>
    _$InfoItemModelImpl(
      title: json['title'] as String,
      order: (json['order'] as num).toInt(),
      icon: json['icon'] as String,
      description: json['description'] as String?,
      confId: json['confId'] as String,
      urlLink: json['urlLink'] as String?,
    );

Map<String, dynamic> _$$InfoItemModelImplToJson(_$InfoItemModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'order': instance.order,
      'icon': instance.icon,
      'description': instance.description,
      'confId': instance.confId,
      'urlLink': instance.urlLink,
    };
