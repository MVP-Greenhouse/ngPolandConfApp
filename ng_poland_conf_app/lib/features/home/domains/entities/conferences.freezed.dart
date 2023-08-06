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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Conferences {
  List<Conference> get list => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
abstract class _$$_ConferencesCopyWith<$Res>
    implements $ConferencesCopyWith<$Res> {
  factory _$$_ConferencesCopyWith(
          _$_Conferences value, $Res Function(_$_Conferences) then) =
      __$$_ConferencesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Conference> list});
}

/// @nodoc
class __$$_ConferencesCopyWithImpl<$Res>
    extends _$ConferencesCopyWithImpl<$Res, _$_Conferences>
    implements _$$_ConferencesCopyWith<$Res> {
  __$$_ConferencesCopyWithImpl(
      _$_Conferences _value, $Res Function(_$_Conferences) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$_Conferences(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Conference>,
    ));
  }
}

/// @nodoc

class _$_Conferences implements _Conferences {
  _$_Conferences({required final List<Conference> list}) : _list = list;

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Conferences &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConferencesCopyWith<_$_Conferences> get copyWith =>
      __$$_ConferencesCopyWithImpl<_$_Conferences>(this, _$identity);
}

abstract class _Conferences implements Conferences {
  factory _Conferences({required final List<Conference> list}) = _$_Conferences;

  @override
  List<Conference> get list;
  @override
  @JsonKey(ignore: true)
  _$$_ConferencesCopyWith<_$_Conferences> get copyWith =>
      throw _privateConstructorUsedError;
}
