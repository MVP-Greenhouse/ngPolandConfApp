// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_home_page_schedule_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConferenceHomePageScheduleItemModelAdapter
    extends TypeAdapter<ConferenceHomePageScheduleItemModel> {
  @override
  final typeId = 2;

  @override
  ConferenceHomePageScheduleItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConferenceHomePageScheduleItemModel(
      name: fields[0] as String,
      desc: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ConferenceHomePageScheduleItemModel obj) {
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
      other is ConferenceHomePageScheduleItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConferenceHomePageScheduleItemModel
_$ConferenceHomePageScheduleItemModelFromJson(Map<String, dynamic> json) =>
    _ConferenceHomePageScheduleItemModel(
      name: json['name'] as String,
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$ConferenceHomePageScheduleItemModelToJson(
  _ConferenceHomePageScheduleItemModel instance,
) => <String, dynamic>{'name': instance.name, 'desc': instance.desc};
