import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'info_item.freezed.dart';
part 'info_item.g.dart';

@freezed
@HiveType(typeId: 4)
class InfoItem with _$InfoItem {
  const factory InfoItem({
    @HiveField(0) required String title,
    @HiveField(1) required int order,
    @HiveField(2) required String icon,
    @HiveField(3) required String description,
    @HiveField(4) required String confId,
    @HiveField(5) required String urlLink,
  }) = _InfoItem;
}
