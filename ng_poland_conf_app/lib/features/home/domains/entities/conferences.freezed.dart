// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Conferences {
  List<Conference> get list => throw _privateConstructorUsedError;

  /// Create a copy of Conferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConferencesCopyWith<Conferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConferencesCopyWith<$Res> {
  factory $ConferencesCopyWith(
          Conferences value, $Res Function(Conferences) then) =
      _$ConferencesCopyWithImpl<$Res, Conferences>;
  @useResult
  $Res call({List<Conference> list});
}

/// @nodoc
class _$ConferencesCopyWithImpl<$Res, $Val extends Conferences>
    implements $ConferencesCopyWith<$Res> {
  _$ConferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Conferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Conference>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConferencesImplCopyWith<$Res>
    implements $ConferencesCopyWith<$Res> {
  factory _$$ConferencesImplCopyWith(
          _$ConferencesImpl value, $Res Function(_$ConferencesImpl) then) =
      __$$ConferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Conference> list});
}

/// @nodoc
class __$$ConferencesImplCopyWithImpl<$Res>
    extends _$ConferencesCopyWithImpl<$Res, _$ConferencesImpl>
    implements _$$ConferencesImplCopyWith<$Res> {
  __$$ConferencesImplCopyWithImpl(
      _$ConferencesImpl _value, $Res Function(_$ConferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of Conferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$ConferencesImpl(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Conference>,
    ));
  }
}

/// @nodoc

class _$ConferencesImpl implements _Conferences {
  _$ConferencesImpl({required final List<Conference> list}) : _list = list;

  final List<Conference> _list;
  @override
  List<Conference> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'Conferences(list: $list)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConferencesImpl &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  /// Create a copy of Conferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConferencesImplCopyWith<_$ConferencesImpl> get copyWith =>
      __$$ConferencesImplCopyWithImpl<_$ConferencesImpl>(this, _$identity);
}

abstract class _Conferences implements Conferences {
  factory _Conferences({required final List<Conference> list}) =
      _$ConferencesImpl;

  @override
  List<Conference> get list;

  /// Create a copy of Conferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConferencesImplCopyWith<_$ConferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
