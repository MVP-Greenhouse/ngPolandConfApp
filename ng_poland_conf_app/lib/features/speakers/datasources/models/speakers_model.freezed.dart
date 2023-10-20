// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speakers_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpeakersModel {
  List<SpeakerModel>? get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpeakersModelCopyWith<SpeakersModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeakersModelCopyWith<$Res> {
  factory $SpeakersModelCopyWith(
          SpeakersModel value, $Res Function(SpeakersModel) then) =
      _$SpeakersModelCopyWithImpl<$Res, SpeakersModel>;
  @useResult
  $Res call({List<SpeakerModel>? items});
}

/// @nodoc
class _$SpeakersModelCopyWithImpl<$Res, $Val extends SpeakersModel>
    implements $SpeakersModelCopyWith<$Res> {
  _$SpeakersModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SpeakerModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpeakersModelCopyWith<$Res>
    implements $SpeakersModelCopyWith<$Res> {
  factory _$$_SpeakersModelCopyWith(
          _$_SpeakersModel value, $Res Function(_$_SpeakersModel) then) =
      __$$_SpeakersModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SpeakerModel>? items});
}

/// @nodoc
class __$$_SpeakersModelCopyWithImpl<$Res>
    extends _$SpeakersModelCopyWithImpl<$Res, _$_SpeakersModel>
    implements _$$_SpeakersModelCopyWith<$Res> {
  __$$_SpeakersModelCopyWithImpl(
      _$_SpeakersModel _value, $Res Function(_$_SpeakersModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_$_SpeakersModel(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SpeakerModel>?,
    ));
  }
}

/// @nodoc

class _$_SpeakersModel extends _SpeakersModel {
  const _$_SpeakersModel({required final List<SpeakerModel>? items})
      : _items = items,
        super._();

  final List<SpeakerModel>? _items;
  @override
  List<SpeakerModel>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SpeakersModel(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpeakersModel &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpeakersModelCopyWith<_$_SpeakersModel> get copyWith =>
      __$$_SpeakersModelCopyWithImpl<_$_SpeakersModel>(this, _$identity);
}

abstract class _SpeakersModel extends SpeakersModel {
  const factory _SpeakersModel({required final List<SpeakerModel>? items}) =
      _$_SpeakersModel;
  const _SpeakersModel._() : super._();

  @override
  List<SpeakerModel>? get items;
  @override
  @JsonKey(ignore: true)
  _$$_SpeakersModelCopyWith<_$_SpeakersModel> get copyWith =>
      throw _privateConstructorUsedError;
}
