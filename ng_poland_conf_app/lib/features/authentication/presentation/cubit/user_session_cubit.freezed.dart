// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_session_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSessionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSessionState()';
}


}

/// @nodoc
class $UserSessionStateCopyWith<$Res>  {
$UserSessionStateCopyWith(UserSessionState _, $Res Function(UserSessionState) __);
}


/// Adds pattern-matching-related methods to [UserSessionState].
extension UserSessionStatePatterns on UserSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Unauthenticated value)?  unauthenticated,TResult Function( _Loading value)?  loading,TResult Function( _Authenticated value)?  authenticated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _Loading() when loading != null:
return loading(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Unauthenticated value)  unauthenticated,required TResult Function( _Loading value)  loading,required TResult Function( _Authenticated value)  authenticated,}){
final _that = this;
switch (_that) {
case _Unauthenticated():
return unauthenticated(_that);case _Loading():
return loading(_that);case _Authenticated():
return authenticated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Unauthenticated value)?  unauthenticated,TResult? Function( _Loading value)?  loading,TResult? Function( _Authenticated value)?  authenticated,}){
final _that = this;
switch (_that) {
case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _Loading() when loading != null:
return loading(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unauthenticated,TResult Function()?  loading,TResult Function( UserProfile profile)?  authenticated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Unauthenticated() when unauthenticated != null:
return unauthenticated();case _Loading() when loading != null:
return loading();case _Authenticated() when authenticated != null:
return authenticated(_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unauthenticated,required TResult Function()  loading,required TResult Function( UserProfile profile)  authenticated,}) {final _that = this;
switch (_that) {
case _Unauthenticated():
return unauthenticated();case _Loading():
return loading();case _Authenticated():
return authenticated(_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unauthenticated,TResult? Function()?  loading,TResult? Function( UserProfile profile)?  authenticated,}) {final _that = this;
switch (_that) {
case _Unauthenticated() when unauthenticated != null:
return unauthenticated();case _Loading() when loading != null:
return loading();case _Authenticated() when authenticated != null:
return authenticated(_that.profile);case _:
  return null;

}
}

}

/// @nodoc


class _Unauthenticated extends UserSessionState {
  const _Unauthenticated(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSessionState.unauthenticated()';
}


}




/// @nodoc


class _Loading extends UserSessionState {
  const _Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSessionState.loading()';
}


}




/// @nodoc


class _Authenticated extends UserSessionState {
  const _Authenticated(this.profile): super._();
  

 final  UserProfile profile;

/// Create a copy of UserSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticatedCopyWith<_Authenticated> get copyWith => __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authenticated&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'UserSessionState.authenticated(profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$AuthenticatedCopyWith<$Res> implements $UserSessionStateCopyWith<$Res> {
  factory _$AuthenticatedCopyWith(_Authenticated value, $Res Function(_Authenticated) _then) = __$AuthenticatedCopyWithImpl;
@useResult
$Res call({
 UserProfile profile
});




}
/// @nodoc
class __$AuthenticatedCopyWithImpl<$Res>
    implements _$AuthenticatedCopyWith<$Res> {
  __$AuthenticatedCopyWithImpl(this._self, this._then);

  final _Authenticated _self;
  final $Res Function(_Authenticated) _then;

/// Create a copy of UserSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(_Authenticated(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile,
  ));
}


}

// dart format on
