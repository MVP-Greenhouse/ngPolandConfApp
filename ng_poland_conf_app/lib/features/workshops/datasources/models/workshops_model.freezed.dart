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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorkshopsModel {
  @HiveField(0)
  List<WorkshopModel>? get items => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime? get lastUpdate => throw _privateConstructorUsedError;
  @HiveField(2)
  dynamic get confId => throw _privateConstructorUsedError;

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
  $Res call(
      {@HiveField(0) List<WorkshopModel>? items,
      @HiveField(1) DateTime? lastUpdate,
      @HiveField(2) dynamic confId});
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
    Object? lastUpdate = freezed,
    Object? confId = freezed,
  }) {
    return _then(_value.copyWith(
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<WorkshopModel>?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confId: freezed == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkshopsModelImplCopyWith<$Res>
    implements $WorkshopsModelCopyWith<$Res> {
  factory _$$WorkshopsModelImplCopyWith(_$WorkshopsModelImpl value,
          $Res Function(_$WorkshopsModelImpl) then) =
      __$$WorkshopsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<WorkshopModel>? items,
      @HiveField(1) DateTime? lastUpdate,
      @HiveField(2) dynamic confId});
}

/// @nodoc
class __$$WorkshopsModelImplCopyWithImpl<$Res>
    extends _$WorkshopsModelCopyWithImpl<$Res, _$WorkshopsModelImpl>
    implements _$$WorkshopsModelImplCopyWith<$Res> {
  __$$WorkshopsModelImplCopyWithImpl(
      _$WorkshopsModelImpl _value, $Res Function(_$WorkshopsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? lastUpdate = freezed,
    Object? confId = freezed,
  }) {
    return _then(_$WorkshopsModelImpl(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<WorkshopModel>?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confId: freezed == confId ? _value.confId! : confId,
    ));
  }
}

/// @nodoc

class _$WorkshopsModelImpl extends _WorkshopsModel {
  const _$WorkshopsModelImpl(
      {@HiveField(0) required final List<WorkshopModel>? items,
      @HiveField(1) this.lastUpdate,
      @HiveField(2) this.confId})
      : _items = items,
        super._();

  final List<WorkshopModel>? _items;
  @override
  @HiveField(0)
  List<WorkshopModel>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(1)
  final DateTime? lastUpdate;
  @override
  @HiveField(2)
  final dynamic confId;

  @override
  String toString() {
    return 'WorkshopsModel(items: $items, lastUpdate: $lastUpdate, confId: $confId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkshopsModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            const DeepCollectionEquality().equals(other.confId, confId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      lastUpdate,
      const DeepCollectionEquality().hash(confId));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkshopsModelImplCopyWith<_$WorkshopsModelImpl> get copyWith =>
      __$$WorkshopsModelImplCopyWithImpl<_$WorkshopsModelImpl>(
          this, _$identity);
}

abstract class _WorkshopsModel extends WorkshopsModel {
  const factory _WorkshopsModel(
      {@HiveField(0) required final List<WorkshopModel>? items,
      @HiveField(1) final DateTime? lastUpdate,
      @HiveField(2) final dynamic confId}) = _$WorkshopsModelImpl;
  const _WorkshopsModel._() : super._();

  @override
  @HiveField(0)
  List<WorkshopModel>? get items;
  @override
  @HiveField(1)
  DateTime? get lastUpdate;
  @override
  @HiveField(2)
  dynamic get confId;
  @override
  @JsonKey(ignore: true)
  _$$WorkshopsModelImplCopyWith<_$WorkshopsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
