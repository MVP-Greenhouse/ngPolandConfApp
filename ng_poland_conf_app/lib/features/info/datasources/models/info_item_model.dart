import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';

part 'info_item_model.freezed.dart';
part 'info_item_model.g.dart';

@freezed
@HiveType(typeId: 4)
class InfoItemModel with _$InfoItemModel {
  const InfoItemModel._();

  const factory InfoItemModel({
    @HiveField(0) required String title,
    @HiveField(1) required int order,
    @HiveField(2) required String icon,
    @HiveField(3) required String description,
    @HiveField(4) required String confId,
    @HiveField(5) required String urlLink,
  }) = _InfoItemModel;

  factory InfoItemModel.fromJson(Map<String, dynamic> json) => _$InfoItemModelFromJson(json['fields']);

  InfoItem toEntity() => InfoItem(
        title: title,
        order: order,
        icon: icon,
        description: description,
        confId: confId,
        urlLink: urlLink,
      );
}
