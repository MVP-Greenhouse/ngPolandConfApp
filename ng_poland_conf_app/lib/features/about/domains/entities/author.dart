import 'package:freezed_annotation/freezed_annotation.dart';

part 'author.freezed.dart';

@freezed
class Author with _$Author {
  const factory Author({
    required String name,
    required String image,
    required String linkedinUrl,
  }) = _Author;
}
