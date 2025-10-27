import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';

part 'conferences.freezed.dart';

@freezed
abstract class Conferences with _$Conferences {
  factory Conferences({required List<Conference> list}) = _Conferences;
}
