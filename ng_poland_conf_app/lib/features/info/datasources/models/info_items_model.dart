import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:ng_poland_conf_app/features/info/datasources/models/info_item_model.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';

part 'info_items_model.freezed.dart';
part 'info_items_model.g.dart';

@freezed
@HiveType(typeId: 3)
class InfoItemsModel with _$InfoItemsModel {
  const InfoItemsModel._();

  const factory InfoItemsModel({
    @HiveField(0) required List<InfoItemModel>? items,
  }) = _InfoItemsModel;

  factory InfoItemsModel.fromJson(Map<String, dynamic> json) => _$InfoItemsModelFromJson(json);

  List<InfoItem> toEntity() =>
      items
          ?.map(
            (infoItemModel) => infoItemModel.toEntity(),
          )
          .toList() ??
      [];
}
