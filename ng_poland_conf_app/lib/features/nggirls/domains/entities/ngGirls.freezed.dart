// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ngGirls.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NgGirls {

 String get myId; String? get title; String? get text;
/// Create a copy of NgGirls
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NgGirlsCopyWith<NgGirls> get copyWith => _$NgGirlsCopyWithImpl<NgGirls>(this as NgGirls, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NgGirls&&(identical(other.myId, myId) || other.myId == myId)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,myId,title,text);

@override
String toString() {
  return 'NgGirls(myId: $myId, title: $title, text: $text)';
}


}

/// @nodoc
abstract mixin class $NgGirlsCopyWith<$Res>  {
  factory $NgGirlsCopyWith(NgGirls value, $Res Function(NgGirls) _then) = _$NgGirlsCopyWithImpl;
@useResult
$Res call({
 String myId, String? title, String? text
});




}
/// @nodoc
class _$NgGirlsCopyWithImpl<$Res>
    implements $NgGirlsCopyWith<$Res> {
  _$NgGirlsCopyWithImpl(this._self, this._then);

  final NgGirls _self;
  final $Res Function(NgGirls) _then;

/// Create a copy of NgGirls
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? myId = null,Object? title = freezed,Object? text = freezed,}) {
  return _then(_self.copyWith(
myId: null == myId ? _self.myId : myId // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NgGirls].
extension NgGirlsPatterns on NgGirls {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NgGirls value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NgGirls() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NgGirls value)  $default,){
final _that = this;
switch (_that) {
case _NgGirls():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NgGirls value)?  $default,){
final _that = this;
switch (_that) {
case _NgGirls() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String myId,  String? title,  String? text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NgGirls() when $default != null:
return $default(_that.myId,_that.title,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String myId,  String? title,  String? text)  $default,) {final _that = this;
switch (_that) {
case _NgGirls():
return $default(_that.myId,_that.title,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String myId,  String? title,  String? text)?  $default,) {final _that = this;
switch (_that) {
case _NgGirls() when $default != null:
return $default(_that.myId,_that.title,_that.text);case _:
  return null;

}
}

}

/// @nodoc


class _NgGirls extends NgGirls {
  const _NgGirls({required this.myId, required this.title, required this.text}): super._();
  

@override final  String myId;
@override final  String? title;
@override final  String? text;

/// Create a copy of NgGirls
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NgGirlsCopyWith<_NgGirls> get copyWith => __$NgGirlsCopyWithImpl<_NgGirls>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NgGirls&&(identical(other.myId, myId) || other.myId == myId)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,myId,title,text);

@override
String toString() {
  return 'NgGirls(myId: $myId, title: $title, text: $text)';
}


}

/// @nodoc
abstract mixin class _$NgGirlsCopyWith<$Res> implements $NgGirlsCopyWith<$Res> {
  factory _$NgGirlsCopyWith(_NgGirls value, $Res Function(_NgGirls) _then) = __$NgGirlsCopyWithImpl;
@override @useResult
$Res call({
 String myId, String? title, String? text
});




}
/// @nodoc
class __$NgGirlsCopyWithImpl<$Res>
    implements _$NgGirlsCopyWith<$Res> {
  __$NgGirlsCopyWithImpl(this._self, this._then);

  final _NgGirls _self;
  final $Res Function(_NgGirls) _then;

/// Create a copy of NgGirls
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? myId = null,Object? title = freezed,Object? text = freezed,}) {
  return _then(_NgGirls(
myId: null == myId ? _self.myId : myId // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
