import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';

part 'conferences.freezed.dart';
part 'conferences.g.dart';

@freezed
@HiveType(typeId: 3)
class Conferences with _$Conferences {
  factory Conferences({
    @HiveField(0) required List<Conference> list,
  }) = _Conferences;

  factory Conferences.initial() => Conferences(
        list: [],
      );
}
