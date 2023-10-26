// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshop_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkshopModelAdapter extends TypeAdapter<WorkshopModel> {
  @override
  final int typeId = 9;

  @override
  WorkshopModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkshopModel(
      title: fields[0] as String,
      confId: fields[1] as String,
      description: fields[2] as String?,
      startDate: fields[3] as String,
      endDate: fields[4] as String,
      locationDescription: fields[5] as String?,
      speaker: fields[6] as SpeakerModel,
      pricePln: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkshopModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.confId)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.locationDescription)
      ..writeByte(6)
      ..write(obj.speaker)
      ..writeByte(7)
      ..write(obj.pricePln);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkshopModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
