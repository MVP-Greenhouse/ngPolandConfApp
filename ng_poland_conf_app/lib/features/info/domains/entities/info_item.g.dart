// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InfoItemAdapter extends TypeAdapter<InfoItem> {
  @override
  final int typeId = 4;

  @override
  InfoItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InfoItem(
      title: fields[0] as String,
      order: fields[1] as int,
      icon: fields[2] as String,
      description: fields[3] as String,
      confId: fields[4] as String,
      urlLink: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InfoItem obj) {
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
      other is InfoItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
