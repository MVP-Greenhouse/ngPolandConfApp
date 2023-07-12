import 'package:freezed_annotation/freezed_annotation.dart';

part 'contentful.freezed.dart';

part 'contentful.g.dart';

@freezed
class InfoItem with _$InfoItem {
  const factory InfoItem({
    required String title,
    required int order,
    required String icon,
    required String description,
    required String confId,
    required String urlLink,
  }) = _InfoItem;

  factory InfoItem.fromJson(Map<String, dynamic> json) => _$InfoItemFromJson(json);

  // Map<String, Object> toJson() {
  //   return {
  //     'title': title,
  //     'order': order,
  //     'icon': icon,
  //     'description': description,
  //     'confId': confId,
  //     'urlLink': urlLink,
  //   };
  // }
}

@freezed
class EventItem with _$EventItem {
  const factory EventItem({
    required String title,
    required String confId,
    required String type,
    required String category,
    required String shortDescription,
    required String description,
    required String startDate,
    required String endDate,
    required Speaker speaker,
  }) = _EventItem;

  factory EventItem.fromJson(Map<String, dynamic> json) => _$EventItemFromJson(json);

  // Map<String, Object> toJson() {
  //   return {
  //     'title': title,
  //     'confId': confId,
  //     'type': type,
  //     'category': category,
  //     'shortDescription': shortDescription,
  //     'description': description,
  //     'startDate': startDate,
  //     'endDate': endDate,
  //     'speaker': speaker,
  //   };
  // }
}

@freezed
class Speaker with _$Speaker {
  const factory Speaker({
    required String name,
    required String confIds,
    required String role,
    required String bio,
    required String photoFileUrl,
    required String photoTitle,
    required String photoDescription,
    required String email,
    required String urlGithub,
    required String urlLinkedIn,
    required String urlTwitter,
    required String urlWww,
  }) = _Speaker;

  factory Speaker.fromJson(Map<String, dynamic> json) => _$SpeakerFromJson(json);

  // Map<String, Object> toJson() {
  //   return {
  //     'name': name,
  //     'confIds': confIds,
  //     'role': role,
  //     'bio': bio,
  //     'photoFileUrl': photoFileUrl,
  //     'photoTitle': photoTitle,
  //     'photoDescription': photoDescription,
  //     'email': email,
  //     'urlGithub': urlGithub,
  //     'urlLinkedIn': urlLinkedIn,
  //     'urlTwitter': urlTwitter,
  //     'urlWww': urlWww,
  //   };
  // }
}

@freezed
class SimpleContent with _$SimpleContent {
  const factory SimpleContent({
    required String myId,
    required String title,
    required String text,
    required String confId,
  }) = _SimpleContent;

  factory SimpleContent.fromJson(Map<String, dynamic> json) => _$SimpleContentFromJson(json);

  // Map<String, Object> toJson() {
  //   return {
  //     'myId': myId,
  //     'title': title,
  //     'text': text,
  //     'confId': confId,
  //   };
  // }
}

@freezed
class Workshop with _$Workshop {
  const factory Workshop({
    required String title,
    required String confId,
    required String description,
    required Speaker speaker,
    required String startDate,
    required String endDate,
    required String locationDescription,
    required String pricePln,
  }) = _Workshop;

  factory Workshop.fromJson(Map<String, dynamic> json) => _$WorkshopFromJson(json);

  // Map<String, Object> toJson() {
  //   return {
  //     'title': title,
  //     'confId': confId,
  //     'description': description,
  //     'speaker': speaker,
  //     'startDate': startDate,
  //     'endDate': endDate,
  //     'locationDescription': locationDescription,
  //     'pricePln': pricePln,
  //   };
  // }
}
