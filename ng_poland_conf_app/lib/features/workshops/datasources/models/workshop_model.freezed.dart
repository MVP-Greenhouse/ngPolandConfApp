// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workshop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WorkshopModel _$WorkshopModelFromJson(Map<String, dynamic> json) {
  return _WorkshopModel.fromJson(json);
}

/// @nodoc
mixin _$WorkshopModel {
  String get title => throw _privateConstructorUsedError;
  String get confId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  String get locationDescription => throw _privateConstructorUsedError;
  int? get pricePln => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkshopModelCopyWith<WorkshopModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkshopModelCopyWith<$Res> {
  factory $WorkshopModelCopyWith(
          WorkshopModel value, $Res Function(WorkshopModel) then) =
      _$WorkshopModelCopyWithImpl<$Res, WorkshopModel>;
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
class _$WorkshopModelCopyWithImpl<$Res, $Val extends WorkshopModel>
    implements $WorkshopModelCopyWith<$Res> {
  _$WorkshopModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_WorkshopModelCopyWith<$Res>
    implements $WorkshopModelCopyWith<$Res> {
  factory _$$_WorkshopModelCopyWith(
          _$_WorkshopModel value, $Res Function(_$_WorkshopModel) then) =
      __$$_WorkshopModelCopyWithImpl<$Res>;
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
class __$$_WorkshopModelCopyWithImpl<$Res>
    extends _$WorkshopModelCopyWithImpl<$Res, _$_WorkshopModel>
    implements _$$_WorkshopModelCopyWith<$Res> {
  __$$_WorkshopModelCopyWithImpl(
      _$_WorkshopModel _value, $Res Function(_$_WorkshopModel) _then)
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
    return _then(_$_WorkshopModel(
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
@JsonSerializable()
class _$_WorkshopModel extends _WorkshopModel {
  const _$_WorkshopModel(
      {required this.title,
      required this.confId,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.locationDescription,
      required this.pricePln})
      : super._();

  factory _$_WorkshopModel.fromJson(Map<String, dynamic> json) =>
      _$$_WorkshopModelFromJson(json);

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
    return 'WorkshopModel(title: $title, confId: $confId, description: $description, startDate: $startDate, endDate: $endDate, locationDescription: $locationDescription, pricePln: $pricePln)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WorkshopModel &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, confId, description,
      startDate, endDate, locationDescription, pricePln);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WorkshopModelCopyWith<_$_WorkshopModel> get copyWith =>
      __$$_WorkshopModelCopyWithImpl<_$_WorkshopModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WorkshopModelToJson(
      this,
    );
  }
}

abstract class _WorkshopModel extends WorkshopModel {
  const factory _WorkshopModel(
      {required final String title,
      required final String confId,
      required final String description,
      required final String startDate,
      required final String endDate,
      required final String locationDescription,
      required final int? pricePln}) = _$_WorkshopModel;
  const _WorkshopModel._() : super._();

  factory _WorkshopModel.fromJson(Map<String, dynamic> json) =
      _$_WorkshopModel.fromJson;

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
  _$$_WorkshopModelCopyWith<_$_WorkshopModel> get copyWith =>
      throw _privateConstructorUsedError;
}
