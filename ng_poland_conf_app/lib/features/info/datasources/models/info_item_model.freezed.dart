// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InfoItemModel _$InfoItemModelFromJson(Map<String, dynamic> json) {
  return _InfoItemModel.fromJson(json);
}

/// @nodoc
mixin _$InfoItemModel {
  @HiveField(0)
  String get title => throw _privateConstructorUsedError;
  @HiveField(1)
  int get order => throw _privateConstructorUsedError;
  @HiveField(2)
  String get icon => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(4)
  String get confId => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get urlLink => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InfoItemModelCopyWith<InfoItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoItemModelCopyWith<$Res> {
  factory $InfoItemModelCopyWith(
          InfoItemModel value, $Res Function(InfoItemModel) then) =
      _$InfoItemModelCopyWithImpl<$Res, InfoItemModel>;
  @useResult
  $Res call(
      {@HiveField(0) String title,
      @HiveField(1) int order,
      @HiveField(2) String icon,
      @HiveField(3) String? description,
      @HiveField(4) String confId,
      @HiveField(5) String? urlLink});
}

/// @nodoc
class _$InfoItemModelCopyWithImpl<$Res, $Val extends InfoItemModel>
    implements $InfoItemModelCopyWith<$Res> {
  _$InfoItemModelCopyWithImpl(this._value, this._then);

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
    Object? description = freezed,
    Object? confId = null,
    Object? urlLink = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      urlLink: freezed == urlLink
          ? _value.urlLink
          : urlLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InfoItemModelCopyWith<$Res>
    implements $InfoItemModelCopyWith<$Res> {
  factory _$$_InfoItemModelCopyWith(
          _$_InfoItemModel value, $Res Function(_$_InfoItemModel) then) =
      __$$_InfoItemModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String title,
      @HiveField(1) int order,
      @HiveField(2) String icon,
      @HiveField(3) String? description,
      @HiveField(4) String confId,
      @HiveField(5) String? urlLink});
}

/// @nodoc
class __$$_InfoItemModelCopyWithImpl<$Res>
    extends _$InfoItemModelCopyWithImpl<$Res, _$_InfoItemModel>
    implements _$$_InfoItemModelCopyWith<$Res> {
  __$$_InfoItemModelCopyWithImpl(
      _$_InfoItemModel _value, $Res Function(_$_InfoItemModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? order = null,
    Object? icon = null,
    Object? description = freezed,
    Object? confId = null,
    Object? urlLink = freezed,
  }) {
    return _then(_$_InfoItemModel(
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      urlLink: freezed == urlLink
          ? _value.urlLink
          : urlLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InfoItemModel extends _InfoItemModel {
  const _$_InfoItemModel(
      {@HiveField(0) required this.title,
      @HiveField(1) required this.order,
      @HiveField(2) required this.icon,
      @HiveField(3) this.description,
      @HiveField(4) required this.confId,
      @HiveField(5) this.urlLink})
      : super._();

  factory _$_InfoItemModel.fromJson(Map<String, dynamic> json) =>
      _$$_InfoItemModelFromJson(json);

  @override
  @HiveField(0)
  final String title;
  @override
  @HiveField(1)
  final int order;
  @override
  @HiveField(2)
  final String icon;
  @override
  @HiveField(3)
  final String? description;
  @override
  @HiveField(4)
  final String confId;
  @override
  @HiveField(5)
  final String? urlLink;

  @override
  String toString() {
    return 'InfoItemModel(title: $title, order: $order, icon: $icon, description: $description, confId: $confId, urlLink: $urlLink)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InfoItemModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.urlLink, urlLink) || other.urlLink == urlLink));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, title, order, icon, description, confId, urlLink);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InfoItemModelCopyWith<_$_InfoItemModel> get copyWith =>
      __$$_InfoItemModelCopyWithImpl<_$_InfoItemModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InfoItemModelToJson(
      this,
    );
  }
}

abstract class _InfoItemModel extends InfoItemModel {
  const factory _InfoItemModel(
      {@HiveField(0) required final String title,
      @HiveField(1) required final int order,
      @HiveField(2) required final String icon,
      @HiveField(3) final String? description,
      @HiveField(4) required final String confId,
      @HiveField(5) final String? urlLink}) = _$_InfoItemModel;
  const _InfoItemModel._() : super._();

  factory _InfoItemModel.fromJson(Map<String, dynamic> json) =
      _$_InfoItemModel.fromJson;

  @override
  @HiveField(0)
  String get title;
  @override
  @HiveField(1)
  int get order;
  @override
  @HiveField(2)
  String get icon;
  @override
  @HiveField(3)
  String? get description;
  @override
  @HiveField(4)
  String get confId;
  @override
  @HiveField(5)
  String? get urlLink;
  @override
  @JsonKey(ignore: true)
  _$$_InfoItemModelCopyWith<_$_InfoItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}
