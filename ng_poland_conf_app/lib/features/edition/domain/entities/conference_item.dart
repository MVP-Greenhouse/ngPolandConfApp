import 'package:freezed_annotation/freezed_annotation.dart';

part 'conference_item.freezed.dart';

/// One agenda day of a conference, as listed on the home screen.
@freezed
abstract class ConferenceItem with _$ConferenceItem {
  const factory ConferenceItem({
    /// Agenda day key (`ng`, `js`, `ai`, `workshops`, ...).
    @Default('') String key,
    required String name,
    required String desc,
  }) = _ConferenceItem;
}
