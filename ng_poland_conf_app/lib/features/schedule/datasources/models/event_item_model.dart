import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/models/speaker_model.dart';

part 'event_item_model.freezed.dart';

@freezed
class EventItemModel with _$EventItemModel {
  const EventItemModel._();

  const factory EventItemModel({
    required String? title,
    required String? confId,
    required String? type,
    required String? category,
    required String? shortDescription,
    required String? description,
    required String? startDate,
    required String? endDate,
    required SpeakerModel? speaker,
  }) = _EventItemModel;

  factory EventItemModel.fromJson(Map<String, dynamic> json) {
    dynamic speaker;
    String photoFileUrl = '';
    if (json['fields']['presenter'] != null) {
      for (final dynamic asset in json['includes']['Entry']) {
        if (asset['sys']['id'] == json['fields']['presenter']['sys']['id']) {
          speaker = asset['fields'];
        }
      }

      for (final dynamic asset in json['includes']['Asset']) {
        if (asset['sys']['id'] == speaker['photo']['sys']['id']) {
          photoFileUrl = asset['fields']['file']['url'] as String;
        }
      }
    }

    return EventItemModel(
      title: json['fields']['title'],
      confId: json['fields']['confId'] as String,
      type: json['fields']['type'] ?? '',
      category: json['fields']['category'] ?? '',
      shortDescription: json['fields']['shortDescription'] ?? '',
      description: json['fields']['description'] ?? '',
      startDate: json['fields']['startDate'] ?? '',
      endDate: json['fields']['endDate'] ?? '',
      speaker: speaker == null
          ? null
          : SpeakerModel(
              id: speaker['id'] as String,
              name: speaker['name'] as String,
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
    );
  }

  EventItem toEntity() => EventItem(
        title: title ?? '',
        confId: confId,
        type: type,
        category: category,
        shortDescription: shortDescription,
        description: description,
        startDate: DateTime.tryParse(startDate ?? ''),
        endDate: DateTime.tryParse(endDate ?? ''),
        speaker: speaker?.toEntity(),
      );
}
