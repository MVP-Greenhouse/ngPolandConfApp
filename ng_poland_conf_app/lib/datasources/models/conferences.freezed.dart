// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Conferences _$ConferencesFromJson(Map<String, dynamic> json) {
  return _Conferences.fromJson(json);
}

/// @nodoc
mixin _$Conferences {
  String get confId => throw _privateConstructorUsedError;
  String get confName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get conferencesStartDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
  List<ConferenceHomePageScheduleItem>? get listItems =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConferencesCopyWith<Conferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConferencesCopyWith<$Res> {
  factory $ConferencesCopyWith(
          Conferences value, $Res Function(Conferences) then) =
      _$ConferencesCopyWithImpl<$Res, Conferences>;
  @useResult
  $Res call(
      {String confId,
      String confName,
      String description,
      String? conferencesStartDate,
      @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
      List<ConferenceHomePageScheduleItem>? listItems});
}

/// @nodoc
class _$ConferencesCopyWithImpl<$Res, $Val extends Conferences>
    implements $ConferencesCopyWith<$Res> {
  _$ConferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confId = null,
    Object? confName = null,
    Object? description = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      conferencesStartDate: freezed == conferencesStartDate
          ? _value.conferencesStartDate
          : conferencesStartDate // ignore: cast_nullable_to_non_nullable
              as String?,
      listItems: freezed == listItems
          ? _value.listItems
          : listItems // ignore: cast_nullable_to_non_nullable
              as List<ConferenceHomePageScheduleItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConferencesCopyWith<$Res>
    implements $ConferencesCopyWith<$Res> {
  factory _$$_ConferencesCopyWith(
          _$_Conferences value, $Res Function(_$_Conferences) then) =
      __$$_ConferencesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String confId,
      String confName,
      String description,
      String? conferencesStartDate,
      @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
      List<ConferenceHomePageScheduleItem>? listItems});
}

/// @nodoc
class __$$_ConferencesCopyWithImpl<$Res>
    extends _$ConferencesCopyWithImpl<$Res, _$_Conferences>
    implements _$$_ConferencesCopyWith<$Res> {
  __$$_ConferencesCopyWithImpl(
      _$_Conferences _value, $Res Function(_$_Conferences) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confId = null,
    Object? confName = null,
    Object? description = null,
    Object? conferencesStartDate = freezed,
    Object? listItems = freezed,
  }) {
    return _then(_$_Conferences(
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      confName: null == confName
          ? _value.confName
          : confName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      conferencesStartDate: freezed == conferencesStartDate
          ? _value.conferencesStartDate
          : conferencesStartDate // ignore: cast_nullable_to_non_nullable
              as String?,
      listItems: freezed == listItems
          ? _value._listItems
          : listItems // ignore: cast_nullable_to_non_nullable
              as List<ConferenceHomePageScheduleItem>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Conferences implements _Conferences {
  const _$_Conferences(
      {required this.confId,
      required this.confName,
      required this.description,
      this.conferencesStartDate,
      @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
      final List<ConferenceHomePageScheduleItem>? listItems})
      : _listItems = listItems;

  factory _$_Conferences.fromJson(Map<String, dynamic> json) =>
      _$$_ConferencesFromJson(json);

  @override
  final String confId;
  @override
  final String confName;
  @override
  final String description;
  @override
  final String? conferencesStartDate;
  final List<ConferenceHomePageScheduleItem>? _listItems;
  @override
  @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
  List<ConferenceHomePageScheduleItem>? get listItems {
    final value = _listItems;
    if (value == null) return null;
    if (_listItems is EqualUnmodifiableListView) return _listItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Conferences(confId: $confId, confName: $confName, description: $description, conferencesStartDate: $conferencesStartDate, listItems: $listItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Conferences &&
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
  _$$_ConferencesCopyWith<_$_Conferences> get copyWith =>
      __$$_ConferencesCopyWithImpl<_$_Conferences>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConferencesToJson(
      this,
    );
  }
}

abstract class _Conferences implements Conferences {
  const factory _Conferences(
      {required final String confId,
      required final String confName,
      required final String description,
      final String? conferencesStartDate,
      @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
      final List<ConferenceHomePageScheduleItem>? listItems}) = _$_Conferences;

  factory _Conferences.fromJson(Map<String, dynamic> json) =
      _$_Conferences.fromJson;

  @override
  String get confId;
  @override
  String get confName;
  @override
  String get description;
  @override
  String? get conferencesStartDate;
  @override
  @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)
  List<ConferenceHomePageScheduleItem>? get listItems;
  @override
  @JsonKey(ignore: true)
  _$$_ConferencesCopyWith<_$_Conferences> get copyWith =>
      throw _privateConstructorUsedError;
}
