// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventsModel {
  @HiveField(0)
  List<EventItemModel>? get items => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime? get lastUpdate => throw _privateConstructorUsedError;
  @HiveField(2)
  dynamic get confId => throw _privateConstructorUsedError;

  /// Create a copy of EventsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventsModelCopyWith<EventsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventsModelCopyWith<$Res> {
  factory $EventsModelCopyWith(
          EventsModel value, $Res Function(EventsModel) then) =
      _$EventsModelCopyWithImpl<$Res, EventsModel>;
  @useResult
  $Res call(
      {@HiveField(0) List<EventItemModel>? items,
      @HiveField(1) DateTime? lastUpdate,
      @HiveField(2) dynamic confId});
}

/// @nodoc
class _$EventsModelCopyWithImpl<$Res, $Val extends EventsModel>
    implements $EventsModelCopyWith<$Res> {
  _$EventsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventsModel
  /// with the given fields replaced by the non-null parameter values.
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
              as List<EventItemModel>?,
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
abstract class _$$EventsModelImplCopyWith<$Res>
    implements $EventsModelCopyWith<$Res> {
  factory _$$EventsModelImplCopyWith(
          _$EventsModelImpl value, $Res Function(_$EventsModelImpl) then) =
      __$$EventsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<EventItemModel>? items,
      @HiveField(1) DateTime? lastUpdate,
      @HiveField(2) dynamic confId});
}

/// @nodoc
class __$$EventsModelImplCopyWithImpl<$Res>
    extends _$EventsModelCopyWithImpl<$Res, _$EventsModelImpl>
    implements _$$EventsModelImplCopyWith<$Res> {
  __$$EventsModelImplCopyWithImpl(
      _$EventsModelImpl _value, $Res Function(_$EventsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? lastUpdate = freezed,
    Object? confId = freezed,
  }) {
    return _then(_$EventsModelImpl(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<EventItemModel>?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confId: freezed == confId ? _value.confId! : confId,
    ));
  }
}

/// @nodoc

class _$EventsModelImpl extends _EventsModel {
  const _$EventsModelImpl(
      {@HiveField(0) required final List<EventItemModel>? items,
      @HiveField(1) this.lastUpdate,
      @HiveField(2) this.confId})
      : _items = items,
        super._();

  final List<EventItemModel>? _items;
  @override
  @HiveField(0)
  List<EventItemModel>? get items {
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
    return 'EventsModel(items: $items, lastUpdate: $lastUpdate, confId: $confId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventsModelImpl &&
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

  /// Create a copy of EventsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventsModelImplCopyWith<_$EventsModelImpl> get copyWith =>
      __$$EventsModelImplCopyWithImpl<_$EventsModelImpl>(this, _$identity);
}

abstract class _EventsModel extends EventsModel {
  const factory _EventsModel(
      {@HiveField(0) required final List<EventItemModel>? items,
      @HiveField(1) final DateTime? lastUpdate,
      @HiveField(2) final dynamic confId}) = _$EventsModelImpl;
  const _EventsModel._() : super._();

  @override
  @HiveField(0)
  List<EventItemModel>? get items;
  @override
  @HiveField(1)
  DateTime? get lastUpdate;
  @override
  @HiveField(2)
  dynamic get confId;

  /// Create a copy of EventsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventsModelImplCopyWith<_$EventsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
