// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workshop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WorkShop {
  String get title => throw _privateConstructorUsedError;
  String get confId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  String get locationDescription => throw _privateConstructorUsedError;
  int? get pricePln => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WorkShopCopyWith<WorkShop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkShopCopyWith<$Res> {
  factory $WorkShopCopyWith(WorkShop value, $Res Function(WorkShop) then) =
      _$WorkShopCopyWithImpl<$Res, WorkShop>;
  @useResult
  $Res call(
      {String title,
      String confId,
      String description,
      String startDate,
      String endDate,
      String locationDescription,
      int? pricePln});
}

/// @nodoc
class _$WorkShopCopyWithImpl<$Res, $Val extends WorkShop>
    implements $WorkShopCopyWith<$Res> {
  _$WorkShopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? confId = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? locationDescription = null,
    Object? pricePln = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      locationDescription: null == locationDescription
          ? _value.locationDescription
          : locationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      pricePln: freezed == pricePln
          ? _value.pricePln
          : pricePln // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WorkShopCopyWith<$Res> implements $WorkShopCopyWith<$Res> {
  factory _$$_WorkShopCopyWith(
          _$_WorkShop value, $Res Function(_$_WorkShop) then) =
      __$$_WorkShopCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String confId,
      String description,
      String startDate,
      String endDate,
      String locationDescription,
      int? pricePln});
}

/// @nodoc
class __$$_WorkShopCopyWithImpl<$Res>
    extends _$WorkShopCopyWithImpl<$Res, _$_WorkShop>
    implements _$$_WorkShopCopyWith<$Res> {
  __$$_WorkShopCopyWithImpl(
      _$_WorkShop _value, $Res Function(_$_WorkShop) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? confId = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? locationDescription = null,
    Object? pricePln = freezed,
  }) {
    return _then(_$_WorkShop(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      locationDescription: null == locationDescription
          ? _value.locationDescription
          : locationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      pricePln: freezed == pricePln
          ? _value.pricePln
          : pricePln // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_WorkShop extends _WorkShop {
  const _$_WorkShop(
      {required this.title,
      required this.confId,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.locationDescription,
      required this.pricePln})
      : super._();

  @override
  final String title;
  @override
  final String confId;
  @override
  final String description;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final String locationDescription;
  @override
  final int? pricePln;

  @override
  String toString() {
    return 'WorkShop(title: $title, confId: $confId, description: $description, startDate: $startDate, endDate: $endDate, locationDescription: $locationDescription, pricePln: $pricePln)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WorkShop &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.locationDescription, locationDescription) ||
                other.locationDescription == locationDescription) &&
            (identical(other.pricePln, pricePln) ||
                other.pricePln == pricePln));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, confId, description,
      startDate, endDate, locationDescription, pricePln);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WorkShopCopyWith<_$_WorkShop> get copyWith =>
      __$$_WorkShopCopyWithImpl<_$_WorkShop>(this, _$identity);
}

abstract class _WorkShop extends WorkShop {
  const factory _WorkShop(
      {required final String title,
      required final String confId,
      required final String description,
      required final String startDate,
      required final String endDate,
      required final String locationDescription,
      required final int? pricePln}) = _$_WorkShop;
  const _WorkShop._() : super._();

  @override
  String get title;
  @override
  String get confId;
  @override
  String get description;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  String get locationDescription;
  @override
  int? get pricePln;
  @override
  @JsonKey(ignore: true)
  _$$_WorkShopCopyWith<_$_WorkShop> get copyWith =>
      throw _privateConstructorUsedError;
}
