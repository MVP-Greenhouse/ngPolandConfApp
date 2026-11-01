// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Conference {

 String get confId; String get confName; String? get description; DateTime? get startsAt; List<ConferenceItem> get listItems;
/// Create a copy of Conference
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConferenceCopyWith<Conference> get copyWith => _$ConferenceCopyWithImpl<Conference>(this as Conference, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conference&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.confName, confName) || other.confName == confName)&&(identical(other.description, description) || other.description == description)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&const DeepCollectionEquality().equals(other.listItems, listItems));
}


@override
int get hashCode => Object.hash(runtimeType,confId,confName,description,startsAt,const DeepCollectionEquality().hash(listItems));

@override
String toString() {
  return 'Conference(confId: $confId, confName: $confName, description: $description, startsAt: $startsAt, listItems: $listItems)';
}


}

/// @nodoc
abstract mixin class $ConferenceCopyWith<$Res>  {
  factory $ConferenceCopyWith(Conference value, $Res Function(Conference) _then) = _$ConferenceCopyWithImpl;
@useResult
$Res call({
 String confId, String confName, String? description, DateTime? startsAt, List<ConferenceItem> listItems
});




}
/// @nodoc
class _$ConferenceCopyWithImpl<$Res>
    implements $ConferenceCopyWith<$Res> {
  _$ConferenceCopyWithImpl(this._self, this._then);

  final Conference _self;
  final $Res Function(Conference) _then;

/// Create a copy of Conference
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? confId = null,Object? confName = null,Object? description = freezed,Object? startsAt = freezed,Object? listItems = null,}) {
  return _then(_self.copyWith(
confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,confName: null == confName ? _self.confName : confName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listItems: null == listItems ? _self.listItems : listItems // ignore: cast_nullable_to_non_nullable
as List<ConferenceItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [Conference].
extension ConferencePatterns on Conference {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Conference value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Conference() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Conference value)  $default,){
final _that = this;
switch (_that) {
case _Conference():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Conference value)?  $default,){
final _that = this;
switch (_that) {
case _Conference() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String confId,  String confName,  String? description,  DateTime? startsAt,  List<ConferenceItem> listItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Conference() when $default != null:
return $default(_that.confId,_that.confName,_that.description,_that.startsAt,_that.listItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String confId,  String confName,  String? description,  DateTime? startsAt,  List<ConferenceItem> listItems)  $default,) {final _that = this;
switch (_that) {
case _Conference():
return $default(_that.confId,_that.confName,_that.description,_that.startsAt,_that.listItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String confId,  String confName,  String? description,  DateTime? startsAt,  List<ConferenceItem> listItems)?  $default,) {final _that = this;
switch (_that) {
case _Conference() when $default != null:
return $default(_that.confId,_that.confName,_that.description,_that.startsAt,_that.listItems);case _:
  return null;

}
}

}

/// @nodoc


class _Conference implements Conference {
  const _Conference({required this.confId, required this.confName, this.description, this.startsAt, required final  List<ConferenceItem> listItems}): _listItems = listItems;
  

@override final  String confId;
@override final  String confName;
@override final  String? description;
@override final  DateTime? startsAt;
 final  List<ConferenceItem> _listItems;
@override List<ConferenceItem> get listItems {
  if (_listItems is EqualUnmodifiableListView) return _listItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listItems);
}


/// Create a copy of Conference
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConferenceCopyWith<_Conference> get copyWith => __$ConferenceCopyWithImpl<_Conference>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Conference&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.confName, confName) || other.confName == confName)&&(identical(other.description, description) || other.description == description)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&const DeepCollectionEquality().equals(other._listItems, _listItems));
}


@override
int get hashCode => Object.hash(runtimeType,confId,confName,description,startsAt,const DeepCollectionEquality().hash(_listItems));

@override
String toString() {
  return 'Conference(confId: $confId, confName: $confName, description: $description, startsAt: $startsAt, listItems: $listItems)';
}


}

/// @nodoc
abstract mixin class _$ConferenceCopyWith<$Res> implements $ConferenceCopyWith<$Res> {
  factory _$ConferenceCopyWith(_Conference value, $Res Function(_Conference) _then) = __$ConferenceCopyWithImpl;
@override @useResult
$Res call({
 String confId, String confName, String? description, DateTime? startsAt, List<ConferenceItem> listItems
});




}
/// @nodoc
class __$ConferenceCopyWithImpl<$Res>
    implements _$ConferenceCopyWith<$Res> {
  __$ConferenceCopyWithImpl(this._self, this._then);

  final _Conference _self;
  final $Res Function(_Conference) _then;

/// Create a copy of Conference
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? confId = null,Object? confName = null,Object? description = freezed,Object? startsAt = freezed,Object? listItems = null,}) {
  return _then(_Conference(
confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,confName: null == confName ? _self.confName : confName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listItems: null == listItems ? _self._listItems : listItems // ignore: cast_nullable_to_non_nullable
as List<ConferenceItem>,
  ));
}


}

// dart format on
