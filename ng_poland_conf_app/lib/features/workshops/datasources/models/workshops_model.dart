import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/workshops/datasources/models/workshop_model.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/entities/workshop.dart';

part 'workshops_model.freezed.dart';
part 'workshops_model.g.dart';

@freezed
class WorkshopsModel with _$WorkshopsModel {
  const WorkshopsModel._();

  const factory WorkshopsModel({
    required List<WorkshopModel>? items,
  }) = _WorkshopsModel;

  factory WorkshopsModel.fromJson(Map<String, dynamic> json) => _$WorkshopsModelFromJson(json);

  List<Workshop> toEntity() =>
      items
          ?.map(
            (workshopModel) => workshopModel.toEntity(),
          )
          .toList() ??
      [];
}
