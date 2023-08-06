import 'package:freezed_annotation/freezed_annotation.dart';

part 'ngGirls.freezed.dart';

@freezed
class NgGirls with _$NgGirls {
  const NgGirls._();

  const factory NgGirls({
    required String myId,
    required String title,
    required String text,
  }) = _NgGirls;
}
