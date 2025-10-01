// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conference_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConferenceItem {
  String get name => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;

  /// Create a copy of ConferenceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConferenceItemCopyWith<ConferenceItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConferenceItemCopyWith<$Res> {
  factory $ConferenceItemCopyWith(
          ConferenceItem value, $Res Function(ConferenceItem) then) =
      _$ConferenceItemCopyWithImpl<$Res, ConferenceItem>;
  @useResult
  $Res call({String name, String desc});
}

/// @nodoc
class _$ConferenceItemCopyWithImpl<$Res, $Val extends ConferenceItem>
    implements $ConferenceItemCopyWith<$Res> {
  _$ConferenceItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConferenceItem
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
abstract class _$$ConferenceItemImplCopyWith<$Res>
    implements $ConferenceItemCopyWith<$Res> {
  factory _$$ConferenceItemImplCopyWith(_$ConferenceItemImpl value,
          $Res Function(_$ConferenceItemImpl) then) =
      __$$ConferenceItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String desc});
}

/// @nodoc
class __$$ConferenceItemImplCopyWithImpl<$Res>
    extends _$ConferenceItemCopyWithImpl<$Res, _$ConferenceItemImpl>
    implements _$$ConferenceItemImplCopyWith<$Res> {
  __$$ConferenceItemImplCopyWithImpl(
      _$ConferenceItemImpl _value, $Res Function(_$ConferenceItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConferenceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
  }) {
    return _then(_$ConferenceItemImpl(
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

class _$ConferenceItemImpl implements _ConferenceItem {
  const _$ConferenceItemImpl({required this.name, required this.desc});

  @override
  final String name;
  @override
  final String desc;

  @override
  String toString() {
    return 'ConferenceItem(name: $name, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConferenceItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, desc);

  /// Create a copy of ConferenceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConferenceItemImplCopyWith<_$ConferenceItemImpl> get copyWith =>
      __$$ConferenceItemImplCopyWithImpl<_$ConferenceItemImpl>(
          this, _$identity);
}

abstract class _ConferenceItem implements ConferenceItem {
  const factory _ConferenceItem(
      {required final String name,
      required final String desc}) = _$ConferenceItemImpl;

  @override
  String get name;
  @override
  String get desc;

  /// Create a copy of ConferenceItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConferenceItemImplCopyWith<_$ConferenceItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
