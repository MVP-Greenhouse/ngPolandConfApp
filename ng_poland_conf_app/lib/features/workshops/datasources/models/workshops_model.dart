import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/workshops/datasources/models/workshop_model.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/entities/workshop.dart';

import '../../../speakers/datasources/models/speaker_model.dart';

part 'workshops_model.freezed.dart';

@freezed
class WorkshopsModel with _$WorkshopsModel {
  const WorkshopsModel._();

  const factory WorkshopsModel({
    required List<WorkshopModel>? items,
  }) = _WorkshopsModel;

  factory WorkshopsModel.fromJson(Map<String, dynamic> json) {
    final List<WorkshopModel> workshops = [];
    for (final dynamic item in json['items']) {
      dynamic speaker;

      String photoFileUrl = '';

      for (final dynamic asset in json['includes']['Entry']) {
        if (asset['sys']['id'] == item['fields']['instructor']['sys']['id']) {
          speaker = asset['fields'];
        }
      }

      for (final dynamic asset in json['includes']['Asset']) {
        if (asset['sys']['id'] == speaker['photo']['sys']['id']) {
          photoFileUrl = asset['fields']['file']['url'] as String;
        }
      }

      workshops.add(
        WorkshopModel(
          title: item['fields']['title'] as String,
          confId: item['fields']['confId'] as String,
          description: item['fields']['description'] as String,
          speaker: SpeakerModel(
            id: speaker['id'] ?? '',
            name: speaker['name'] ?? '',
            confIds: [],
            role: speaker['role'] ?? '',
            bio: speaker['bio'] ?? '',
            photoFileUrl: photoFileUrl,
            photoTitle: speaker['photoTitle'] ?? '',
            photoDescription: speaker['photoDescription'] ?? '',
            email: speaker['email'] ?? '',
            urlGithub: speaker['urlGithub'] ?? '',
            urlLinkedIn: speaker['urlLinkedIn'] ?? '',
            urlTwitter: speaker['urlTwitter'] ?? '',
            urlWww: speaker['urlWww'] ?? '',
          ),
          startDate: item['fields']['startDate'] ?? '',
          endDate: item['fields']['endDate'] ?? '',
          locationDescription: item['fields']['locationDescription'] ?? '',
          pricePln: item['fields']['pricePln'].toInt(),
        ),
      );
    }

    return WorkshopsModel(
      items: workshops,
    );
  }

  List<Workshop> toEntity() =>
      items
          ?.map(
            (workshopModel) => workshopModel.toEntity(),
          )
          .toList() ??
      [];
}
