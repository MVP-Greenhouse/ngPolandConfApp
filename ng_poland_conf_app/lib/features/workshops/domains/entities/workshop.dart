import 'package:freezed_annotation/freezed_annotation.dart';

part 'workshop.freezed.dart';

@freezed
class WorkShop with _$WorkShop {
  const WorkShop._();

  const factory WorkShop({
    required String title,
    required String confId,
    required String description,
    required String startDate,
    required String endDate,
    required String locationDescription,
    required int? pricePln,
  }) = _WorkShop;
}
