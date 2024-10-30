// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConferenceModelAdapter extends TypeAdapter<ConferenceModel> {
  @override
  final int typeId = 1;

  @override
  ConferenceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConferenceModel(
      confId: fields[0] as String,
      confName: fields[1] as String,
      description: fields[2] as String?,
      conferencesStartDate: fields[3] as String?,
      listItems:
          (fields[4] as List?)?.cast<ConferenceHomePageScheduleItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ConferenceModel obj) {
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
      other is ConferenceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConferenceModelImpl _$$ConferenceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ConferenceModelImpl(
      confId: json['confId'] as String,
      confName: json['confName'] as String,
      description: json['description'] as String?,
      conferencesStartDate: json['conferencesStartDate'] as String?,
      listItems: _listItemsFromJson(
          json['conferenceHomePageSchedule'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$ConferenceModelImplToJson(
        _$ConferenceModelImpl instance) =>
    <String, dynamic>{
      'confId': instance.confId,
      'confName': instance.confName,
      'description': instance.description,
      'conferencesStartDate': instance.conferencesStartDate,
      'conferenceHomePageSchedule': instance.listItems,
    };
