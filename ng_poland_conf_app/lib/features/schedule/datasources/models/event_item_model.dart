import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/models/speaker_model.dart';

part 'event_item_model.freezed.dart';
part 'event_item_model.g.dart';

@freezed
@HiveType(typeId: 7)
class EventItemModel with _$EventItemModel {
  const EventItemModel._();

  const factory EventItemModel({
    @HiveField(0) required String id,
    @HiveField(1) required String? title,
    @HiveField(2) required String? confId,
    @HiveField(3) required String? type,
    @HiveField(4) required String? category,
    @HiveField(5) required String? shortDescription,
    @HiveField(6) required String? description,
    @HiveField(7) required String? startDate,
    @HiveField(8) required String? endDate,
    @HiveField(9) required SpeakerModel? speaker,
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
      id: json['sys']['id'] as String,
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
              id: json['fields']['presenter']['sys']['id'] as String,
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
        id: id,
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
