// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workshop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorkshopModel {
  @HiveField(0)
  String get title => throw _privateConstructorUsedError;
  @HiveField(1)
  String get confId => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(3)
  String get startDate => throw _privateConstructorUsedError;
  @HiveField(4)
  String get endDate => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get locationDescription => throw _privateConstructorUsedError;
  @HiveField(6)
  SpeakerModel get speaker => throw _privateConstructorUsedError;
  @HiveField(7)
  int? get pricePln => throw _privateConstructorUsedError;

  /// Create a copy of WorkshopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkshopModelCopyWith<WorkshopModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkshopModelCopyWith<$Res> {
  factory $WorkshopModelCopyWith(
          WorkshopModel value, $Res Function(WorkshopModel) then) =
      _$WorkshopModelCopyWithImpl<$Res, WorkshopModel>;
  @useResult
  $Res call(
      {@HiveField(0) String title,
      @HiveField(1) String confId,
      @HiveField(2) String? description,
      @HiveField(3) String startDate,
      @HiveField(4) String endDate,
      @HiveField(5) String? locationDescription,
      @HiveField(6) SpeakerModel speaker,
      @HiveField(7) int? pricePln});

  $SpeakerModelCopyWith<$Res> get speaker;
}

/// @nodoc
class _$WorkshopModelCopyWithImpl<$Res, $Val extends WorkshopModel>
    implements $WorkshopModelCopyWith<$Res> {
  _$WorkshopModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkshopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? confId = null,
    Object? description = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? locationDescription = freezed,
    Object? speaker = null,
    Object? pricePln = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      locationDescription: freezed == locationDescription
          ? _value.locationDescription
          : locationDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as SpeakerModel,
      pricePln: freezed == pricePln
          ? _value.pricePln
          : pricePln // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of WorkshopModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpeakerModelCopyWith<$Res> get speaker {
    return $SpeakerModelCopyWith<$Res>(_value.speaker, (value) {
      return _then(_value.copyWith(speaker: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkshopModelImplCopyWith<$Res>
    implements $WorkshopModelCopyWith<$Res> {
  factory _$$WorkshopModelImplCopyWith(
          _$WorkshopModelImpl value, $Res Function(_$WorkshopModelImpl) then) =
      __$$WorkshopModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String title,
      @HiveField(1) String confId,
      @HiveField(2) String? description,
      @HiveField(3) String startDate,
      @HiveField(4) String endDate,
      @HiveField(5) String? locationDescription,
      @HiveField(6) SpeakerModel speaker,
      @HiveField(7) int? pricePln});

  @override
  $SpeakerModelCopyWith<$Res> get speaker;
}

/// @nodoc
class __$$WorkshopModelImplCopyWithImpl<$Res>
    extends _$WorkshopModelCopyWithImpl<$Res, _$WorkshopModelImpl>
    implements _$$WorkshopModelImplCopyWith<$Res> {
  __$$WorkshopModelImplCopyWithImpl(
      _$WorkshopModelImpl _value, $Res Function(_$WorkshopModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkshopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? confId = null,
    Object? description = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? locationDescription = freezed,
    Object? speaker = null,
    Object? pricePln = freezed,
  }) {
    return _then(_$WorkshopModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      locationDescription: freezed == locationDescription
          ? _value.locationDescription
          : locationDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as SpeakerModel,
      pricePln: freezed == pricePln
          ? _value.pricePln
          : pricePln // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$WorkshopModelImpl extends _WorkshopModel {
  const _$WorkshopModelImpl(
      {@HiveField(0) required this.title,
      @HiveField(1) required this.confId,
      @HiveField(2) required this.description,
      @HiveField(3) required this.startDate,
      @HiveField(4) required this.endDate,
      @HiveField(5) required this.locationDescription,
      @HiveField(6) required this.speaker,
      @HiveField(7) required this.pricePln})
      : super._();

  @override
  @HiveField(0)
  final String title;
  @override
  @HiveField(1)
  final String confId;
  @override
  @HiveField(2)
  final String? description;
  @override
  @HiveField(3)
  final String startDate;
  @override
  @HiveField(4)
  final String endDate;
  @override
  @HiveField(5)
  final String? locationDescription;
  @override
  @HiveField(6)
  final SpeakerModel speaker;
  @override
  @HiveField(7)
  final int? pricePln;

  @override
  String toString() {
    return 'WorkshopModel(title: $title, confId: $confId, description: $description, startDate: $startDate, endDate: $endDate, locationDescription: $locationDescription, speaker: $speaker, pricePln: $pricePln)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkshopModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.locationDescription, locationDescription) ||
                other.locationDescription == locationDescription) &&
            (identical(other.speaker, speaker) || other.speaker == speaker) &&
            (identical(other.pricePln, pricePln) ||
                other.pricePln == pricePln));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, confId, description,
      startDate, endDate, locationDescription, speaker, pricePln);

  /// Create a copy of WorkshopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkshopModelImplCopyWith<_$WorkshopModelImpl> get copyWith =>
      __$$WorkshopModelImplCopyWithImpl<_$WorkshopModelImpl>(this, _$identity);
}

abstract class _WorkshopModel extends WorkshopModel {
  const factory _WorkshopModel(
      {@HiveField(0) required final String title,
      @HiveField(1) required final String confId,
      @HiveField(2) required final String? description,
      @HiveField(3) required final String startDate,
      @HiveField(4) required final String endDate,
      @HiveField(5) required final String? locationDescription,
      @HiveField(6) required final SpeakerModel speaker,
      @HiveField(7) required final int? pricePln}) = _$WorkshopModelImpl;
  const _WorkshopModel._() : super._();

  @override
  @HiveField(0)
  String get title;
  @override
  @HiveField(1)
  String get confId;
  @override
  @HiveField(2)
  String? get description;
  @override
  @HiveField(3)
  String get startDate;
  @override
  @HiveField(4)
  String get endDate;
  @override
  @HiveField(5)
  String? get locationDescription;
  @override
  @HiveField(6)
  SpeakerModel get speaker;
  @override
  @HiveField(7)
  int? get pricePln;

  /// Create a copy of WorkshopModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkshopModelImplCopyWith<_$WorkshopModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
