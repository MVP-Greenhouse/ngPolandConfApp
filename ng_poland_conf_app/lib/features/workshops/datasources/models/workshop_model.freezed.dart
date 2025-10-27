// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workshop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkshopModel {

@HiveField(0) String get title;@HiveField(1) String get confId;@HiveField(2) String? get description;@HiveField(3) String get startDate;@HiveField(4) String get endDate;@HiveField(5) String? get locationDescription;@HiveField(6) SpeakerModel get speaker;@HiveField(7) int? get pricePln;
/// Create a copy of WorkshopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkshopModelCopyWith<WorkshopModel> get copyWith => _$WorkshopModelCopyWithImpl<WorkshopModel>(this as WorkshopModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkshopModel&&(identical(other.title, title) || other.title == title)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.locationDescription, locationDescription) || other.locationDescription == locationDescription)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.pricePln, pricePln) || other.pricePln == pricePln));
}


@override
int get hashCode => Object.hash(runtimeType,title,confId,description,startDate,endDate,locationDescription,speaker,pricePln);

@override
String toString() {
  return 'WorkshopModel(title: $title, confId: $confId, description: $description, startDate: $startDate, endDate: $endDate, locationDescription: $locationDescription, speaker: $speaker, pricePln: $pricePln)';
}


}

/// @nodoc
abstract mixin class $WorkshopModelCopyWith<$Res>  {
  factory $WorkshopModelCopyWith(WorkshopModel value, $Res Function(WorkshopModel) _then) = _$WorkshopModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String title,@HiveField(1) String confId,@HiveField(2) String? description,@HiveField(3) String startDate,@HiveField(4) String endDate,@HiveField(5) String? locationDescription,@HiveField(6) SpeakerModel speaker,@HiveField(7) int? pricePln
});


$SpeakerModelCopyWith<$Res> get speaker;

}
/// @nodoc
class _$WorkshopModelCopyWithImpl<$Res>
    implements $WorkshopModelCopyWith<$Res> {
  _$WorkshopModelCopyWithImpl(this._self, this._then);

  final WorkshopModel _self;
  final $Res Function(WorkshopModel) _then;

/// Create a copy of WorkshopModel
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
as SpeakerModel,pricePln: freezed == pricePln ? _self.pricePln : pricePln // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of WorkshopModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerModelCopyWith<$Res> get speaker {
  
  return $SpeakerModelCopyWith<$Res>(_self.speaker, (value) {
    return _then(_self.copyWith(speaker: value));
  });
}
}


/// Adds pattern-matching-related methods to [WorkshopModel].
extension WorkshopModelPatterns on WorkshopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkshopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkshopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkshopModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkshopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkshopModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkshopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String title, @HiveField(1)  String confId, @HiveField(2)  String? description, @HiveField(3)  String startDate, @HiveField(4)  String endDate, @HiveField(5)  String? locationDescription, @HiveField(6)  SpeakerModel speaker, @HiveField(7)  int? pricePln)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkshopModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String title, @HiveField(1)  String confId, @HiveField(2)  String? description, @HiveField(3)  String startDate, @HiveField(4)  String endDate, @HiveField(5)  String? locationDescription, @HiveField(6)  SpeakerModel speaker, @HiveField(7)  int? pricePln)  $default,) {final _that = this;
switch (_that) {
case _WorkshopModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String title, @HiveField(1)  String confId, @HiveField(2)  String? description, @HiveField(3)  String startDate, @HiveField(4)  String endDate, @HiveField(5)  String? locationDescription, @HiveField(6)  SpeakerModel speaker, @HiveField(7)  int? pricePln)?  $default,) {final _that = this;
switch (_that) {
case _WorkshopModel() when $default != null:
return $default(_that.title,_that.confId,_that.description,_that.startDate,_that.endDate,_that.locationDescription,_that.speaker,_that.pricePln);case _:
  return null;

}
}

}

/// @nodoc


class _WorkshopModel extends WorkshopModel {
  const _WorkshopModel({@HiveField(0) required this.title, @HiveField(1) required this.confId, @HiveField(2) required this.description, @HiveField(3) required this.startDate, @HiveField(4) required this.endDate, @HiveField(5) required this.locationDescription, @HiveField(6) required this.speaker, @HiveField(7) required this.pricePln}): super._();
  

@override@HiveField(0) final  String title;
@override@HiveField(1) final  String confId;
@override@HiveField(2) final  String? description;
@override@HiveField(3) final  String startDate;
@override@HiveField(4) final  String endDate;
@override@HiveField(5) final  String? locationDescription;
@override@HiveField(6) final  SpeakerModel speaker;
@override@HiveField(7) final  int? pricePln;

/// Create a copy of WorkshopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkshopModelCopyWith<_WorkshopModel> get copyWith => __$WorkshopModelCopyWithImpl<_WorkshopModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkshopModel&&(identical(other.title, title) || other.title == title)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.locationDescription, locationDescription) || other.locationDescription == locationDescription)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.pricePln, pricePln) || other.pricePln == pricePln));
}


@override
int get hashCode => Object.hash(runtimeType,title,confId,description,startDate,endDate,locationDescription,speaker,pricePln);

@override
String toString() {
  return 'WorkshopModel(title: $title, confId: $confId, description: $description, startDate: $startDate, endDate: $endDate, locationDescription: $locationDescription, speaker: $speaker, pricePln: $pricePln)';
}


}

/// @nodoc
abstract mixin class _$WorkshopModelCopyWith<$Res> implements $WorkshopModelCopyWith<$Res> {
  factory _$WorkshopModelCopyWith(_WorkshopModel value, $Res Function(_WorkshopModel) _then) = __$WorkshopModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String title,@HiveField(1) String confId,@HiveField(2) String? description,@HiveField(3) String startDate,@HiveField(4) String endDate,@HiveField(5) String? locationDescription,@HiveField(6) SpeakerModel speaker,@HiveField(7) int? pricePln
});


@override $SpeakerModelCopyWith<$Res> get speaker;

}
/// @nodoc
class __$WorkshopModelCopyWithImpl<$Res>
    implements _$WorkshopModelCopyWith<$Res> {
  __$WorkshopModelCopyWithImpl(this._self, this._then);

  final _WorkshopModel _self;
  final $Res Function(_WorkshopModel) _then;

/// Create a copy of WorkshopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? confId = null,Object? description = freezed,Object? startDate = null,Object? endDate = null,Object? locationDescription = freezed,Object? speaker = null,Object? pricePln = freezed,}) {
  return _then(_WorkshopModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,locationDescription: freezed == locationDescription ? _self.locationDescription : locationDescription // ignore: cast_nullable_to_non_nullable
as String?,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as SpeakerModel,pricePln: freezed == pricePln ? _self.pricePln : pricePln // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of WorkshopModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerModelCopyWith<$Res> get speaker {
  
  return $SpeakerModelCopyWith<$Res>(_self.speaker, (value) {
    return _then(_self.copyWith(speaker: value));
  });
}
}

// dart format on
