// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ngGirls_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NgGirlsModel _$NgGirlsModelFromJson(Map<String, dynamic> json) {
  return _NgGirlsModel.fromJson(json);
}

/// @nodoc
mixin _$NgGirlsModel {
  @HiveField(0)
  String get myId => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get text => throw _privateConstructorUsedError;
  @HiveField(3)
  String get confId => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime? get lastUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NgGirlsModelCopyWith<NgGirlsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NgGirlsModelCopyWith<$Res> {
  factory $NgGirlsModelCopyWith(
          NgGirlsModel value, $Res Function(NgGirlsModel) then) =
      _$NgGirlsModelCopyWithImpl<$Res, NgGirlsModel>;
  @useResult
  $Res call(
      {@HiveField(0) String myId,
      @HiveField(1) String? title,
      @HiveField(2) String? text,
      @HiveField(3) String confId,
      @HiveField(4) DateTime? lastUpdate});
}

/// @nodoc
class _$NgGirlsModelCopyWithImpl<$Res, $Val extends NgGirlsModel>
    implements $NgGirlsModelCopyWith<$Res> {
  _$NgGirlsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myId = null,
    Object? title = freezed,
    Object? text = freezed,
    Object? confId = null,
    Object? lastUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      myId: null == myId
          ? _value.myId
          : myId // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NgGirlsModelImplCopyWith<$Res>
    implements $NgGirlsModelCopyWith<$Res> {
  factory _$$NgGirlsModelImplCopyWith(
          _$NgGirlsModelImpl value, $Res Function(_$NgGirlsModelImpl) then) =
      __$$NgGirlsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String myId,
      @HiveField(1) String? title,
      @HiveField(2) String? text,
      @HiveField(3) String confId,
      @HiveField(4) DateTime? lastUpdate});
}

/// @nodoc
class __$$NgGirlsModelImplCopyWithImpl<$Res>
    extends _$NgGirlsModelCopyWithImpl<$Res, _$NgGirlsModelImpl>
    implements _$$NgGirlsModelImplCopyWith<$Res> {
  __$$NgGirlsModelImplCopyWithImpl(
      _$NgGirlsModelImpl _value, $Res Function(_$NgGirlsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myId = null,
    Object? title = freezed,
    Object? text = freezed,
    Object? confId = null,
    Object? lastUpdate = freezed,
  }) {
    return _then(_$NgGirlsModelImpl(
      myId: null == myId
          ? _value.myId
          : myId // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NgGirlsModelImpl extends _NgGirlsModel {
  const _$NgGirlsModelImpl(
      {@HiveField(0) required this.myId,
      @HiveField(1) required this.title,
      @HiveField(2) required this.text,
      @HiveField(3) required this.confId,
      @HiveField(4) this.lastUpdate})
      : super._();

  factory _$NgGirlsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NgGirlsModelImplFromJson(json);

  @override
  @HiveField(0)
  final String myId;
  @override
  @HiveField(1)
  final String? title;
  @override
  @HiveField(2)
  final String? text;
  @override
  @HiveField(3)
  final String confId;
  @override
  @HiveField(4)
  final DateTime? lastUpdate;

  @override
  String toString() {
    return 'NgGirlsModel(myId: $myId, title: $title, text: $text, confId: $confId, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NgGirlsModelImpl &&
            (identical(other.myId, myId) || other.myId == myId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, myId, title, text, confId, lastUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NgGirlsModelImplCopyWith<_$NgGirlsModelImpl> get copyWith =>
      __$$NgGirlsModelImplCopyWithImpl<_$NgGirlsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NgGirlsModelImplToJson(
      this,
    );
  }
}

abstract class _NgGirlsModel extends NgGirlsModel {
  const factory _NgGirlsModel(
      {@HiveField(0) required final String myId,
      @HiveField(1) required final String? title,
      @HiveField(2) required final String? text,
      @HiveField(3) required final String confId,
      @HiveField(4) final DateTime? lastUpdate}) = _$NgGirlsModelImpl;
  const _NgGirlsModel._() : super._();

  factory _NgGirlsModel.fromJson(Map<String, dynamic> json) =
      _$NgGirlsModelImpl.fromJson;

  @override
  @HiveField(0)
  String get myId;
  @override
  @HiveField(1)
  String? get title;
  @override
  @HiveField(2)
  String? get text;
  @override
  @HiveField(3)
  String get confId;
  @override
  @HiveField(4)
  DateTime? get lastUpdate;
  @override
  @JsonKey(ignore: true)
  _$$NgGirlsModelImplCopyWith<_$NgGirlsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
