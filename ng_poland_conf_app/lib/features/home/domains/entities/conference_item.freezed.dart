// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conference_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConferenceItem {

 String get name; String get desc;
/// Create a copy of ConferenceItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConferenceItemCopyWith<ConferenceItem> get copyWith => _$ConferenceItemCopyWithImpl<ConferenceItem>(this as ConferenceItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConferenceItem&&(identical(other.name, name) || other.name == name)&&(identical(other.desc, desc) || other.desc == desc));
}


@override
int get hashCode => Object.hash(runtimeType,name,desc);

@override
String toString() {
  return 'ConferenceItem(name: $name, desc: $desc)';
}


}

/// @nodoc
abstract mixin class $ConferenceItemCopyWith<$Res>  {
  factory $ConferenceItemCopyWith(ConferenceItem value, $Res Function(ConferenceItem) _then) = _$ConferenceItemCopyWithImpl;
@useResult
$Res call({
 String name, String desc
});




}
/// @nodoc
class _$ConferenceItemCopyWithImpl<$Res>
    implements $ConferenceItemCopyWith<$Res> {
  _$ConferenceItemCopyWithImpl(this._self, this._then);

  final ConferenceItem _self;
  final $Res Function(ConferenceItem) _then;

/// Create a copy of ConferenceItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? desc = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConferenceItem].
extension ConferenceItemPatterns on ConferenceItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConferenceItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConferenceItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConferenceItem value)  $default,){
final _that = this;
switch (_that) {
case _ConferenceItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConferenceItem value)?  $default,){
final _that = this;
switch (_that) {
case _ConferenceItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String desc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConferenceItem() when $default != null:
return $default(_that.name,_that.desc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String desc)  $default,) {final _that = this;
switch (_that) {
case _ConferenceItem():
return $default(_that.name,_that.desc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String desc)?  $default,) {final _that = this;
switch (_that) {
case _ConferenceItem() when $default != null:
return $default(_that.name,_that.desc);case _:
  return null;

}
}

}

/// @nodoc


class _ConferenceItem implements ConferenceItem {
  const _ConferenceItem({required this.name, required this.desc});
  

@override final  String name;
@override final  String desc;

/// Create a copy of ConferenceItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConferenceItemCopyWith<_ConferenceItem> get copyWith => __$ConferenceItemCopyWithImpl<_ConferenceItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConferenceItem&&(identical(other.name, name) || other.name == name)&&(identical(other.desc, desc) || other.desc == desc));
}


@override
int get hashCode => Object.hash(runtimeType,name,desc);

@override
String toString() {
  return 'ConferenceItem(name: $name, desc: $desc)';
}


}

/// @nodoc
abstract mixin class _$ConferenceItemCopyWith<$Res> implements $ConferenceItemCopyWith<$Res> {
  factory _$ConferenceItemCopyWith(_ConferenceItem value, $Res Function(_ConferenceItem) _then) = __$ConferenceItemCopyWithImpl;
@override @useResult
$Res call({
 String name, String desc
});




}
/// @nodoc
class __$ConferenceItemCopyWithImpl<$Res>
    implements _$ConferenceItemCopyWith<$Res> {
  __$ConferenceItemCopyWithImpl(this._self, this._then);

  final _ConferenceItem _self;
  final $Res Function(_ConferenceItem) _then;

/// Create a copy of ConferenceItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? desc = null,}) {
  return _then(_ConferenceItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
