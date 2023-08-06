// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InfoItem {
  String get title => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get confId => throw _privateConstructorUsedError;
  String get urlLink => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InfoItemCopyWith<InfoItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoItemCopyWith<$Res> {
  factory $InfoItemCopyWith(InfoItem value, $Res Function(InfoItem) then) =
      _$InfoItemCopyWithImpl<$Res, InfoItem>;
  @useResult
  $Res call(
      {String title,
      int order,
      String icon,
      String description,
      String confId,
      String urlLink});
}

/// @nodoc
class _$InfoItemCopyWithImpl<$Res, $Val extends InfoItem>
    implements $InfoItemCopyWith<$Res> {
  _$InfoItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? order = null,
    Object? icon = null,
    Object? description = null,
    Object? confId = null,
    Object? urlLink = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      urlLink: null == urlLink
          ? _value.urlLink
          : urlLink // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InfoItemCopyWith<$Res> implements $InfoItemCopyWith<$Res> {
  factory _$$_InfoItemCopyWith(
          _$_InfoItem value, $Res Function(_$_InfoItem) then) =
      __$$_InfoItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      int order,
      String icon,
      String description,
      String confId,
      String urlLink});
}

/// @nodoc
class __$$_InfoItemCopyWithImpl<$Res>
    extends _$InfoItemCopyWithImpl<$Res, _$_InfoItem>
    implements _$$_InfoItemCopyWith<$Res> {
  __$$_InfoItemCopyWithImpl(
      _$_InfoItem _value, $Res Function(_$_InfoItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? order = null,
    Object? icon = null,
    Object? description = null,
    Object? confId = null,
    Object? urlLink = null,
  }) {
    return _then(_$_InfoItem(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      urlLink: null == urlLink
          ? _value.urlLink
          : urlLink // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_InfoItem implements _InfoItem {
  const _$_InfoItem(
      {required this.title,
      required this.order,
      required this.icon,
      required this.description,
      required this.confId,
      required this.urlLink});

  @override
  final String title;
  @override
  final int order;
  @override
  final String icon;
  @override
  final String description;
  @override
  final String confId;
  @override
  final String urlLink;

  @override
  String toString() {
    return 'InfoItem(title: $title, order: $order, icon: $icon, description: $description, confId: $confId, urlLink: $urlLink)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InfoItem &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.urlLink, urlLink) || other.urlLink == urlLink));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, order, icon, description, confId, urlLink);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InfoItemCopyWith<_$_InfoItem> get copyWith =>
      __$$_InfoItemCopyWithImpl<_$_InfoItem>(this, _$identity);
}

abstract class _InfoItem implements InfoItem {
  const factory _InfoItem(
      {required final String title,
      required final int order,
      required final String icon,
      required final String description,
      required final String confId,
      required final String urlLink}) = _$_InfoItem;

  @override
  String get title;
  @override
  int get order;
  @override
  String get icon;
  @override
  String get description;
  @override
  String get confId;
  @override
  String get urlLink;
  @override
  @JsonKey(ignore: true)
  _$$_InfoItemCopyWith<_$_InfoItem> get copyWith =>
      throw _privateConstructorUsedError;
}
