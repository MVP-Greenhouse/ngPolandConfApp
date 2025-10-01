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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConferencesModel _$ConferencesModelFromJson(Map<String, dynamic> json) {
  return _ConferencesModel.fromJson(json);
}

/// @nodoc
mixin _$ConferencesModel {
  @HiveField(0)
  List<ConferenceModel?>? get items => throw _privateConstructorUsedError;

  /// Serializes this ConferencesModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConferencesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConferencesModelCopyWith<ConferencesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConferencesModelCopyWith<$Res> {
  factory $ConferencesModelCopyWith(
          ConferencesModel value, $Res Function(ConferencesModel) then) =
      _$ConferencesModelCopyWithImpl<$Res, ConferencesModel>;
  @useResult
  $Res call({@HiveField(0) List<ConferenceModel?>? items});
}

/// @nodoc
class _$ConferencesModelCopyWithImpl<$Res, $Val extends ConferencesModel>
    implements $ConferencesModelCopyWith<$Res> {
  _$ConferencesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConferencesModel
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$ConferencesModelImplCopyWith<$Res>
    implements $ConferencesModelCopyWith<$Res> {
  factory _$$ConferencesModelImplCopyWith(_$ConferencesModelImpl value,
          $Res Function(_$ConferencesModelImpl) then) =
      __$$ConferencesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) List<ConferenceModel?>? items});
}

/// @nodoc
class __$$ConferencesModelImplCopyWithImpl<$Res>
    extends _$ConferencesModelCopyWithImpl<$Res, _$ConferencesModelImpl>
    implements _$$ConferencesModelImplCopyWith<$Res> {
  __$$ConferencesModelImplCopyWithImpl(_$ConferencesModelImpl _value,
      $Res Function(_$ConferencesModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConferencesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_$ConferencesModelImpl(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ConferenceModel?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConferencesModelImpl extends _ConferencesModel {
  const _$ConferencesModelImpl(
      {@HiveField(0) final List<ConferenceModel?>? items})
      : _items = items,
        super._();

  factory _$ConferencesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConferencesModelImplFromJson(json);

  final List<ConferenceModel?>? _items;
  @override
  @HiveField(0)
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConferencesModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of ConferencesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConferencesModelImplCopyWith<_$ConferencesModelImpl> get copyWith =>
      __$$ConferencesModelImplCopyWithImpl<_$ConferencesModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConferencesModelImplToJson(
      this,
    );
  }
}

abstract class _ConferencesModel extends ConferencesModel {
  const factory _ConferencesModel(
          {@HiveField(0) final List<ConferenceModel?>? items}) =
      _$ConferencesModelImpl;
  const _ConferencesModel._() : super._();

  factory _ConferencesModel.fromJson(Map<String, dynamic> json) =
      _$ConferencesModelImpl.fromJson;

  @override
  @HiveField(0)
  List<ConferenceModel?>? get items;

  /// Create a copy of ConferencesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConferencesModelImplCopyWith<_$ConferencesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
