import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference_item.dart';

part 'conference.freezed.dart';

@freezed
abstract class Conference with _$Conference {
  const factory Conference({
    required String confId,
    required String confName,
    String? description,
    DateTime? startsAt,
    required List<ConferenceItem> listItems,
  }) = _Conference;
}
