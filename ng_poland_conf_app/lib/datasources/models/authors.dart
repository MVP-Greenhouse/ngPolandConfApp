import 'package:freezed_annotation/freezed_annotation.dart';

part 'authors.freezed.dart';

@freezed
class Author with _$Author {
  const factory Author({
    String? name,
    String? image,
    String? twitterUrl,
  }) = _Author;
}
