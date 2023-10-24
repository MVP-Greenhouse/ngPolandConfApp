// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conferences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConferencesAdapter extends TypeAdapter<Conferences> {
  @override
  final int typeId = 3;

  @override
  Conferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Conferences(
      list: (fields[0] as List).cast<Conference>(),
    );
  }

  @override
  void write(BinaryWriter writer, Conferences obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
