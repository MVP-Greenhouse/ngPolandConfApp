// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ngGirls.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NgGirlsAdapter extends TypeAdapter<NgGirls> {
  @override
  final int typeId = 5;

  @override
  NgGirls read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NgGirls(
      myId: fields[0] as String,
      title: fields[1] as String,
      text: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NgGirls obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.myId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NgGirlsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
