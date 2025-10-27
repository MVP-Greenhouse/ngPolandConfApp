// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workshop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Workshop {

 String get title; String get confId; String? get description; String get startDate; String get endDate; String? get locationDescription; Speaker get speaker; int? get pricePln;
/// Create a copy of Workshop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkshopCopyWith<Workshop> get copyWith => _$WorkshopCopyWithImpl<Workshop>(this as Workshop, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Workshop&&(identical(other.title, title) || other.title == title)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.locationDescription, locationDescription) || other.locationDescription == locationDescription)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.pricePln, pricePln) || other.pricePln == pricePln));
}


@override
int get hashCode => Object.hash(runtimeType,title,confId,description,startDate,endDate,locationDescription,speaker,pricePln);

@override
String toString() {
  return 'Workshop(title: $title, confId: $confId, description: $description, startDate: $startDate, endDate: $endDate, locationDescription: $locationDescription, speaker: $speaker, pricePln: $pricePln)';
}


}

/// @nodoc
abstract mixin class $WorkshopCopyWith<$Res>  {
  factory $WorkshopCopyWith(Workshop value, $Res Function(Workshop) _then) = _$WorkshopCopyWithImpl;
@useResult
$Res call({
 String title, String confId, String? description, String startDate, String endDate, String? locationDescription, Speaker speaker, int? pricePln
});


$SpeakerCopyWith<$Res> get speaker;

}
/// @nodoc
class _$WorkshopCopyWithImpl<$Res>
    implements $WorkshopCopyWith<$Res> {
  _$WorkshopCopyWithImpl(this._self, this._then);

  final Workshop _self;
  final $Res Function(Workshop) _then;

/// Create a copy of Workshop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? confId = null,Object? description = freezed,Object? startDate = null,Object? endDate = null,Object? locationDescription = freezed,Object? speaker = null,Object? pricePln = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,locationDescription: freezed == locationDescription ? _self.locationDescription : locationDescription // ignore: cast_nullable_to_non_nullable
as String?,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as Speaker,pricePln: freezed == pricePln ? _self.pricePln : pricePln // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of Workshop
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerCopyWith<$Res> get speaker {
  
  return $SpeakerCopyWith<$Res>(_self.speaker, (value) {
    return _then(_self.copyWith(speaker: value));
  });
}
}


/// Adds pattern-matching-related methods to [Workshop].
extension WorkshopPatterns on Workshop {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Workshop value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Workshop() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Workshop value)  $default,){
final _that = this;
switch (_that) {
case _Workshop():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Workshop value)?  $default,){
final _that = this;
switch (_that) {
case _Workshop() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String confId,  String? description,  String startDate,  String endDate,  String? locationDescription,  Speaker speaker,  int? pricePln)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Workshop() when $default != null:
return $default(_that.title,_that.confId,_that.description,_that.startDate,_that.endDate,_that.locationDescription,_that.speaker,_that.pricePln);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String confId,  String? description,  String startDate,  String endDate,  String? locationDescription,  Speaker speaker,  int? pricePln)  $default,) {final _that = this;
switch (_that) {
case _Workshop():
return $default(_that.title,_that.confId,_that.description,_that.startDate,_that.endDate,_that.locationDescription,_that.speaker,_that.pricePln);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String confId,  String? description,  String startDate,  String endDate,  String? locationDescription,  Speaker speaker,  int? pricePln)?  $default,) {final _that = this;
switch (_that) {
case _Workshop() when $default != null:
return $default(_that.title,_that.confId,_that.description,_that.startDate,_that.endDate,_that.locationDescription,_that.speaker,_that.pricePln);case _:
  return null;

}
}

}

/// @nodoc


class _Workshop extends Workshop {
  const _Workshop({required this.title, required this.confId, required this.description, required this.startDate, required this.endDate, required this.locationDescription, required this.speaker, required this.pricePln}): super._();
  

@override final  String title;
@override final  String confId;
@override final  String? description;
@override final  String startDate;
@override final  String endDate;
@override final  String? locationDescription;
@override final  Speaker speaker;
@override final  int? pricePln;

/// Create a copy of Workshop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkshopCopyWith<_Workshop> get copyWith => __$WorkshopCopyWithImpl<_Workshop>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Workshop&&(identical(other.title, title) || other.title == title)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.locationDescription, locationDescription) || other.locationDescription == locationDescription)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.pricePln, pricePln) || other.pricePln == pricePln));
}


@override
int get hashCode => Object.hash(runtimeType,title,confId,description,startDate,endDate,locationDescription,speaker,pricePln);

@override
String toString() {
  return 'Workshop(title: $title, confId: $confId, description: $description, startDate: $startDate, endDate: $endDate, locationDescription: $locationDescription, speaker: $speaker, pricePln: $pricePln)';
}


}

/// @nodoc
abstract mixin class _$WorkshopCopyWith<$Res> implements $WorkshopCopyWith<$Res> {
  factory _$WorkshopCopyWith(_Workshop value, $Res Function(_Workshop) _then) = __$WorkshopCopyWithImpl;
@override @useResult
$Res call({
 String title, String confId, String? description, String startDate, String endDate, String? locationDescription, Speaker speaker, int? pricePln
});


@override $SpeakerCopyWith<$Res> get speaker;

}
/// @nodoc
class __$WorkshopCopyWithImpl<$Res>
    implements _$WorkshopCopyWith<$Res> {
  __$WorkshopCopyWithImpl(this._self, this._then);

  final _Workshop _self;
  final $Res Function(_Workshop) _then;

/// Create a copy of Workshop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? confId = null,Object? description = freezed,Object? startDate = null,Object? endDate = null,Object? locationDescription = freezed,Object? speaker = null,Object? pricePln = freezed,}) {
  return _then(_Workshop(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,locationDescription: freezed == locationDescription ? _self.locationDescription : locationDescription // ignore: cast_nullable_to_non_nullable
as String?,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as Speaker,pricePln: freezed == pricePln ? _self.pricePln : pricePln // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of Workshop
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerCopyWith<$Res> get speaker {
  
  return $SpeakerCopyWith<$Res>(_self.speaker, (value) {
    return _then(_self.copyWith(speaker: value));
  });
}
}

// dart format on
