// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workshop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Workshop {
  String get title => throw _privateConstructorUsedError;
  String get confId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  String get locationDescription => throw _privateConstructorUsedError;
  Speaker get speaker => throw _privateConstructorUsedError;
  int? get pricePln => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WorkshopCopyWith<Workshop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkshopCopyWith<$Res> {
  factory $WorkshopCopyWith(Workshop value, $Res Function(Workshop) then) =
      _$WorkshopCopyWithImpl<$Res, Workshop>;
  @useResult
  $Res call(
      {String title,
      String confId,
      String description,
      String startDate,
      String endDate,
      String locationDescription,
      Speaker speaker,
      int? pricePln});

  $SpeakerCopyWith<$Res> get speaker;
}

/// @nodoc
class _$WorkshopCopyWithImpl<$Res, $Val extends Workshop>
    implements $WorkshopCopyWith<$Res> {
  _$WorkshopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? confId = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? locationDescription = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      locationDescription: null == locationDescription
          ? _value.locationDescription
          : locationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as Speaker,
      pricePln: freezed == pricePln
          ? _value.pricePln
          : pricePln // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SpeakerCopyWith<$Res> get speaker {
    return $SpeakerCopyWith<$Res>(_value.speaker, (value) {
      return _then(_value.copyWith(speaker: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WorkshopCopyWith<$Res> implements $WorkshopCopyWith<$Res> {
  factory _$$_WorkshopCopyWith(
          _$_Workshop value, $Res Function(_$_Workshop) then) =
      __$$_WorkshopCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String confId,
      String description,
      String startDate,
      String endDate,
      String locationDescription,
      Speaker speaker,
      int? pricePln});

  @override
  $SpeakerCopyWith<$Res> get speaker;
}

/// @nodoc
class __$$_WorkshopCopyWithImpl<$Res>
    extends _$WorkshopCopyWithImpl<$Res, _$_Workshop>
    implements _$$_WorkshopCopyWith<$Res> {
  __$$_WorkshopCopyWithImpl(
      _$_Workshop _value, $Res Function(_$_Workshop) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? confId = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? locationDescription = null,
    Object? speaker = null,
    Object? pricePln = freezed,
  }) {
    return _then(_$_Workshop(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      locationDescription: null == locationDescription
          ? _value.locationDescription
          : locationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as Speaker,
      pricePln: freezed == pricePln
          ? _value.pricePln
          : pricePln // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_Workshop extends _Workshop {
  const _$_Workshop(
      {required this.title,
      required this.confId,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.locationDescription,
      required this.speaker,
      required this.pricePln})
      : super._();

  @override
  final String title;
  @override
  final String confId;
  @override
  final String description;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final String locationDescription;
  @override
  final Speaker speaker;
  @override
  final int? pricePln;

  @override
  String toString() {
    return 'Workshop(title: $title, confId: $confId, description: $description, startDate: $startDate, endDate: $endDate, locationDescription: $locationDescription, speaker: $speaker, pricePln: $pricePln)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Workshop &&
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WorkshopCopyWith<_$_Workshop> get copyWith =>
      __$$_WorkshopCopyWithImpl<_$_Workshop>(this, _$identity);
}

abstract class _Workshop extends Workshop {
  const factory _Workshop(
      {required final String title,
      required final String confId,
      required final String description,
      required final String startDate,
      required final String endDate,
      required final String locationDescription,
      required final Speaker speaker,
      required final int? pricePln}) = _$_Workshop;
  const _Workshop._() : super._();

  @override
  String get title;
  @override
  String get confId;
  @override
  String get description;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  String get locationDescription;
  @override
  Speaker get speaker;
  @override
  int? get pricePln;
  @override
  @JsonKey(ignore: true)
  _$$_WorkshopCopyWith<_$_Workshop> get copyWith =>
      throw _privateConstructorUsedError;
}
