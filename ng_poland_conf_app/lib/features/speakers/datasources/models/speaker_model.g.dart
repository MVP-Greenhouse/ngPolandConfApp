// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpeakerModelAdapter extends TypeAdapter<SpeakerModel> {
  @override
  final int typeId = 8;

  @override
  SpeakerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpeakerModel(
      id: fields[0] as String,
      name: fields[1] as String,
      confIds: (fields[2] as List).cast<String>(),
      role: fields[3] as String?,
      bio: fields[4] as String?,
      photoFileUrl: fields[5] as String?,
      photoTitle: fields[6] as String?,
      photoDescription: fields[7] as String?,
      email: fields[8] as String?,
      urlGithub: fields[9] as String?,
      urlLinkedIn: fields[10] as String?,
      urlTwitter: fields[11] as String?,
      urlWww: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SpeakerModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.confIds)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.bio)
      ..writeByte(5)
      ..write(obj.photoFileUrl)
      ..writeByte(6)
      ..write(obj.photoTitle)
      ..writeByte(7)
      ..write(obj.photoDescription)
      ..writeByte(8)
      ..write(obj.email)
      ..writeByte(9)
      ..write(obj.urlGithub)
      ..writeByte(10)
      ..write(obj.urlLinkedIn)
      ..writeByte(11)
      ..write(obj.urlTwitter)
      ..writeByte(12)
      ..write(obj.urlWww);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeakerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
