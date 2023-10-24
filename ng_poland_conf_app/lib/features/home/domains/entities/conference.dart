import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference_item.dart';

part 'conference.freezed.dart';
part 'conference.g.dart';

@freezed
@HiveType(typeId: 2)
class Conference with _$Conference {
  const factory Conference({
    @HiveField(0) required String confId,
    @HiveField(1) required String confName,
    @HiveField(2) required String description,
    @HiveField(3) String? conferencesStartDate,
    @HiveField(4) required List<ConferenceItem> listItems,
  }) = _Conference;
}
