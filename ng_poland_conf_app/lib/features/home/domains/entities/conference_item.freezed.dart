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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ConferenceItem {
  @HiveField(0)
  String get name => throw _privateConstructorUsedError;
  @HiveField(1)
  String get desc => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConferenceItemCopyWith<ConferenceItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConferenceItemCopyWith<$Res> {
  factory $ConferenceItemCopyWith(
          ConferenceItem value, $Res Function(ConferenceItem) then) =
      _$ConferenceItemCopyWithImpl<$Res, ConferenceItem>;
  @useResult
  $Res call({@HiveField(0) String name, @HiveField(1) String desc});
}

/// @nodoc
class _$ConferenceItemCopyWithImpl<$Res, $Val extends ConferenceItem>
    implements $ConferenceItemCopyWith<$Res> {
  _$ConferenceItemCopyWithImpl(this._value, this._then);

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
abstract class _$$_ConferenceItemCopyWith<$Res>
    implements $ConferenceItemCopyWith<$Res> {
  factory _$$_ConferenceItemCopyWith(
          _$_ConferenceItem value, $Res Function(_$_ConferenceItem) then) =
      __$$_ConferenceItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) String name, @HiveField(1) String desc});
}

/// @nodoc
class __$$_ConferenceItemCopyWithImpl<$Res>
    extends _$ConferenceItemCopyWithImpl<$Res, _$_ConferenceItem>
    implements _$$_ConferenceItemCopyWith<$Res> {
  __$$_ConferenceItemCopyWithImpl(
      _$_ConferenceItem _value, $Res Function(_$_ConferenceItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
  }) {
    return _then(_$_ConferenceItem(
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

class _$_ConferenceItem implements _ConferenceItem {
  const _$_ConferenceItem(
      {@HiveField(0) required this.name, @HiveField(1) required this.desc});

  @override
  @HiveField(0)
  final String name;
  @override
  @HiveField(1)
  final String desc;

  @override
  String toString() {
    return 'ConferenceItem(name: $name, desc: $desc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConferenceItem &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConferenceItemCopyWith<_$_ConferenceItem> get copyWith =>
      __$$_ConferenceItemCopyWithImpl<_$_ConferenceItem>(this, _$identity);
}

abstract class _ConferenceItem implements ConferenceItem {
  const factory _ConferenceItem(
      {@HiveField(0) required final String name,
      @HiveField(1) required final String desc}) = _$_ConferenceItem;

  @override
  @HiveField(0)
  String get name;
  @override
  @HiveField(1)
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$_ConferenceItemCopyWith<_$_ConferenceItem> get copyWith =>
      throw _privateConstructorUsedError;
}
