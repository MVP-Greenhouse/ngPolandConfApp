// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_vote_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventVoteState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventVoteState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventVoteState()';
}


}

/// @nodoc
class $EventVoteStateCopyWith<$Res>  {
$EventVoteStateCopyWith(EventVoteState _, $Res Function(EventVoteState) __);
}


/// Adds pattern-matching-related methods to [EventVoteState].
extension EventVoteStatePatterns on EventVoteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Hidden value)?  hidden,TResult Function( _NeedsLogin value)?  needsLogin,TResult Function( _Ready value)?  ready,TResult Function( _Saving value)?  saving,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hidden() when hidden != null:
return hidden(_that);case _NeedsLogin() when needsLogin != null:
return needsLogin(_that);case _Ready() when ready != null:
return ready(_that);case _Saving() when saving != null:
return saving(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Hidden value)  hidden,required TResult Function( _NeedsLogin value)  needsLogin,required TResult Function( _Ready value)  ready,required TResult Function( _Saving value)  saving,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Hidden():
return hidden(_that);case _NeedsLogin():
return needsLogin(_that);case _Ready():
return ready(_that);case _Saving():
return saving(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Hidden value)?  hidden,TResult? Function( _NeedsLogin value)?  needsLogin,TResult? Function( _Ready value)?  ready,TResult? Function( _Saving value)?  saving,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Hidden() when hidden != null:
return hidden(_that);case _NeedsLogin() when needsLogin != null:
return needsLogin(_that);case _Ready() when ready != null:
return ready(_that);case _Saving() when saving != null:
return saving(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  hidden,TResult Function()?  needsLogin,TResult Function( bool vote)?  ready,TResult Function( bool vote)?  saving,TResult Function( bool vote)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hidden() when hidden != null:
return hidden();case _NeedsLogin() when needsLogin != null:
return needsLogin();case _Ready() when ready != null:
return ready(_that.vote);case _Saving() when saving != null:
return saving(_that.vote);case _Failure() when failure != null:
return failure(_that.vote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  hidden,required TResult Function()  needsLogin,required TResult Function( bool vote)  ready,required TResult Function( bool vote)  saving,required TResult Function( bool vote)  failure,}) {final _that = this;
switch (_that) {
case _Hidden():
return hidden();case _NeedsLogin():
return needsLogin();case _Ready():
return ready(_that.vote);case _Saving():
return saving(_that.vote);case _Failure():
return failure(_that.vote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  hidden,TResult? Function()?  needsLogin,TResult? Function( bool vote)?  ready,TResult? Function( bool vote)?  saving,TResult? Function( bool vote)?  failure,}) {final _that = this;
switch (_that) {
case _Hidden() when hidden != null:
return hidden();case _NeedsLogin() when needsLogin != null:
return needsLogin();case _Ready() when ready != null:
return ready(_that.vote);case _Saving() when saving != null:
return saving(_that.vote);case _Failure() when failure != null:
return failure(_that.vote);case _:
  return null;

}
}

}

/// @nodoc


class _Hidden extends EventVoteState {
  const _Hidden(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hidden);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventVoteState.hidden()';
}


}




/// @nodoc


class _NeedsLogin extends EventVoteState {
  const _NeedsLogin(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NeedsLogin);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventVoteState.needsLogin()';
}


}




/// @nodoc


class _Ready extends EventVoteState {
  const _Ready(this.vote): super._();
  

 final  bool vote;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadyCopyWith<_Ready> get copyWith => __$ReadyCopyWithImpl<_Ready>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ready&&(identical(other.vote, vote) || other.vote == vote));
}


@override
int get hashCode => Object.hash(runtimeType,vote);

@override
String toString() {
  return 'EventVoteState.ready(vote: $vote)';
}


}

/// @nodoc
abstract mixin class _$ReadyCopyWith<$Res> implements $EventVoteStateCopyWith<$Res> {
  factory _$ReadyCopyWith(_Ready value, $Res Function(_Ready) _then) = __$ReadyCopyWithImpl;
@useResult
$Res call({
 bool vote
});




}
/// @nodoc
class __$ReadyCopyWithImpl<$Res>
    implements _$ReadyCopyWith<$Res> {
  __$ReadyCopyWithImpl(this._self, this._then);

  final _Ready _self;
  final $Res Function(_Ready) _then;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vote = null,}) {
  return _then(_Ready(
null == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Saving extends EventVoteState {
  const _Saving(this.vote): super._();
  

 final  bool vote;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingCopyWith<_Saving> get copyWith => __$SavingCopyWithImpl<_Saving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Saving&&(identical(other.vote, vote) || other.vote == vote));
}


@override
int get hashCode => Object.hash(runtimeType,vote);

@override
String toString() {
  return 'EventVoteState.saving(vote: $vote)';
}


}

/// @nodoc
abstract mixin class _$SavingCopyWith<$Res> implements $EventVoteStateCopyWith<$Res> {
  factory _$SavingCopyWith(_Saving value, $Res Function(_Saving) _then) = __$SavingCopyWithImpl;
@useResult
$Res call({
 bool vote
});




}
/// @nodoc
class __$SavingCopyWithImpl<$Res>
    implements _$SavingCopyWith<$Res> {
  __$SavingCopyWithImpl(this._self, this._then);

  final _Saving _self;
  final $Res Function(_Saving) _then;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vote = null,}) {
  return _then(_Saving(
null == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Failure extends EventVoteState {
  const _Failure(this.vote): super._();
  

 final  bool vote;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.vote, vote) || other.vote == vote));
}


@override
int get hashCode => Object.hash(runtimeType,vote);

@override
String toString() {
  return 'EventVoteState.failure(vote: $vote)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $EventVoteStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 bool vote
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vote = null,}) {
  return _then(_Failure(
null == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
