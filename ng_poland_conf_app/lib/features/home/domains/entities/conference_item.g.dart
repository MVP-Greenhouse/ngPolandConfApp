// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConferenceItemAdapter extends TypeAdapter<ConferenceItem> {
  @override
  final int typeId = 1;

  @override
  ConferenceItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConferenceItem(
      name: fields[0] as String,
      desc: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ConferenceItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.desc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConferenceItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
