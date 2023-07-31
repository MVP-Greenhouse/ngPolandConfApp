// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conferences_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConferencesModel _$ConferencesModelFromJson(Map<String, dynamic> json) {
  return _ConferencesModel.fromJson(json);
}

/// @nodoc
mixin _$ConferencesModel {
  List<ConferenceModel?>? get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConferencesModelCopyWith<ConferencesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConferencesModelCopyWith<$Res> {
  factory $ConferencesModelCopyWith(
          ConferencesModel value, $Res Function(ConferencesModel) then) =
      _$ConferencesModelCopyWithImpl<$Res, ConferencesModel>;
  @useResult
  $Res call({List<ConferenceModel?>? items});
}

/// @nodoc
class _$ConferencesModelCopyWithImpl<$Res, $Val extends ConferencesModel>
    implements $ConferencesModelCopyWith<$Res> {
  _$ConferencesModelCopyWithImpl(this._value, this._then);

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
              as List<ConferenceModel?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConferencesModelCopyWith<$Res>
    implements $ConferencesModelCopyWith<$Res> {
  factory _$$_ConferencesModelCopyWith(
          _$_ConferencesModel value, $Res Function(_$_ConferencesModel) then) =
      __$$_ConferencesModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ConferenceModel?>? items});
}

/// @nodoc
class __$$_ConferencesModelCopyWithImpl<$Res>
    extends _$ConferencesModelCopyWithImpl<$Res, _$_ConferencesModel>
    implements _$$_ConferencesModelCopyWith<$Res> {
  __$$_ConferencesModelCopyWithImpl(
      _$_ConferencesModel _value, $Res Function(_$_ConferencesModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_$_ConferencesModel(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ConferenceModel?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConferencesModel extends _ConferencesModel {
  const _$_ConferencesModel({final List<ConferenceModel?>? items})
      : _items = items,
        super._();

  factory _$_ConferencesModel.fromJson(Map<String, dynamic> json) =>
      _$$_ConferencesModelFromJson(json);

  final List<ConferenceModel?>? _items;
  @override
  List<ConferenceModel?>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ConferencesModel(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConferencesModel &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConferencesModelCopyWith<_$_ConferencesModel> get copyWith =>
      __$$_ConferencesModelCopyWithImpl<_$_ConferencesModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConferencesModelToJson(
      this,
    );
  }
}

abstract class _ConferencesModel extends ConferencesModel {
  const factory _ConferencesModel({final List<ConferenceModel?>? items}) =
      _$_ConferencesModel;
  const _ConferencesModel._() : super._();

  factory _ConferencesModel.fromJson(Map<String, dynamic> json) =
      _$_ConferencesModel.fromJson;

  @override
  List<ConferenceModel?>? get items;
  @override
  @JsonKey(ignore: true)
  _$$_ConferencesModelCopyWith<_$_ConferencesModel> get copyWith =>
      throw _privateConstructorUsedError;
}
