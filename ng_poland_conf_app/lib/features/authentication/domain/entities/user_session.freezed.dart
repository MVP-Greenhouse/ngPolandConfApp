// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSession {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSession);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSession()';
}


}

/// @nodoc
class $UserSessionCopyWith<$Res>  {
$UserSessionCopyWith(UserSession _, $Res Function(UserSession) __);
}


/// Adds pattern-matching-related methods to [UserSession].
extension UserSessionPatterns on UserSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionLoading value)?  loading,TResult Function( SignedOut value)?  signedOut,TResult Function( SignedIn value)?  signedIn,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionLoading() when loading != null:
return loading(_that);case SignedOut() when signedOut != null:
return signedOut(_that);case SignedIn() when signedIn != null:
return signedIn(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionLoading value)  loading,required TResult Function( SignedOut value)  signedOut,required TResult Function( SignedIn value)  signedIn,}){
final _that = this;
switch (_that) {
case SessionLoading():
return loading(_that);case SignedOut():
return signedOut(_that);case SignedIn():
return signedIn(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionLoading value)?  loading,TResult? Function( SignedOut value)?  signedOut,TResult? Function( SignedIn value)?  signedIn,}){
final _that = this;
switch (_that) {
case SessionLoading() when loading != null:
return loading(_that);case SignedOut() when signedOut != null:
return signedOut(_that);case SignedIn() when signedIn != null:
return signedIn(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  signedOut,TResult Function( UserProfile profile)?  signedIn,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionLoading() when loading != null:
return loading();case SignedOut() when signedOut != null:
return signedOut();case SignedIn() when signedIn != null:
return signedIn(_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  signedOut,required TResult Function( UserProfile profile)  signedIn,}) {final _that = this;
switch (_that) {
case SessionLoading():
return loading();case SignedOut():
return signedOut();case SignedIn():
return signedIn(_that.profile);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  signedOut,TResult? Function( UserProfile profile)?  signedIn,}) {final _that = this;
switch (_that) {
case SessionLoading() when loading != null:
return loading();case SignedOut() when signedOut != null:
return signedOut();case SignedIn() when signedIn != null:
return signedIn(_that.profile);case _:
  return null;

}
}

}

/// @nodoc


class SessionLoading extends UserSession {
  const SessionLoading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSession.loading()';
}


}




/// @nodoc


class SignedOut extends UserSession {
  const SignedOut(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSession.signedOut()';
}


}




/// @nodoc


class SignedIn extends UserSession {
  const SignedIn(this.profile): super._();
  

 final  UserProfile profile;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignedInCopyWith<SignedIn> get copyWith => _$SignedInCopyWithImpl<SignedIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignedIn&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'UserSession.signedIn(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $SignedInCopyWith<$Res> implements $UserSessionCopyWith<$Res> {
  factory $SignedInCopyWith(SignedIn value, $Res Function(SignedIn) _then) = _$SignedInCopyWithImpl;
@useResult
$Res call({
 UserProfile profile
});




}
/// @nodoc
class _$SignedInCopyWithImpl<$Res>
    implements $SignedInCopyWith<$Res> {
  _$SignedInCopyWithImpl(this._self, this._then);

  final SignedIn _self;
  final $Res Function(SignedIn) _then;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(SignedIn(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile,
  ));
}


}

// dart format on
