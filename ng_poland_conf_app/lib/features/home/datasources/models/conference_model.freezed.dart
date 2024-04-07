// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conference_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConferenceModel _$ConferenceModelFromJson(Map<String, dynamic> json) {
  return _ConferenceModel.fromJson(json);
}

/// @nodoc
mixin _$ConferenceModel {
  @HiveField(0)
  String get confId => throw _privateConstructorUsedError;
  @HiveField(1)
  String get confName => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get conferencesStartDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
  @HiveField(4)
  List<ConferenceHomePageScheduleItemModel>? get listItems =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConferenceModelCopyWith<ConferenceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConferenceModelCopyWith<$Res> {
  factory $ConferenceModelCopyWith(
          ConferenceModel value, $Res Function(ConferenceModel) then) =
      _$ConferenceModelCopyWithImpl<$Res, ConferenceModel>;
  @useResult
  $Res call(
      {@HiveField(0) String confId,
      @HiveField(1) String confName,
      @HiveField(2) String? description,
      @HiveField(3) String? conferencesStartDate,
      @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
      @HiveField(4)
      List<ConferenceHomePageScheduleItemModel>? listItems});
}

/// @nodoc
class _$ConferenceModelCopyWithImpl<$Res, $Val extends ConferenceModel>
    implements $ConferenceModelCopyWith<$Res> {
  _$ConferenceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confId = null,
    Object? confName = null,
    Object? description = freezed,
    Object? conferencesStartDate = freezed,
    Object? listItems = freezed,
  }) {
    return _then(_value.copyWith(
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      confName: null == confName
          ? _value.confName
          : confName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      conferencesStartDate: freezed == conferencesStartDate
          ? _value.conferencesStartDate
          : conferencesStartDate // ignore: cast_nullable_to_non_nullable
              as String?,
      listItems: freezed == listItems
          ? _value.listItems
          : listItems // ignore: cast_nullable_to_non_nullable
              as List<ConferenceHomePageScheduleItemModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConferenceModelImplCopyWith<$Res>
    implements $ConferenceModelCopyWith<$Res> {
  factory _$$ConferenceModelImplCopyWith(_$ConferenceModelImpl value,
          $Res Function(_$ConferenceModelImpl) then) =
      __$$ConferenceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String confId,
      @HiveField(1) String confName,
      @HiveField(2) String? description,
      @HiveField(3) String? conferencesStartDate,
      @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
      @HiveField(4)
      List<ConferenceHomePageScheduleItemModel>? listItems});
}

/// @nodoc
class __$$ConferenceModelImplCopyWithImpl<$Res>
    extends _$ConferenceModelCopyWithImpl<$Res, _$ConferenceModelImpl>
    implements _$$ConferenceModelImplCopyWith<$Res> {
  __$$ConferenceModelImplCopyWithImpl(
      _$ConferenceModelImpl _value, $Res Function(_$ConferenceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confId = null,
    Object? confName = null,
    Object? description = freezed,
    Object? conferencesStartDate = freezed,
    Object? listItems = freezed,
  }) {
    return _then(_$ConferenceModelImpl(
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      confName: null == confName
          ? _value.confName
          : confName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      conferencesStartDate: freezed == conferencesStartDate
          ? _value.conferencesStartDate
          : conferencesStartDate // ignore: cast_nullable_to_non_nullable
              as String?,
      listItems: freezed == listItems
          ? _value._listItems
          : listItems // ignore: cast_nullable_to_non_nullable
              as List<ConferenceHomePageScheduleItemModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConferenceModelImpl extends _ConferenceModel {
  const _$ConferenceModelImpl(
      {@HiveField(0) required this.confId,
      @HiveField(1) required this.confName,
      @HiveField(2) this.description,
      @HiveField(3) this.conferencesStartDate,
      @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
      @HiveField(4)
      final List<ConferenceHomePageScheduleItemModel>? listItems})
      : _listItems = listItems,
        super._();

  factory _$ConferenceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConferenceModelImplFromJson(json);

  @override
  @HiveField(0)
  final String confId;
  @override
  @HiveField(1)
  final String confName;
  @override
  @HiveField(2)
  final String? description;
  @override
  @HiveField(3)
  final String? conferencesStartDate;
  final List<ConferenceHomePageScheduleItemModel>? _listItems;
  @override
  @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
  @HiveField(4)
  List<ConferenceHomePageScheduleItemModel>? get listItems {
    final value = _listItems;
    if (value == null) return null;
    if (_listItems is EqualUnmodifiableListView) return _listItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ConferenceModel(confId: $confId, confName: $confName, description: $description, conferencesStartDate: $conferencesStartDate, listItems: $listItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConferenceModelImpl &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.confName, confName) ||
                other.confName == confName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.conferencesStartDate, conferencesStartDate) ||
                other.conferencesStartDate == conferencesStartDate) &&
            const DeepCollectionEquality()
                .equals(other._listItems, _listItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, confId, confName, description,
      conferencesStartDate, const DeepCollectionEquality().hash(_listItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConferenceModelImplCopyWith<_$ConferenceModelImpl> get copyWith =>
      __$$ConferenceModelImplCopyWithImpl<_$ConferenceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConferenceModelImplToJson(
      this,
    );
  }
}

abstract class _ConferenceModel extends ConferenceModel {
  const factory _ConferenceModel(
          {@HiveField(0) required final String confId,
          @HiveField(1) required final String confName,
          @HiveField(2) final String? description,
          @HiveField(3) final String? conferencesStartDate,
          @JsonKey(
              name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
          @HiveField(4)
          final List<ConferenceHomePageScheduleItemModel>? listItems}) =
      _$ConferenceModelImpl;
  const _ConferenceModel._() : super._();

  factory _ConferenceModel.fromJson(Map<String, dynamic> json) =
      _$ConferenceModelImpl.fromJson;

  @override
  @HiveField(0)
  String get confId;
  @override
  @HiveField(1)
  String get confName;
  @override
  @HiveField(2)
  String? get description;
  @override
  @HiveField(3)
  String? get conferencesStartDate;
  @override
  @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
  @HiveField(4)
  List<ConferenceHomePageScheduleItemModel>? get listItems;
  @override
  @JsonKey(ignore: true)
  _$$ConferenceModelImplCopyWith<_$ConferenceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
