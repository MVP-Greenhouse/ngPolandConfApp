import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

part 'workshop.freezed.dart';

@freezed
abstract class Workshop with _$Workshop {
  const Workshop._();

  const factory Workshop({
    required String title,
    required String confId,
    required String? description,
    required String startDate,
    required String endDate,
    required String? locationDescription,
    required Speaker speaker,
    required int? pricePln,
  }) = _Workshop;
}
