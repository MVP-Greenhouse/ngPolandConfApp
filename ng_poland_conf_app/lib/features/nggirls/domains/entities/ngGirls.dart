import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'ngGirls.freezed.dart';
part 'ngGirls.g.dart';

@freezed
@HiveType(typeId: 5)
class NgGirls with _$NgGirls {
  const factory NgGirls({
    @HiveField(0) required String myId,
    @HiveField(1) required String title,
    @HiveField(2) required String text,
  }) = _NgGirls;

  factory NgGirls.empty() => const NgGirls(
        myId: '',
        title: '',
        text: '',
      );
}
