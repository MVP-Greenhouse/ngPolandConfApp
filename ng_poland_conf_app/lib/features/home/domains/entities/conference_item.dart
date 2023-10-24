import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'conference_item.freezed.dart';
part 'conference_item.g.dart';

@freezed
@HiveType(typeId: 1)
class ConferenceItem with _$ConferenceItem {
  const factory ConferenceItem({
    @HiveField(0) required String name,
    @HiveField(1) required String desc,
  }) = _ConferenceItem;
}
