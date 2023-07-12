// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Conferences _$$_ConferencesFromJson(Map<String, dynamic> json) =>
    _$_Conferences(
      confId: json['confId'] as String,
      confName: json['confName'] as String,
      description: json['description'] as String,
      conferencesStartDate: json['conferencesStartDate'] as String?,
      listItems: _listItemsFromJson(
          json['conferenceHomePageSchedule'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$_ConferencesToJson(_$_Conferences instance) =>
    <String, dynamic>{
      'confId': instance.confId,
      'confName': instance.confName,
      'description': instance.description,
      'conferencesStartDate': instance.conferencesStartDate,
      'conferenceHomePageSchedule': instance.listItems,
    };
