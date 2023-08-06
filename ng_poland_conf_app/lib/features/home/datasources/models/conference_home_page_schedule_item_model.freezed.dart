// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conference_home_page_schedule_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConferenceHomePageScheduleItemModel
    _$ConferenceHomePageScheduleItemModelFromJson(Map<String, dynamic> json) {
  return _ConferenceHomePageScheduleItemModel.fromJson(json);
}

/// @nodoc
mixin _$ConferenceHomePageScheduleItemModel {
  String get name => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConferenceHomePageScheduleItemModelCopyWith<
          ConferenceHomePageScheduleItemModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConferenceHomePageScheduleItemModelCopyWith<$Res> {
  factory $ConferenceHomePageScheduleItemModelCopyWith(
          ConferenceHomePageScheduleItemModel value,
          $Res Function(ConferenceHomePageScheduleItemModel) then) =
      _$ConferenceHomePageScheduleItemModelCopyWithImpl<$Res,
          ConferenceHomePageScheduleItemModel>;
  @useResult
  $Res call({String name, String desc});
}

/// @nodoc
class _$ConferenceHomePageScheduleItemModelCopyWithImpl<$Res,
        $Val extends ConferenceHomePageScheduleItemModel>
    implements $ConferenceHomePageScheduleItemModelCopyWith<$Res> {
  _$ConferenceHomePageScheduleItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConferenceHomePageScheduleItemModelCopyWith<$Res>
    implements $ConferenceHomePageScheduleItemModelCopyWith<$Res> {
  factory _$$_ConferenceHomePageScheduleItemModelCopyWith(
          _$_ConferenceHomePageScheduleItemModel value,
          $Res Function(_$_ConferenceHomePageScheduleItemModel) then) =
      __$$_ConferenceHomePageScheduleItemModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String desc});
}

/// @nodoc
class __$$_ConferenceHomePageScheduleItemModelCopyWithImpl<$Res>
    extends _$ConferenceHomePageScheduleItemModelCopyWithImpl<$Res,
        _$_ConferenceHomePageScheduleItemModel>
    implements _$$_ConferenceHomePageScheduleItemModelCopyWith<$Res> {
  __$$_ConferenceHomePageScheduleItemModelCopyWithImpl(
      _$_ConferenceHomePageScheduleItemModel _value,
      $Res Function(_$_ConferenceHomePageScheduleItemModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
  }) {
    return _then(_$_ConferenceHomePageScheduleItemModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConferenceHomePageScheduleItemModel
    extends _ConferenceHomePageScheduleItemModel {
  const _$_ConferenceHomePageScheduleItemModel(
      {required this.name, required this.desc})
      : super._();

  factory _$_ConferenceHomePageScheduleItemModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_ConferenceHomePageScheduleItemModelFromJson(json);

  @override
  final String name;
  @override
  final String desc;

  @override
  String toString() {
    return 'ConferenceHomePageScheduleItemModel(name: $name, desc: $desc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConferenceHomePageScheduleItemModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConferenceHomePageScheduleItemModelCopyWith<
          _$_ConferenceHomePageScheduleItemModel>
      get copyWith => __$$_ConferenceHomePageScheduleItemModelCopyWithImpl<
          _$_ConferenceHomePageScheduleItemModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConferenceHomePageScheduleItemModelToJson(
      this,
    );
  }
}

abstract class _ConferenceHomePageScheduleItemModel
    extends ConferenceHomePageScheduleItemModel {
  const factory _ConferenceHomePageScheduleItemModel(
      {required final String name,
      required final String desc}) = _$_ConferenceHomePageScheduleItemModel;
  const _ConferenceHomePageScheduleItemModel._() : super._();

  factory _ConferenceHomePageScheduleItemModel.fromJson(
          Map<String, dynamic> json) =
      _$_ConferenceHomePageScheduleItemModel.fromJson;

  @override
  String get name;
  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$_ConferenceHomePageScheduleItemModelCopyWith<
          _$_ConferenceHomePageScheduleItemModel>
      get copyWith => throw _privateConstructorUsedError;
}
