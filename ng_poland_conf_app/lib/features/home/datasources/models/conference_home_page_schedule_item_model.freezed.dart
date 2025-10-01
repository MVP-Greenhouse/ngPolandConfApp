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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConferenceHomePageScheduleItemModel
    _$ConferenceHomePageScheduleItemModelFromJson(Map<String, dynamic> json) {
  return _ConferenceHomePageScheduleItemModel.fromJson(json);
}

/// @nodoc
mixin _$ConferenceHomePageScheduleItemModel {
  @HiveField(0)
  String get name => throw _privateConstructorUsedError;
  @HiveField(1)
  String get desc => throw _privateConstructorUsedError;

  /// Serializes this ConferenceHomePageScheduleItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConferenceHomePageScheduleItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  $Res call({@HiveField(0) String name, @HiveField(1) String desc});
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

  /// Create a copy of ConferenceHomePageScheduleItemModel
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$ConferenceHomePageScheduleItemModelImplCopyWith<$Res>
    implements $ConferenceHomePageScheduleItemModelCopyWith<$Res> {
  factory _$$ConferenceHomePageScheduleItemModelImplCopyWith(
          _$ConferenceHomePageScheduleItemModelImpl value,
          $Res Function(_$ConferenceHomePageScheduleItemModelImpl) then) =
      __$$ConferenceHomePageScheduleItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) String name, @HiveField(1) String desc});
}

/// @nodoc
class __$$ConferenceHomePageScheduleItemModelImplCopyWithImpl<$Res>
    extends _$ConferenceHomePageScheduleItemModelCopyWithImpl<$Res,
        _$ConferenceHomePageScheduleItemModelImpl>
    implements _$$ConferenceHomePageScheduleItemModelImplCopyWith<$Res> {
  __$$ConferenceHomePageScheduleItemModelImplCopyWithImpl(
      _$ConferenceHomePageScheduleItemModelImpl _value,
      $Res Function(_$ConferenceHomePageScheduleItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConferenceHomePageScheduleItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
  }) {
    return _then(_$ConferenceHomePageScheduleItemModelImpl(
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
class _$ConferenceHomePageScheduleItemModelImpl
    extends _ConferenceHomePageScheduleItemModel {
  const _$ConferenceHomePageScheduleItemModelImpl(
      {@HiveField(0) required this.name, @HiveField(1) required this.desc})
      : super._();

  factory _$ConferenceHomePageScheduleItemModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ConferenceHomePageScheduleItemModelImplFromJson(json);

  @override
  @HiveField(0)
  final String name;
  @override
  @HiveField(1)
  final String desc;

  @override
  String toString() {
    return 'ConferenceHomePageScheduleItemModel(name: $name, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConferenceHomePageScheduleItemModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, desc);

  /// Create a copy of ConferenceHomePageScheduleItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConferenceHomePageScheduleItemModelImplCopyWith<
          _$ConferenceHomePageScheduleItemModelImpl>
      get copyWith => __$$ConferenceHomePageScheduleItemModelImplCopyWithImpl<
          _$ConferenceHomePageScheduleItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConferenceHomePageScheduleItemModelImplToJson(
      this,
    );
  }
}

abstract class _ConferenceHomePageScheduleItemModel
    extends ConferenceHomePageScheduleItemModel {
  const factory _ConferenceHomePageScheduleItemModel(
          {@HiveField(0) required final String name,
          @HiveField(1) required final String desc}) =
      _$ConferenceHomePageScheduleItemModelImpl;
  const _ConferenceHomePageScheduleItemModel._() : super._();

  factory _ConferenceHomePageScheduleItemModel.fromJson(
          Map<String, dynamic> json) =
      _$ConferenceHomePageScheduleItemModelImpl.fromJson;

  @override
  @HiveField(0)
  String get name;
  @override
  @HiveField(1)
  String get desc;

  /// Create a copy of ConferenceHomePageScheduleItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConferenceHomePageScheduleItemModelImplCopyWith<
          _$ConferenceHomePageScheduleItemModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
