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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SpeakersModel {
  @HiveField(0)
  List<SpeakerModel>? get items => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime? get lastUpdate => throw _privateConstructorUsedError;
  @HiveField(2)
  dynamic get confId => throw _privateConstructorUsedError;

  /// Create a copy of SpeakersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpeakersModelCopyWith<SpeakersModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeakersModelCopyWith<$Res> {
  factory $SpeakersModelCopyWith(
          SpeakersModel value, $Res Function(SpeakersModel) then) =
      _$SpeakersModelCopyWithImpl<$Res, SpeakersModel>;
  @useResult
  $Res call(
      {@HiveField(0) List<SpeakerModel>? items,
      @HiveField(1) DateTime? lastUpdate,
      @HiveField(2) dynamic confId});
}

/// @nodoc
class _$SpeakersModelCopyWithImpl<$Res, $Val extends SpeakersModel>
    implements $SpeakersModelCopyWith<$Res> {
  _$SpeakersModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpeakersModel
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
              as List<SpeakerModel>?,
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
abstract class _$$SpeakersModelImplCopyWith<$Res>
    implements $SpeakersModelCopyWith<$Res> {
  factory _$$SpeakersModelImplCopyWith(
          _$SpeakersModelImpl value, $Res Function(_$SpeakersModelImpl) then) =
      __$$SpeakersModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<SpeakerModel>? items,
      @HiveField(1) DateTime? lastUpdate,
      @HiveField(2) dynamic confId});
}

/// @nodoc
class __$$SpeakersModelImplCopyWithImpl<$Res>
    extends _$SpeakersModelCopyWithImpl<$Res, _$SpeakersModelImpl>
    implements _$$SpeakersModelImplCopyWith<$Res> {
  __$$SpeakersModelImplCopyWithImpl(
      _$SpeakersModelImpl _value, $Res Function(_$SpeakersModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpeakersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? lastUpdate = freezed,
    Object? confId = freezed,
  }) {
    return _then(_$SpeakersModelImpl(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SpeakerModel>?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confId: freezed == confId ? _value.confId! : confId,
    ));
  }
}

/// @nodoc

class _$SpeakersModelImpl extends _SpeakersModel {
  const _$SpeakersModelImpl(
      {@HiveField(0) final List<SpeakerModel>? items,
      @HiveField(1) this.lastUpdate,
      @HiveField(2) this.confId})
      : _items = items,
        super._();

  final List<SpeakerModel>? _items;
  @override
  @HiveField(0)
  List<SpeakerModel>? get items {
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
    return 'SpeakersModel(items: $items, lastUpdate: $lastUpdate, confId: $confId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpeakersModelImpl &&
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

  /// Create a copy of SpeakersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpeakersModelImplCopyWith<_$SpeakersModelImpl> get copyWith =>
      __$$SpeakersModelImplCopyWithImpl<_$SpeakersModelImpl>(this, _$identity);
}

abstract class _SpeakersModel extends SpeakersModel {
  const factory _SpeakersModel(
      {@HiveField(0) final List<SpeakerModel>? items,
      @HiveField(1) final DateTime? lastUpdate,
      @HiveField(2) final dynamic confId}) = _$SpeakersModelImpl;
  const _SpeakersModel._() : super._();

  @override
  @HiveField(0)
  List<SpeakerModel>? get items;
  @override
  @HiveField(1)
  DateTime? get lastUpdate;
  @override
  @HiveField(2)
  dynamic get confId;

  /// Create a copy of SpeakersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpeakersModelImplCopyWith<_$SpeakersModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
