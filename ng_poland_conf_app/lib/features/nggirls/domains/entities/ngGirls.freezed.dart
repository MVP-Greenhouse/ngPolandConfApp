// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ngGirls.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NgGirls {
  String get myId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;

  /// Create a copy of NgGirls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NgGirlsCopyWith<NgGirls> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NgGirlsCopyWith<$Res> {
  factory $NgGirlsCopyWith(NgGirls value, $Res Function(NgGirls) then) =
      _$NgGirlsCopyWithImpl<$Res, NgGirls>;
  @useResult
  $Res call({String myId, String? title, String? text});
}

/// @nodoc
class _$NgGirlsCopyWithImpl<$Res, $Val extends NgGirls>
    implements $NgGirlsCopyWith<$Res> {
  _$NgGirlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NgGirls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myId = null,
    Object? title = freezed,
    Object? text = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NgGirlsImplCopyWith<$Res> implements $NgGirlsCopyWith<$Res> {
  factory _$$NgGirlsImplCopyWith(
          _$NgGirlsImpl value, $Res Function(_$NgGirlsImpl) then) =
      __$$NgGirlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String myId, String? title, String? text});
}

/// @nodoc
class __$$NgGirlsImplCopyWithImpl<$Res>
    extends _$NgGirlsCopyWithImpl<$Res, _$NgGirlsImpl>
    implements _$$NgGirlsImplCopyWith<$Res> {
  __$$NgGirlsImplCopyWithImpl(
      _$NgGirlsImpl _value, $Res Function(_$NgGirlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NgGirls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myId = null,
    Object? title = freezed,
    Object? text = freezed,
  }) {
    return _then(_$NgGirlsImpl(
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
    ));
  }
}

/// @nodoc

class _$NgGirlsImpl extends _NgGirls {
  const _$NgGirlsImpl(
      {required this.myId, required this.title, required this.text})
      : super._();

  @override
  final String myId;
  @override
  final String? title;
  @override
  final String? text;

  @override
  String toString() {
    return 'NgGirls(myId: $myId, title: $title, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NgGirlsImpl &&
            (identical(other.myId, myId) || other.myId == myId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, myId, title, text);

  /// Create a copy of NgGirls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NgGirlsImplCopyWith<_$NgGirlsImpl> get copyWith =>
      __$$NgGirlsImplCopyWithImpl<_$NgGirlsImpl>(this, _$identity);
}

abstract class _NgGirls extends NgGirls {
  const factory _NgGirls(
      {required final String myId,
      required final String? title,
      required final String? text}) = _$NgGirlsImpl;
  const _NgGirls._() : super._();

  @override
  String get myId;
  @override
  String? get title;
  @override
  String? get text;

  /// Create a copy of NgGirls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NgGirlsImplCopyWith<_$NgGirlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
