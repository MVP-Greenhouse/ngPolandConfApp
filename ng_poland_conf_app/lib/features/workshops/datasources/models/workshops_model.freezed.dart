// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workshops_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WorkshopsModel _$WorkshopsModelFromJson(Map<String, dynamic> json) {
  return _WorkshopsModel.fromJson(json);
}

/// @nodoc
mixin _$WorkshopsModel {
  List<WorkshopModel>? get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkshopsModelCopyWith<WorkshopsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkshopsModelCopyWith<$Res> {
  factory $WorkshopsModelCopyWith(
          WorkshopsModel value, $Res Function(WorkshopsModel) then) =
      _$WorkshopsModelCopyWithImpl<$Res, WorkshopsModel>;
  @useResult
  $Res call({List<WorkshopModel>? items});
}

/// @nodoc
class _$WorkshopsModelCopyWithImpl<$Res, $Val extends WorkshopsModel>
    implements $WorkshopsModelCopyWith<$Res> {
  _$WorkshopsModelCopyWithImpl(this._value, this._then);

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
              as List<WorkshopModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WorkshopsModelCopyWith<$Res>
    implements $WorkshopsModelCopyWith<$Res> {
  factory _$$_WorkshopsModelCopyWith(
          _$_WorkshopsModel value, $Res Function(_$_WorkshopsModel) then) =
      __$$_WorkshopsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<WorkshopModel>? items});
}

/// @nodoc
class __$$_WorkshopsModelCopyWithImpl<$Res>
    extends _$WorkshopsModelCopyWithImpl<$Res, _$_WorkshopsModel>
    implements _$$_WorkshopsModelCopyWith<$Res> {
  __$$_WorkshopsModelCopyWithImpl(
      _$_WorkshopsModel _value, $Res Function(_$_WorkshopsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_$_WorkshopsModel(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<WorkshopModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WorkshopsModel extends _WorkshopsModel {
  const _$_WorkshopsModel({required final List<WorkshopModel>? items})
      : _items = items,
        super._();

  factory _$_WorkshopsModel.fromJson(Map<String, dynamic> json) =>
      _$$_WorkshopsModelFromJson(json);

  final List<WorkshopModel>? _items;
  @override
  List<WorkshopModel>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WorkshopsModel(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WorkshopsModel &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WorkshopsModelCopyWith<_$_WorkshopsModel> get copyWith =>
      __$$_WorkshopsModelCopyWithImpl<_$_WorkshopsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WorkshopsModelToJson(
      this,
    );
  }
}

abstract class _WorkshopsModel extends WorkshopsModel {
  const factory _WorkshopsModel({required final List<WorkshopModel>? items}) =
      _$_WorkshopsModel;
  const _WorkshopsModel._() : super._();

  factory _WorkshopsModel.fromJson(Map<String, dynamic> json) =
      _$_WorkshopsModel.fromJson;

  @override
  List<WorkshopModel>? get items;
  @override
  @JsonKey(ignore: true)
  _$$_WorkshopsModelCopyWith<_$_WorkshopsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
