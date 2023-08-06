// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConferenceModel _$$_ConferenceModelFromJson(Map<String, dynamic> json) =>
    _$_ConferenceModel(
      confId: json['confId'] as String,
      confName: json['confName'] as String,
      description: json['description'] as String,
      conferencesStartDate: json['conferencesStartDate'] as String?,
      listItems: _listItemsFromJson(
          json['conferenceHomePageSchedule'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$_ConferenceModelToJson(_$_ConferenceModel instance) =>
    <String, dynamic>{
      'confId': instance.confId,
      'confName': instance.confName,
      'description': instance.description,
      'conferencesStartDate': instance.conferencesStartDate,
      'conferenceHomePageSchedule': instance.listItems,
    };
