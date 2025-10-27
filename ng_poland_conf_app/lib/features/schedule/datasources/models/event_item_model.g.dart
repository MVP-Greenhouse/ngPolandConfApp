// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventItemModelAdapter extends TypeAdapter<EventItemModel> {
  @override
  final typeId = 7;

  @override
  EventItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventItemModel(
      id: fields[0] as String,
      title: fields[1] as String,
      confId: fields[2] as String,
      type: fields[3] as String,
      category: fields[4] as String,
      shortDescription: fields[5] as String?,
      description: fields[6] as String?,
      startDate: fields[7] as String,
      endDate: fields[8] as String,
      speaker: fields[9] as SpeakerModel?,
    );
  }

  @override
  void write(BinaryWriter writer, EventItemModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.confId)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.shortDescription)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.startDate)
      ..writeByte(8)
      ..write(obj.endDate)
      ..writeByte(9)
      ..write(obj.speaker);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
