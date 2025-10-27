// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventItemModel {

@HiveField(0) String get id;@HiveField(1) String get title;@HiveField(2) String get confId;@HiveField(3) String get type;@HiveField(4) String get category;@HiveField(5) String? get shortDescription;@HiveField(6) String? get description;@HiveField(7) String get startDate;@HiveField(8) String get endDate;@HiveField(9) SpeakerModel? get speaker;
/// Create a copy of EventItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventItemModelCopyWith<EventItemModel> get copyWith => _$EventItemModelCopyWithImpl<EventItemModel>(this as EventItemModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.speaker, speaker) || other.speaker == speaker));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,confId,type,category,shortDescription,description,startDate,endDate,speaker);

@override
String toString() {
  return 'EventItemModel(id: $id, title: $title, confId: $confId, type: $type, category: $category, shortDescription: $shortDescription, description: $description, startDate: $startDate, endDate: $endDate, speaker: $speaker)';
}


}

/// @nodoc
abstract mixin class $EventItemModelCopyWith<$Res>  {
  factory $EventItemModelCopyWith(EventItemModel value, $Res Function(EventItemModel) _then) = _$EventItemModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String title,@HiveField(2) String confId,@HiveField(3) String type,@HiveField(4) String category,@HiveField(5) String? shortDescription,@HiveField(6) String? description,@HiveField(7) String startDate,@HiveField(8) String endDate,@HiveField(9) SpeakerModel? speaker
});


$SpeakerModelCopyWith<$Res>? get speaker;

}
/// @nodoc
class _$EventItemModelCopyWithImpl<$Res>
    implements $EventItemModelCopyWith<$Res> {
  _$EventItemModelCopyWithImpl(this._self, this._then);

  final EventItemModel _self;
  final $Res Function(EventItemModel) _then;

/// Create a copy of EventItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? confId = null,Object? type = null,Object? category = null,Object? shortDescription = freezed,Object? description = freezed,Object? startDate = null,Object? endDate = null,Object? speaker = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,speaker: freezed == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as SpeakerModel?,
  ));
}
/// Create a copy of EventItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerModelCopyWith<$Res>? get speaker {
    if (_self.speaker == null) {
    return null;
  }

  return $SpeakerModelCopyWith<$Res>(_self.speaker!, (value) {
    return _then(_self.copyWith(speaker: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventItemModel].
extension EventItemModelPatterns on EventItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventItemModel value)  $default,){
final _that = this;
switch (_that) {
case _EventItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _EventItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String confId, @HiveField(3)  String type, @HiveField(4)  String category, @HiveField(5)  String? shortDescription, @HiveField(6)  String? description, @HiveField(7)  String startDate, @HiveField(8)  String endDate, @HiveField(9)  SpeakerModel? speaker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventItemModel() when $default != null:
return $default(_that.id,_that.title,_that.confId,_that.type,_that.category,_that.shortDescription,_that.description,_that.startDate,_that.endDate,_that.speaker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String confId, @HiveField(3)  String type, @HiveField(4)  String category, @HiveField(5)  String? shortDescription, @HiveField(6)  String? description, @HiveField(7)  String startDate, @HiveField(8)  String endDate, @HiveField(9)  SpeakerModel? speaker)  $default,) {final _that = this;
switch (_that) {
case _EventItemModel():
return $default(_that.id,_that.title,_that.confId,_that.type,_that.category,_that.shortDescription,_that.description,_that.startDate,_that.endDate,_that.speaker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String confId, @HiveField(3)  String type, @HiveField(4)  String category, @HiveField(5)  String? shortDescription, @HiveField(6)  String? description, @HiveField(7)  String startDate, @HiveField(8)  String endDate, @HiveField(9)  SpeakerModel? speaker)?  $default,) {final _that = this;
switch (_that) {
case _EventItemModel() when $default != null:
return $default(_that.id,_that.title,_that.confId,_that.type,_that.category,_that.shortDescription,_that.description,_that.startDate,_that.endDate,_that.speaker);case _:
  return null;

}
}

}

/// @nodoc


class _EventItemModel extends EventItemModel {
  const _EventItemModel({@HiveField(0) required this.id, @HiveField(1) required this.title, @HiveField(2) required this.confId, @HiveField(3) required this.type, @HiveField(4) required this.category, @HiveField(5) this.shortDescription, @HiveField(6) this.description, @HiveField(7) required this.startDate, @HiveField(8) required this.endDate, @HiveField(9) required this.speaker}): super._();
  

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String title;
@override@HiveField(2) final  String confId;
@override@HiveField(3) final  String type;
@override@HiveField(4) final  String category;
@override@HiveField(5) final  String? shortDescription;
@override@HiveField(6) final  String? description;
@override@HiveField(7) final  String startDate;
@override@HiveField(8) final  String endDate;
@override@HiveField(9) final  SpeakerModel? speaker;

/// Create a copy of EventItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventItemModelCopyWith<_EventItemModel> get copyWith => __$EventItemModelCopyWithImpl<_EventItemModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.speaker, speaker) || other.speaker == speaker));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,confId,type,category,shortDescription,description,startDate,endDate,speaker);

@override
String toString() {
  return 'EventItemModel(id: $id, title: $title, confId: $confId, type: $type, category: $category, shortDescription: $shortDescription, description: $description, startDate: $startDate, endDate: $endDate, speaker: $speaker)';
}


}

/// @nodoc
abstract mixin class _$EventItemModelCopyWith<$Res> implements $EventItemModelCopyWith<$Res> {
  factory _$EventItemModelCopyWith(_EventItemModel value, $Res Function(_EventItemModel) _then) = __$EventItemModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String title,@HiveField(2) String confId,@HiveField(3) String type,@HiveField(4) String category,@HiveField(5) String? shortDescription,@HiveField(6) String? description,@HiveField(7) String startDate,@HiveField(8) String endDate,@HiveField(9) SpeakerModel? speaker
});


@override $SpeakerModelCopyWith<$Res>? get speaker;

}
/// @nodoc
class __$EventItemModelCopyWithImpl<$Res>
    implements _$EventItemModelCopyWith<$Res> {
  __$EventItemModelCopyWithImpl(this._self, this._then);

  final _EventItemModel _self;
  final $Res Function(_EventItemModel) _then;

/// Create a copy of EventItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? confId = null,Object? type = null,Object? category = null,Object? shortDescription = freezed,Object? description = freezed,Object? startDate = null,Object? endDate = null,Object? speaker = freezed,}) {
  return _then(_EventItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,speaker: freezed == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as SpeakerModel?,
  ));
}

/// Create a copy of EventItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerModelCopyWith<$Res>? get speaker {
    if (_self.speaker == null) {
    return null;
  }

  return $SpeakerModelCopyWith<$Res>(_self.speaker!, (value) {
    return _then(_self.copyWith(speaker: value));
  });
}
}

// dart format on
