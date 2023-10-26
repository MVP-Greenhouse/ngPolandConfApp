import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:ng_poland_conf_app/features/schedule/datasources/models/event_item_model.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/models/speaker_model.dart';

part 'events_model.freezed.dart';
part 'events_model.g.dart';

@freezed
@HiveType(typeId: 6)
class EventsModel with _$EventsModel {
  const EventsModel._();

  const factory EventsModel({@HiveField(0) required List<EventItemModel>? items, @HiveField(1) DateTime? lastUpdate, @HiveField(2) confId}) = _EventsModel;

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    final List<EventItemModel> eventItems = [];
    for (final dynamic item in json['items']) {
      dynamic speaker;

      String photoFileUrl = '';
      if (item['fields']['presenter'] != null) {
        for (final dynamic asset in json['includes']['Entry']) {
          if (asset['sys']['id'] == item['fields']['presenter']['sys']['id']) {
            speaker = asset['fields'];
          }
        }

        for (final dynamic asset in json['includes']['Asset']) {
          if (asset['sys']['id'] == speaker['photo']['sys']['id']) {
            photoFileUrl = asset['fields']['file']['url'] as String;
          }
        }
      }

      eventItems.add(
        EventItemModel(
          id: item['sys']['id'] as String,
          title: item['fields']['title'],
          confId: item['fields']['confId'] as String,
          type: item['fields']['type'] as String,
          category: item['fields']['category'] ?? '',
          shortDescription: item['fields']['shortDescription'] ?? '',
          description: item['fields']['description'] ?? '',
          startDate: item['fields']['startDate'] ?? '',
          endDate: item['fields']['endDate'] ?? '',
          speaker: speaker == null
              ? null
              : SpeakerModel(
                  id: item['fields']['presenter']['sys']['id'] ?? '',
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
        ),
      );
    }

    return EventsModel(
      items: eventItems,
      lastUpdate: DateTime.now(),
    );
  }

  List<EventItem> toEntity() =>
      items
          ?.map(
            (eventItem) => eventItem.toEntity(),
          )
          .toList() ??
      [];
}
