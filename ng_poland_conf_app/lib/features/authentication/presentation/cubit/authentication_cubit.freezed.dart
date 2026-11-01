// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthenticationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState()';
}


}

/// @nodoc
class $AuthenticationStateCopyWith<$Res>  {
$AuthenticationStateCopyWith(AuthenticationState _, $Res Function(AuthenticationState) __);
}


/// Adds pattern-matching-related methods to [AuthenticationState].
extension AuthenticationStatePatterns on AuthenticationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthenticationInitial value)?  initial,TResult Function( AuthenticationInProgress value)?  inProgress,TResult Function( AuthenticationLinkSent value)?  linkSent,TResult Function( Authenticated value)?  authenticated,TResult Function( AuthenticationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthenticationInitial() when initial != null:
return initial(_that);case AuthenticationInProgress() when inProgress != null:
return inProgress(_that);case AuthenticationLinkSent() when linkSent != null:
return linkSent(_that);case Authenticated() when authenticated != null:
return authenticated(_that);case AuthenticationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthenticationInitial value)  initial,required TResult Function( AuthenticationInProgress value)  inProgress,required TResult Function( AuthenticationLinkSent value)  linkSent,required TResult Function( Authenticated value)  authenticated,required TResult Function( AuthenticationError value)  error,}){
final _that = this;
switch (_that) {
case AuthenticationInitial():
return initial(_that);case AuthenticationInProgress():
return inProgress(_that);case AuthenticationLinkSent():
return linkSent(_that);case Authenticated():
return authenticated(_that);case AuthenticationError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthenticationInitial value)?  initial,TResult? Function( AuthenticationInProgress value)?  inProgress,TResult? Function( AuthenticationLinkSent value)?  linkSent,TResult? Function( Authenticated value)?  authenticated,TResult? Function( AuthenticationError value)?  error,}){
final _that = this;
switch (_that) {
case AuthenticationInitial() when initial != null:
return initial(_that);case AuthenticationInProgress() when inProgress != null:
return inProgress(_that);case AuthenticationLinkSent() when linkSent != null:
return linkSent(_that);case Authenticated() when authenticated != null:
return authenticated(_that);case AuthenticationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( AuthenticationType type)?  inProgress,TResult Function( String email)?  linkSent,TResult Function()?  authenticated,TResult Function( String text)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthenticationInitial() when initial != null:
return initial();case AuthenticationInProgress() when inProgress != null:
return inProgress(_that.type);case AuthenticationLinkSent() when linkSent != null:
return linkSent(_that.email);case Authenticated() when authenticated != null:
return authenticated();case AuthenticationError() when error != null:
return error(_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( AuthenticationType type)  inProgress,required TResult Function( String email)  linkSent,required TResult Function()  authenticated,required TResult Function( String text)  error,}) {final _that = this;
switch (_that) {
case AuthenticationInitial():
return initial();case AuthenticationInProgress():
return inProgress(_that.type);case AuthenticationLinkSent():
return linkSent(_that.email);case Authenticated():
return authenticated();case AuthenticationError():
return error(_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( AuthenticationType type)?  inProgress,TResult? Function( String email)?  linkSent,TResult? Function()?  authenticated,TResult? Function( String text)?  error,}) {final _that = this;
switch (_that) {
case AuthenticationInitial() when initial != null:
return initial();case AuthenticationInProgress() when inProgress != null:
return inProgress(_that.type);case AuthenticationLinkSent() when linkSent != null:
return linkSent(_that.email);case Authenticated() when authenticated != null:
return authenticated();case AuthenticationError() when error != null:
return error(_that.text);case _:
  return null;

}
}

}

/// @nodoc


class AuthenticationInitial implements AuthenticationState {
  const AuthenticationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.initial()';
}


}




/// @nodoc


class AuthenticationInProgress implements AuthenticationState {
  const AuthenticationInProgress({required this.type});
  

 final  AuthenticationType type;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationInProgressCopyWith<AuthenticationInProgress> get copyWith => _$AuthenticationInProgressCopyWithImpl<AuthenticationInProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationInProgress&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'AuthenticationState.inProgress(type: $type)';
}


}

/// @nodoc
abstract mixin class $AuthenticationInProgressCopyWith<$Res> implements $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationInProgressCopyWith(AuthenticationInProgress value, $Res Function(AuthenticationInProgress) _then) = _$AuthenticationInProgressCopyWithImpl;
@useResult
$Res call({
 AuthenticationType type
});




}
/// @nodoc
class _$AuthenticationInProgressCopyWithImpl<$Res>
    implements $AuthenticationInProgressCopyWith<$Res> {
  _$AuthenticationInProgressCopyWithImpl(this._self, this._then);

  final AuthenticationInProgress _self;
  final $Res Function(AuthenticationInProgress) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(AuthenticationInProgress(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AuthenticationType,
  ));
}


}

/// @nodoc


class AuthenticationLinkSent implements AuthenticationState {
  const AuthenticationLinkSent({required this.email});
  

 final  String email;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationLinkSentCopyWith<AuthenticationLinkSent> get copyWith => _$AuthenticationLinkSentCopyWithImpl<AuthenticationLinkSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationLinkSent&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthenticationState.linkSent(email: $email)';
}


}

/// @nodoc
abstract mixin class $AuthenticationLinkSentCopyWith<$Res> implements $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationLinkSentCopyWith(AuthenticationLinkSent value, $Res Function(AuthenticationLinkSent) _then) = _$AuthenticationLinkSentCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$AuthenticationLinkSentCopyWithImpl<$Res>
    implements $AuthenticationLinkSentCopyWith<$Res> {
  _$AuthenticationLinkSentCopyWithImpl(this._self, this._then);

  final AuthenticationLinkSent _self;
  final $Res Function(AuthenticationLinkSent) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(AuthenticationLinkSent(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Authenticated implements AuthenticationState {
  const Authenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.authenticated()';
}


}




/// @nodoc


class AuthenticationError implements AuthenticationState {
  const AuthenticationError(this.text);
  

 final  String text;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationErrorCopyWith<AuthenticationError> get copyWith => _$AuthenticationErrorCopyWithImpl<AuthenticationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationError&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'AuthenticationState.error(text: $text)';
}


}

/// @nodoc
abstract mixin class $AuthenticationErrorCopyWith<$Res> implements $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationErrorCopyWith(AuthenticationError value, $Res Function(AuthenticationError) _then) = _$AuthenticationErrorCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$AuthenticationErrorCopyWithImpl<$Res>
    implements $AuthenticationErrorCopyWith<$Res> {
  _$AuthenticationErrorCopyWithImpl(this._self, this._then);

  final AuthenticationError _self;
  final $Res Function(AuthenticationError) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(AuthenticationError(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
