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
      title: fields[1] as String,
      text: fields[2] as String,
      confId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NgGirlsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.myId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.confId);
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

_$_NgGirlsModel _$$_NgGirlsModelFromJson(Map<String, dynamic> json) =>
    _$_NgGirlsModel(
      myId: json['myId'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
      confId: json['confId'] as String,
    );

Map<String, dynamic> _$$_NgGirlsModelToJson(_$_NgGirlsModel instance) =>
    <String, dynamic>{
      'myId': instance.myId,
      'title': instance.title,
      'text': instance.text,
      'confId': instance.confId,
    };
