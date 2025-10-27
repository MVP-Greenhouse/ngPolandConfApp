// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conferences_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConferencesModelAdapter extends TypeAdapter<ConferencesModel> {
  @override
  final typeId = 0;

  @override
  ConferencesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConferencesModel(
      items: (fields[0] as List?)?.cast<ConferenceModel?>(),
    );
  }

  @override
  void write(BinaryWriter writer, ConferencesModel obj) {
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
      other is ConferencesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConferencesModel _$ConferencesModelFromJson(Map<String, dynamic> json) =>
    _ConferencesModel(
      items: (json['items'] as List<dynamic>?)
          ?.map(
            (e) => e == null
                ? null
                : ConferenceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$ConferencesModelToJson(_ConferencesModel instance) =>
    <String, dynamic>{'items': instance.items};
