import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference_item.dart';

part 'conference.freezed.dart';

@freezed
class Conference with _$Conference {
  const factory Conference({
    required String confId,
    required String confName,
    @Default(false) bool isCurrent,
    String? description,
    String? conferencesStartDate,
    required List<ConferenceItem> listItems,
  }) = _Conference;
}
