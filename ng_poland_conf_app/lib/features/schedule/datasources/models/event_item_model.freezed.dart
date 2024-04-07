// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventItemModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get confId => throw _privateConstructorUsedError;
  @HiveField(3)
  String get type => throw _privateConstructorUsedError;
  @HiveField(4)
  String get category => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get shortDescription => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(7)
  String get startDate => throw _privateConstructorUsedError;
  @HiveField(8)
  String get endDate => throw _privateConstructorUsedError;
  @HiveField(9)
  SpeakerModel? get speaker => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventItemModelCopyWith<EventItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventItemModelCopyWith<$Res> {
  factory $EventItemModelCopyWith(
          EventItemModel value, $Res Function(EventItemModel) then) =
      _$EventItemModelCopyWithImpl<$Res, EventItemModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String confId,
      @HiveField(3) String type,
      @HiveField(4) String category,
      @HiveField(5) String? shortDescription,
      @HiveField(6) String? description,
      @HiveField(7) String startDate,
      @HiveField(8) String endDate,
      @HiveField(9) SpeakerModel? speaker});

  $SpeakerModelCopyWith<$Res>? get speaker;
}

/// @nodoc
class _$EventItemModelCopyWithImpl<$Res, $Val extends EventItemModel>
    implements $EventItemModelCopyWith<$Res> {
  _$EventItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? confId = null,
    Object? type = null,
    Object? category = null,
    Object? shortDescription = freezed,
    Object? description = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? speaker = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: freezed == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
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
      speaker: freezed == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as SpeakerModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SpeakerModelCopyWith<$Res>? get speaker {
    if (_value.speaker == null) {
      return null;
    }

    return $SpeakerModelCopyWith<$Res>(_value.speaker!, (value) {
      return _then(_value.copyWith(speaker: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EventItemModelImplCopyWith<$Res>
    implements $EventItemModelCopyWith<$Res> {
  factory _$$EventItemModelImplCopyWith(_$EventItemModelImpl value,
          $Res Function(_$EventItemModelImpl) then) =
      __$$EventItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String confId,
      @HiveField(3) String type,
      @HiveField(4) String category,
      @HiveField(5) String? shortDescription,
      @HiveField(6) String? description,
      @HiveField(7) String startDate,
      @HiveField(8) String endDate,
      @HiveField(9) SpeakerModel? speaker});

  @override
  $SpeakerModelCopyWith<$Res>? get speaker;
}

/// @nodoc
class __$$EventItemModelImplCopyWithImpl<$Res>
    extends _$EventItemModelCopyWithImpl<$Res, _$EventItemModelImpl>
    implements _$$EventItemModelImplCopyWith<$Res> {
  __$$EventItemModelImplCopyWithImpl(
      _$EventItemModelImpl _value, $Res Function(_$EventItemModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? confId = null,
    Object? type = null,
    Object? category = null,
    Object? shortDescription = freezed,
    Object? description = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? speaker = freezed,
  }) {
    return _then(_$EventItemModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: freezed == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
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
      speaker: freezed == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as SpeakerModel?,
    ));
  }
}

/// @nodoc

class _$EventItemModelImpl extends _EventItemModel {
  const _$EventItemModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.confId,
      @HiveField(3) required this.type,
      @HiveField(4) required this.category,
      @HiveField(5) this.shortDescription,
      @HiveField(6) this.description,
      @HiveField(7) required this.startDate,
      @HiveField(8) required this.endDate,
      @HiveField(9) required this.speaker})
      : super._();

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final String confId;
  @override
  @HiveField(3)
  final String type;
  @override
  @HiveField(4)
  final String category;
  @override
  @HiveField(5)
  final String? shortDescription;
  @override
  @HiveField(6)
  final String? description;
  @override
  @HiveField(7)
  final String startDate;
  @override
  @HiveField(8)
  final String endDate;
  @override
  @HiveField(9)
  final SpeakerModel? speaker;

  @override
  String toString() {
    return 'EventItemModel(id: $id, title: $title, confId: $confId, type: $type, category: $category, shortDescription: $shortDescription, description: $description, startDate: $startDate, endDate: $endDate, speaker: $speaker)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.speaker, speaker) || other.speaker == speaker));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, confId, type,
      category, shortDescription, description, startDate, endDate, speaker);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventItemModelImplCopyWith<_$EventItemModelImpl> get copyWith =>
      __$$EventItemModelImplCopyWithImpl<_$EventItemModelImpl>(
          this, _$identity);
}

abstract class _EventItemModel extends EventItemModel {
  const factory _EventItemModel(
          {@HiveField(0) required final String id,
          @HiveField(1) required final String title,
          @HiveField(2) required final String confId,
          @HiveField(3) required final String type,
          @HiveField(4) required final String category,
          @HiveField(5) final String? shortDescription,
          @HiveField(6) final String? description,
          @HiveField(7) required final String startDate,
          @HiveField(8) required final String endDate,
          @HiveField(9) required final SpeakerModel? speaker}) =
      _$EventItemModelImpl;
  const _EventItemModel._() : super._();

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get title;
  @override
  @HiveField(2)
  String get confId;
  @override
  @HiveField(3)
  String get type;
  @override
  @HiveField(4)
  String get category;
  @override
  @HiveField(5)
  String? get shortDescription;
  @override
  @HiveField(6)
  String? get description;
  @override
  @HiveField(7)
  String get startDate;
  @override
  @HiveField(8)
  String get endDate;
  @override
  @HiveField(9)
  SpeakerModel? get speaker;
  @override
  @JsonKey(ignore: true)
  _$$EventItemModelImplCopyWith<_$EventItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
