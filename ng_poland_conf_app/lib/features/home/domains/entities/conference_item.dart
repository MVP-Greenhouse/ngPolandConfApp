import 'package:freezed_annotation/freezed_annotation.dart';

part 'conference_item.freezed.dart';

@freezed
abstract class ConferenceItem with _$ConferenceItem {
  const factory ConferenceItem({required String name, required String desc}) =
      _ConferenceItem;
}
