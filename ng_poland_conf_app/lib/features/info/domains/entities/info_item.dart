import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_item.freezed.dart';

@freezed
class InfoItem with _$InfoItem {
  const factory InfoItem({
    required String title,
    required int order,
    required String icon,
    required String? description,
    required String confId,
    required String? urlLink,
  }) = _InfoItem;
}
