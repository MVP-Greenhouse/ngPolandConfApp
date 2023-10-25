// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventsModelAdapter extends TypeAdapter<EventsModel> {
  @override
  final int typeId = 6;

  @override
  EventsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventsModel(
      items: (fields[0] as List?)?.cast<EventItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, EventsModel obj) {
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
      other is EventsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
