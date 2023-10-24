// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConferenceAdapter extends TypeAdapter<Conference> {
  @override
  final int typeId = 2;

  @override
  Conference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Conference(
      confId: fields[0] as String,
      confName: fields[1] as String,
      description: fields[2] as String,
      conferencesStartDate: fields[3] as String?,
      listItems: (fields[4] as List).cast<ConferenceItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, Conference obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.confId)
      ..writeByte(1)
      ..write(obj.confName)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.conferencesStartDate)
      ..writeByte(4)
      ..write(obj.listItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
