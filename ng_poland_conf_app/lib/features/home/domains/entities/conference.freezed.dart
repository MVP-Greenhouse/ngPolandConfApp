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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Conference {
  String get confId => throw _privateConstructorUsedError;
  String get confName => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get conferencesStartDate => throw _privateConstructorUsedError;
  List<ConferenceItem> get listItems => throw _privateConstructorUsedError;

  /// Create a copy of Conference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      bool isCurrent,
      String? description,
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

  /// Create a copy of Conference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confId = null,
    Object? confName = null,
    Object? isCurrent = null,
    Object? description = freezed,
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
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$ConferenceImplCopyWith<$Res>
    implements $ConferenceCopyWith<$Res> {
  factory _$$ConferenceImplCopyWith(
          _$ConferenceImpl value, $Res Function(_$ConferenceImpl) then) =
      __$$ConferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String confId,
      String confName,
      bool isCurrent,
      String? description,
      String? conferencesStartDate,
      List<ConferenceItem> listItems});
}

/// @nodoc
class __$$ConferenceImplCopyWithImpl<$Res>
    extends _$ConferenceCopyWithImpl<$Res, _$ConferenceImpl>
    implements _$$ConferenceImplCopyWith<$Res> {
  __$$ConferenceImplCopyWithImpl(
      _$ConferenceImpl _value, $Res Function(_$ConferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Conference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confId = null,
    Object? confName = null,
    Object? isCurrent = null,
    Object? description = freezed,
    Object? conferencesStartDate = freezed,
    Object? listItems = null,
  }) {
    return _then(_$ConferenceImpl(
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      confName: null == confName
          ? _value.confName
          : confName // ignore: cast_nullable_to_non_nullable
              as String,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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

class _$ConferenceImpl implements _Conference {
  const _$ConferenceImpl(
      {required this.confId,
      required this.confName,
      this.isCurrent = false,
      this.description,
      this.conferencesStartDate,
      required final List<ConferenceItem> listItems})
      : _listItems = listItems;

  @override
  final String confId;
  @override
  final String confName;
  @override
  @JsonKey()
  final bool isCurrent;
  @override
  final String? description;
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
    return 'Conference(confId: $confId, confName: $confName, isCurrent: $isCurrent, description: $description, conferencesStartDate: $conferencesStartDate, listItems: $listItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConferenceImpl &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.confName, confName) ||
                other.confName == confName) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.conferencesStartDate, conferencesStartDate) ||
                other.conferencesStartDate == conferencesStartDate) &&
            const DeepCollectionEquality()
                .equals(other._listItems, _listItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      confId,
      confName,
      isCurrent,
      description,
      conferencesStartDate,
      const DeepCollectionEquality().hash(_listItems));

  /// Create a copy of Conference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConferenceImplCopyWith<_$ConferenceImpl> get copyWith =>
      __$$ConferenceImplCopyWithImpl<_$ConferenceImpl>(this, _$identity);
}

abstract class _Conference implements Conference {
  const factory _Conference(
      {required final String confId,
      required final String confName,
      final bool isCurrent,
      final String? description,
      final String? conferencesStartDate,
      required final List<ConferenceItem> listItems}) = _$ConferenceImpl;

  @override
  String get confId;
  @override
  String get confName;
  @override
  bool get isCurrent;
  @override
  String? get description;
  @override
  String? get conferencesStartDate;
  @override
  List<ConferenceItem> get listItems;

  /// Create a copy of Conference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConferenceImplCopyWith<_$ConferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
