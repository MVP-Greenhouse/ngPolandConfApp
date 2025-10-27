// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speakers_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpeakersModelAdapter extends TypeAdapter<SpeakersModel> {
  @override
  final typeId = 11;

  @override
  SpeakersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpeakersModel(
      items: (fields[0] as List?)?.cast<SpeakerModel>(),
      lastUpdate: fields[1] as DateTime?,
      confId: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, SpeakersModel obj) {
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
      other is SpeakersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
