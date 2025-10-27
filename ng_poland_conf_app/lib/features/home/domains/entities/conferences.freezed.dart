// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Conferences {

 List<Conference> get list;
/// Create a copy of Conferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConferencesCopyWith<Conferences> get copyWith => _$ConferencesCopyWithImpl<Conferences>(this as Conferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conferences&&const DeepCollectionEquality().equals(other.list, list));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list));

@override
String toString() {
  return 'Conferences(list: $list)';
}


}

/// @nodoc
abstract mixin class $ConferencesCopyWith<$Res>  {
  factory $ConferencesCopyWith(Conferences value, $Res Function(Conferences) _then) = _$ConferencesCopyWithImpl;
@useResult
$Res call({
 List<Conference> list
});




}
/// @nodoc
class _$ConferencesCopyWithImpl<$Res>
    implements $ConferencesCopyWith<$Res> {
  _$ConferencesCopyWithImpl(this._self, this._then);

  final Conferences _self;
  final $Res Function(Conferences) _then;

/// Create a copy of Conferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<Conference>,
  ));
}

}


/// Adds pattern-matching-related methods to [Conferences].
extension ConferencesPatterns on Conferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Conferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Conferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Conferences value)  $default,){
final _that = this;
switch (_that) {
case _Conferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Conferences value)?  $default,){
final _that = this;
switch (_that) {
case _Conferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Conference> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Conferences() when $default != null:
return $default(_that.list);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Conference> list)  $default,) {final _that = this;
switch (_that) {
case _Conferences():
return $default(_that.list);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Conference> list)?  $default,) {final _that = this;
switch (_that) {
case _Conferences() when $default != null:
return $default(_that.list);case _:
  return null;

}
}

}

/// @nodoc


class _Conferences implements Conferences {
   _Conferences({required final  List<Conference> list}): _list = list;
  

 final  List<Conference> _list;
@override List<Conference> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of Conferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConferencesCopyWith<_Conferences> get copyWith => __$ConferencesCopyWithImpl<_Conferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Conferences&&const DeepCollectionEquality().equals(other._list, _list));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'Conferences(list: $list)';
}


}

/// @nodoc
abstract mixin class _$ConferencesCopyWith<$Res> implements $ConferencesCopyWith<$Res> {
  factory _$ConferencesCopyWith(_Conferences value, $Res Function(_Conferences) _then) = __$ConferencesCopyWithImpl;
@override @useResult
$Res call({
 List<Conference> list
});




}
/// @nodoc
class __$ConferencesCopyWithImpl<$Res>
    implements _$ConferencesCopyWith<$Res> {
  __$ConferencesCopyWithImpl(this._self, this._then);

  final _Conferences _self;
  final $Res Function(_Conferences) _then;

/// Create a copy of Conferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(_Conferences(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<Conference>,
  ));
}


}

// dart format on
