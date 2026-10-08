// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventItem {

 String get id; String get title; String get confId; String get type; String get category; String? get shortDescription; String? get description; DateTime? get startDate; DateTime? get endDate; Speaker? get speaker; List<Speaker> get speakers; bool get isBreak; String get sessionLabel; String get timeLabel; String get icon; String get descriptionHtml;
/// Create a copy of EventItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventItemCopyWith<EventItem> get copyWith => _$EventItemCopyWithImpl<EventItem>(this as EventItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&const DeepCollectionEquality().equals(other.speakers, speakers)&&(identical(other.isBreak, isBreak) || other.isBreak == isBreak)&&(identical(other.sessionLabel, sessionLabel) || other.sessionLabel == sessionLabel)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.descriptionHtml, descriptionHtml) || other.descriptionHtml == descriptionHtml));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,confId,type,category,shortDescription,description,startDate,endDate,speaker,const DeepCollectionEquality().hash(speakers),isBreak,sessionLabel,timeLabel,icon,descriptionHtml);

@override
String toString() {
  return 'EventItem(id: $id, title: $title, confId: $confId, type: $type, category: $category, shortDescription: $shortDescription, description: $description, startDate: $startDate, endDate: $endDate, speaker: $speaker, speakers: $speakers, isBreak: $isBreak, sessionLabel: $sessionLabel, timeLabel: $timeLabel, icon: $icon, descriptionHtml: $descriptionHtml)';
}


}

/// @nodoc
abstract mixin class $EventItemCopyWith<$Res>  {
  factory $EventItemCopyWith(EventItem value, $Res Function(EventItem) _then) = _$EventItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String confId, String type, String category, String? shortDescription, String? description, DateTime? startDate, DateTime? endDate, Speaker? speaker, List<Speaker> speakers, bool isBreak, String sessionLabel, String timeLabel, String icon, String descriptionHtml
});


$SpeakerCopyWith<$Res>? get speaker;

}
/// @nodoc
class _$EventItemCopyWithImpl<$Res>
    implements $EventItemCopyWith<$Res> {
  _$EventItemCopyWithImpl(this._self, this._then);

  final EventItem _self;
  final $Res Function(EventItem) _then;

/// Create a copy of EventItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? confId = null,Object? type = null,Object? category = null,Object? shortDescription = freezed,Object? description = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? speaker = freezed,Object? speakers = null,Object? isBreak = null,Object? sessionLabel = null,Object? timeLabel = null,Object? icon = null,Object? descriptionHtml = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,speaker: freezed == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as Speaker?,speakers: null == speakers ? _self.speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<Speaker>,isBreak: null == isBreak ? _self.isBreak : isBreak // ignore: cast_nullable_to_non_nullable
as bool,sessionLabel: null == sessionLabel ? _self.sessionLabel : sessionLabel // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,descriptionHtml: null == descriptionHtml ? _self.descriptionHtml : descriptionHtml // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of EventItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerCopyWith<$Res>? get speaker {
    if (_self.speaker == null) {
    return null;
  }

  return $SpeakerCopyWith<$Res>(_self.speaker!, (value) {
    return _then(_self.copyWith(speaker: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventItem].
extension EventItemPatterns on EventItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventItem value)  $default,){
final _that = this;
switch (_that) {
case _EventItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventItem value)?  $default,){
final _that = this;
switch (_that) {
case _EventItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String confId,  String type,  String category,  String? shortDescription,  String? description,  DateTime? startDate,  DateTime? endDate,  Speaker? speaker,  List<Speaker> speakers,  bool isBreak,  String sessionLabel,  String timeLabel,  String icon,  String descriptionHtml)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventItem() when $default != null:
return $default(_that.id,_that.title,_that.confId,_that.type,_that.category,_that.shortDescription,_that.description,_that.startDate,_that.endDate,_that.speaker,_that.speakers,_that.isBreak,_that.sessionLabel,_that.timeLabel,_that.icon,_that.descriptionHtml);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String confId,  String type,  String category,  String? shortDescription,  String? description,  DateTime? startDate,  DateTime? endDate,  Speaker? speaker,  List<Speaker> speakers,  bool isBreak,  String sessionLabel,  String timeLabel,  String icon,  String descriptionHtml)  $default,) {final _that = this;
switch (_that) {
case _EventItem():
return $default(_that.id,_that.title,_that.confId,_that.type,_that.category,_that.shortDescription,_that.description,_that.startDate,_that.endDate,_that.speaker,_that.speakers,_that.isBreak,_that.sessionLabel,_that.timeLabel,_that.icon,_that.descriptionHtml);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String confId,  String type,  String category,  String? shortDescription,  String? description,  DateTime? startDate,  DateTime? endDate,  Speaker? speaker,  List<Speaker> speakers,  bool isBreak,  String sessionLabel,  String timeLabel,  String icon,  String descriptionHtml)?  $default,) {final _that = this;
switch (_that) {
case _EventItem() when $default != null:
return $default(_that.id,_that.title,_that.confId,_that.type,_that.category,_that.shortDescription,_that.description,_that.startDate,_that.endDate,_that.speaker,_that.speakers,_that.isBreak,_that.sessionLabel,_that.timeLabel,_that.icon,_that.descriptionHtml);case _:
  return null;

}
}

}

/// @nodoc


class _EventItem extends EventItem {
  const _EventItem({required this.id, required this.title, required this.confId, required this.type, required this.category, required this.shortDescription, required this.description, required this.startDate, required this.endDate, required this.speaker, final  List<Speaker> speakers = const [], this.isBreak = false, this.sessionLabel = '', this.timeLabel = '', this.icon = '', this.descriptionHtml = ''}): _speakers = speakers,super._();
  

@override final  String id;
@override final  String title;
@override final  String confId;
@override final  String type;
@override final  String category;
@override final  String? shortDescription;
@override final  String? description;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override final  Speaker? speaker;
 final  List<Speaker> _speakers;
@override@JsonKey() List<Speaker> get speakers {
  if (_speakers is EqualUnmodifiableListView) return _speakers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_speakers);
}

@override@JsonKey() final  bool isBreak;
@override@JsonKey() final  String sessionLabel;
@override@JsonKey() final  String timeLabel;
@override@JsonKey() final  String icon;
@override@JsonKey() final  String descriptionHtml;

/// Create a copy of EventItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventItemCopyWith<_EventItem> get copyWith => __$EventItemCopyWithImpl<_EventItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&const DeepCollectionEquality().equals(other._speakers, _speakers)&&(identical(other.isBreak, isBreak) || other.isBreak == isBreak)&&(identical(other.sessionLabel, sessionLabel) || other.sessionLabel == sessionLabel)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.descriptionHtml, descriptionHtml) || other.descriptionHtml == descriptionHtml));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,confId,type,category,shortDescription,description,startDate,endDate,speaker,const DeepCollectionEquality().hash(_speakers),isBreak,sessionLabel,timeLabel,icon,descriptionHtml);

@override
String toString() {
  return 'EventItem(id: $id, title: $title, confId: $confId, type: $type, category: $category, shortDescription: $shortDescription, description: $description, startDate: $startDate, endDate: $endDate, speaker: $speaker, speakers: $speakers, isBreak: $isBreak, sessionLabel: $sessionLabel, timeLabel: $timeLabel, icon: $icon, descriptionHtml: $descriptionHtml)';
}


}

/// @nodoc
abstract mixin class _$EventItemCopyWith<$Res> implements $EventItemCopyWith<$Res> {
  factory _$EventItemCopyWith(_EventItem value, $Res Function(_EventItem) _then) = __$EventItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String confId, String type, String category, String? shortDescription, String? description, DateTime? startDate, DateTime? endDate, Speaker? speaker, List<Speaker> speakers, bool isBreak, String sessionLabel, String timeLabel, String icon, String descriptionHtml
});


@override $SpeakerCopyWith<$Res>? get speaker;

}
/// @nodoc
class __$EventItemCopyWithImpl<$Res>
    implements _$EventItemCopyWith<$Res> {
  __$EventItemCopyWithImpl(this._self, this._then);

  final _EventItem _self;
  final $Res Function(_EventItem) _then;

/// Create a copy of EventItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? confId = null,Object? type = null,Object? category = null,Object? shortDescription = freezed,Object? description = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? speaker = freezed,Object? speakers = null,Object? isBreak = null,Object? sessionLabel = null,Object? timeLabel = null,Object? icon = null,Object? descriptionHtml = null,}) {
  return _then(_EventItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,speaker: freezed == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as Speaker?,speakers: null == speakers ? _self._speakers : speakers // ignore: cast_nullable_to_non_nullable
as List<Speaker>,isBreak: null == isBreak ? _self.isBreak : isBreak // ignore: cast_nullable_to_non_nullable
as bool,sessionLabel: null == sessionLabel ? _self.sessionLabel : sessionLabel // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,descriptionHtml: null == descriptionHtml ? _self.descriptionHtml : descriptionHtml // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of EventItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakerCopyWith<$Res>? get speaker {
    if (_self.speaker == null) {
    return null;
  }

  return $SpeakerCopyWith<$Res>(_self.speaker!, (value) {
    return _then(_self.copyWith(speaker: value));
  });
}
}

// dart format on
