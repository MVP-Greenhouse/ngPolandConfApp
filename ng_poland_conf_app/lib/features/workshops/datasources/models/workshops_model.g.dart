// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshops_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkshopsModelAdapter extends TypeAdapter<WorkshopsModel> {
  @override
  final typeId = 10;

  @override
  WorkshopsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkshopsModel(
      items: (fields[0] as List?)?.cast<WorkshopModel>(),
      lastUpdate: fields[1] as DateTime?,
      confId: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, WorkshopsModel obj) {
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
      other is WorkshopsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
