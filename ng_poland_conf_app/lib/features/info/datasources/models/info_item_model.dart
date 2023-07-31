import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';

part 'info_item_model.freezed.dart';
part 'info_item_model.g.dart';

@freezed
class InfoItemModel with _$InfoItemModel {
  const InfoItemModel._();

  const factory InfoItemModel({
    required String title,
    required int order,
    required String icon,
    required String description,
    required String confId,
    required String urlLink,
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
