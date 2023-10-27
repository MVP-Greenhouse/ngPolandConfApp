import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/entities/workshop.dart';

import '../../../speakers/datasources/models/speaker_model.dart';

part 'workshop_model.freezed.dart';
part 'workshop_model.g.dart';

@freezed
@HiveType(typeId: 9)
class WorkshopModel with _$WorkshopModel {
  const WorkshopModel._();

  const factory WorkshopModel({
    @HiveField(0) required String title,
    @HiveField(1) required String confId,
    @HiveField(2) required String? description,
    @HiveField(3) required String startDate,
    @HiveField(4) required String endDate,
    @HiveField(5) required String? locationDescription,
    @HiveField(6) required SpeakerModel speaker,
    @HiveField(7) required int? pricePln,
  }) = _WorkshopModel;

  factory WorkshopModel.fromJson(Map<String, dynamic> json) {
    dynamic speaker;

    String photoFileUrl = '';

    for (final dynamic asset in json['includes']['Entry']) {
      if (asset['sys']['id'] == json['fields']['instructor']['sys']['id']) {
        speaker = asset['fields'];
      }
    }

    for (final dynamic asset in json['includes']['Asset']) {
      if (asset['sys']['id'] == speaker['photo']['sys']['id']) {
        photoFileUrl = asset['fields']['file']['url'] as String;
      }
    }

    return WorkshopModel(
      title: json['fields']['title'] as String,
      confId: json['fields']['confId'] as String,
      description: json['fields']['description'] as String,
      speaker: SpeakerModel(
        id: json['fields']['instructor']['sys']['id'] as String,
        name: speaker['name'] as String,
        confIds: [],
        role: speaker['role'] as String,
        bio: speaker['bio'] as String,
        photoFileUrl: photoFileUrl,
        photoTitle: speaker['photoTitle'] ?? '',
        photoDescription: speaker['photoDescription'] ?? '',
        email: speaker['email'] ?? '',
        urlGithub: speaker['urlGithub'] ?? '',
        urlLinkedIn: speaker['urlLinkedIn'] ?? '',
        urlTwitter: speaker['urlTwitter'] ?? '',
        urlWww: speaker['urlWww'] ?? '',
      ),
      startDate: json['fields']['startDate'] ?? '',
      endDate: json['fields']['endDate'] ?? '',
      locationDescription: json['fields']['locationDescription'] ?? '',
      pricePln: json['fields']['pricePln'].toInt(),
    );
  }

  Workshop toEntity() => Workshop(
        title: title,
        confId: confId,
        description: description ?? '',
        startDate: startDate,
        endDate: endDate,
        locationDescription: locationDescription ?? '',
        pricePln: pricePln,
        speaker: speaker.toEntity(),
      );
}
