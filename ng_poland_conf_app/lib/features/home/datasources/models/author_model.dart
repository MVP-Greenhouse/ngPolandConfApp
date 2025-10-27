import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_model.freezed.dart';

@freezed
abstract class AuthorModel with _$AuthorModel {
  const factory AuthorModel({String? name, String? image, String? twitterUrl}) =
      _AuthorModel;
}
