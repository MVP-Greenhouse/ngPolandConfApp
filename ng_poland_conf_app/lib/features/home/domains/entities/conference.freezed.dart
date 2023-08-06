// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Conference {
  String get confId => throw _privateConstructorUsedError;
  String get confName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get conferencesStartDate => throw _privateConstructorUsedError;
  List<ConferenceItem> get listItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConferenceCopyWith<Conference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConferenceCopyWith<$Res> {
  factory $ConferenceCopyWith(
          Conference value, $Res Function(Conference) then) =
      _$ConferenceCopyWithImpl<$Res, Conference>;
  @useResult
  $Res call(
      {String confId,
      String confName,
      String description,
      String? conferencesStartDate,
      List<ConferenceItem> listItems});
}

/// @nodoc
class _$ConferenceCopyWithImpl<$Res, $Val extends Conference>
    implements $ConferenceCopyWith<$Res> {
  _$ConferenceCopyWithImpl(this._value, this._then);

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
    Object? listItems = null,
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
      listItems: null == listItems
          ? _value.listItems
          : listItems // ignore: cast_nullable_to_non_nullable
              as List<ConferenceItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConferenceCopyWith<$Res>
    implements $ConferenceCopyWith<$Res> {
  factory _$$_ConferenceCopyWith(
          _$_Conference value, $Res Function(_$_Conference) then) =
      __$$_ConferenceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String confId,
      String confName,
      String description,
      String? conferencesStartDate,
      List<ConferenceItem> listItems});
}

/// @nodoc
class __$$_ConferenceCopyWithImpl<$Res>
    extends _$ConferenceCopyWithImpl<$Res, _$_Conference>
    implements _$$_ConferenceCopyWith<$Res> {
  __$$_ConferenceCopyWithImpl(
      _$_Conference _value, $Res Function(_$_Conference) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confId = null,
    Object? confName = null,
    Object? description = null,
    Object? conferencesStartDate = freezed,
    Object? listItems = null,
  }) {
    return _then(_$_Conference(
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
      listItems: null == listItems
          ? _value._listItems
          : listItems // ignore: cast_nullable_to_non_nullable
              as List<ConferenceItem>,
    ));
  }
}

/// @nodoc

class _$_Conference implements _Conference {
  const _$_Conference(
      {required this.confId,
      required this.confName,
      required this.description,
      this.conferencesStartDate,
      required final List<ConferenceItem> listItems})
      : _listItems = listItems;

  @override
  final String confId;
  @override
  final String confName;
  @override
  final String description;
  @override
  final String? conferencesStartDate;
  final List<ConferenceItem> _listItems;
  @override
  List<ConferenceItem> get listItems {
    if (_listItems is EqualUnmodifiableListView) return _listItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listItems);
  }

  @override
  String toString() {
    return 'Conference(confId: $confId, confName: $confName, description: $description, conferencesStartDate: $conferencesStartDate, listItems: $listItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Conference &&
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

  @override
  int get hashCode => Object.hash(runtimeType, confId, confName, description,
      conferencesStartDate, const DeepCollectionEquality().hash(_listItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConferenceCopyWith<_$_Conference> get copyWith =>
      __$$_ConferenceCopyWithImpl<_$_Conference>(this, _$identity);
}

abstract class _Conference implements Conference {
  const factory _Conference(
      {required final String confId,
      required final String confName,
      required final String description,
      final String? conferencesStartDate,
      required final List<ConferenceItem> listItems}) = _$_Conference;

  @override
  String get confId;
  @override
  String get confName;
  @override
  String get description;
  @override
  String? get conferencesStartDate;
  @override
  List<ConferenceItem> get listItems;
  @override
  @JsonKey(ignore: true)
  _$$_ConferenceCopyWith<_$_Conference> get copyWith =>
      throw _privateConstructorUsedError;
}
