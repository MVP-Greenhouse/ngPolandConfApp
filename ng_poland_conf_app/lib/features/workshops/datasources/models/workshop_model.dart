import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/entities/workshop.dart';

part 'workshop_model.freezed.dart';
part 'workshop_model.g.dart';

@freezed
class WorkshopModel with _$WorkshopModel {
  const WorkshopModel._();

  const factory WorkshopModel({
    required String title,
    required String confId,
    required String description,
    required String startDate,
    required String endDate,
    required String locationDescription,
    required int? pricePln,
  }) = _WorkshopModel;

  factory WorkshopModel.fromJson(Map<String, dynamic> json) => _$WorkshopModelFromJson(json['fields']);

  WorkShop toEntity() => WorkShop(
        title: title,
        confId: confId,
        description: description,
        startDate: startDate,
        endDate: endDate,
        locationDescription: locationDescription,
        pricePln: pricePln,
      );
}
