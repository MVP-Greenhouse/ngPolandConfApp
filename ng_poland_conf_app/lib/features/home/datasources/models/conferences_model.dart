import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/home/datasources/models/conference_model.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';

part 'conferences_model.freezed.dart';

part 'conferences_model.g.dart';

@freezed
class ConferencesModel with _$ConferencesModel {
  const ConferencesModel._();

  const factory ConferencesModel({
    List<ConferenceModel?>? items,
  }) = _ConferencesModel;

  factory ConferencesModel.fromJson(Map<String, dynamic> json) => _$ConferencesModelFromJson(json);

  ConferenceModel? get getNewestConference => items?.first;

  Conferences toEntity() {
    List<ConferenceModel> items = [
      ...?this.items,
    ].whereType<ConferenceModel>().toList();

    items.sort((a, b) => b.confId.compareTo(a.confId));

    return Conferences(
      list: items
          .whereType<ConferenceModel>()
          .map(
            (conferenceModel) => conferenceModel.toEntity(),
          )
          .toList(),
    );
  }
}
