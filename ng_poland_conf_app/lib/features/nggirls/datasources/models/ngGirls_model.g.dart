// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ngGirls_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NgGirlsModelAdapter extends TypeAdapter<NgGirlsModel> {
  @override
  final int typeId = 5;

  @override
  NgGirlsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NgGirlsModel(
      myId: fields[0] as String,
      title: fields[1] as String?,
      text: fields[2] as String?,
      confId: fields[3] as String,
      lastUpdate: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, NgGirlsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.myId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.confId)
      ..writeByte(4)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NgGirlsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NgGirlsModelImpl _$$NgGirlsModelImplFromJson(Map<String, dynamic> json) =>
    _$NgGirlsModelImpl(
      myId: json['myId'] as String,
      title: json['title'] as String?,
      text: json['text'] as String?,
      confId: json['confId'] as String,
      lastUpdate: json['lastUpdate'] == null
          ? null
          : DateTime.parse(json['lastUpdate'] as String),
    );

Map<String, dynamic> _$$NgGirlsModelImplToJson(_$NgGirlsModelImpl instance) =>
    <String, dynamic>{
      'myId': instance.myId,
      'title': instance.title,
      'text': instance.text,
      'confId': instance.confId,
      'lastUpdate': instance.lastUpdate?.toIso8601String(),
    };
