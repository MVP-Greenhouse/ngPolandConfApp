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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VoteHidden value)?  hidden,TResult Function( VoteNeedsLogin value)?  needsLogin,TResult Function( VoteReady value)?  ready,TResult Function( VoteSaving value)?  saving,TResult Function( VoteFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VoteHidden() when hidden != null:
return hidden(_that);case VoteNeedsLogin() when needsLogin != null:
return needsLogin(_that);case VoteReady() when ready != null:
return ready(_that);case VoteSaving() when saving != null:
return saving(_that);case VoteFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VoteHidden value)  hidden,required TResult Function( VoteNeedsLogin value)  needsLogin,required TResult Function( VoteReady value)  ready,required TResult Function( VoteSaving value)  saving,required TResult Function( VoteFailure value)  failure,}){
final _that = this;
switch (_that) {
case VoteHidden():
return hidden(_that);case VoteNeedsLogin():
return needsLogin(_that);case VoteReady():
return ready(_that);case VoteSaving():
return saving(_that);case VoteFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VoteHidden value)?  hidden,TResult? Function( VoteNeedsLogin value)?  needsLogin,TResult? Function( VoteReady value)?  ready,TResult? Function( VoteSaving value)?  saving,TResult? Function( VoteFailure value)?  failure,}){
final _that = this;
switch (_that) {
case VoteHidden() when hidden != null:
return hidden(_that);case VoteNeedsLogin() when needsLogin != null:
return needsLogin(_that);case VoteReady() when ready != null:
return ready(_that);case VoteSaving() when saving != null:
return saving(_that);case VoteFailure() when failure != null:
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
case VoteHidden() when hidden != null:
return hidden();case VoteNeedsLogin() when needsLogin != null:
return needsLogin();case VoteReady() when ready != null:
return ready(_that.vote);case VoteSaving() when saving != null:
return saving(_that.vote);case VoteFailure() when failure != null:
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
case VoteHidden():
return hidden();case VoteNeedsLogin():
return needsLogin();case VoteReady():
return ready(_that.vote);case VoteSaving():
return saving(_that.vote);case VoteFailure():
return failure(_that.vote);}
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
case VoteHidden() when hidden != null:
return hidden();case VoteNeedsLogin() when needsLogin != null:
return needsLogin();case VoteReady() when ready != null:
return ready(_that.vote);case VoteSaving() when saving != null:
return saving(_that.vote);case VoteFailure() when failure != null:
return failure(_that.vote);case _:
  return null;

}
}

}

/// @nodoc


class VoteHidden extends EventVoteState {
  const VoteHidden(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteHidden);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventVoteState.hidden()';
}


}




/// @nodoc


class VoteNeedsLogin extends EventVoteState {
  const VoteNeedsLogin(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteNeedsLogin);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventVoteState.needsLogin()';
}


}




/// @nodoc


class VoteReady extends EventVoteState {
  const VoteReady(this.vote): super._();
  

 final  bool vote;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteReadyCopyWith<VoteReady> get copyWith => _$VoteReadyCopyWithImpl<VoteReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteReady&&(identical(other.vote, vote) || other.vote == vote));
}


@override
int get hashCode => Object.hash(runtimeType,vote);

@override
String toString() {
  return 'EventVoteState.ready(vote: $vote)';
}


}

/// @nodoc
abstract mixin class $VoteReadyCopyWith<$Res> implements $EventVoteStateCopyWith<$Res> {
  factory $VoteReadyCopyWith(VoteReady value, $Res Function(VoteReady) _then) = _$VoteReadyCopyWithImpl;
@useResult
$Res call({
 bool vote
});




}
/// @nodoc
class _$VoteReadyCopyWithImpl<$Res>
    implements $VoteReadyCopyWith<$Res> {
  _$VoteReadyCopyWithImpl(this._self, this._then);

  final VoteReady _self;
  final $Res Function(VoteReady) _then;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vote = null,}) {
  return _then(VoteReady(
null == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class VoteSaving extends EventVoteState {
  const VoteSaving(this.vote): super._();
  

 final  bool vote;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteSavingCopyWith<VoteSaving> get copyWith => _$VoteSavingCopyWithImpl<VoteSaving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteSaving&&(identical(other.vote, vote) || other.vote == vote));
}


@override
int get hashCode => Object.hash(runtimeType,vote);

@override
String toString() {
  return 'EventVoteState.saving(vote: $vote)';
}


}

/// @nodoc
abstract mixin class $VoteSavingCopyWith<$Res> implements $EventVoteStateCopyWith<$Res> {
  factory $VoteSavingCopyWith(VoteSaving value, $Res Function(VoteSaving) _then) = _$VoteSavingCopyWithImpl;
@useResult
$Res call({
 bool vote
});




}
/// @nodoc
class _$VoteSavingCopyWithImpl<$Res>
    implements $VoteSavingCopyWith<$Res> {
  _$VoteSavingCopyWithImpl(this._self, this._then);

  final VoteSaving _self;
  final $Res Function(VoteSaving) _then;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vote = null,}) {
  return _then(VoteSaving(
null == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class VoteFailure extends EventVoteState {
  const VoteFailure(this.vote): super._();
  

 final  bool vote;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteFailureCopyWith<VoteFailure> get copyWith => _$VoteFailureCopyWithImpl<VoteFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteFailure&&(identical(other.vote, vote) || other.vote == vote));
}


@override
int get hashCode => Object.hash(runtimeType,vote);

@override
String toString() {
  return 'EventVoteState.failure(vote: $vote)';
}


}

/// @nodoc
abstract mixin class $VoteFailureCopyWith<$Res> implements $EventVoteStateCopyWith<$Res> {
  factory $VoteFailureCopyWith(VoteFailure value, $Res Function(VoteFailure) _then) = _$VoteFailureCopyWithImpl;
@useResult
$Res call({
 bool vote
});




}
/// @nodoc
class _$VoteFailureCopyWithImpl<$Res>
    implements $VoteFailureCopyWith<$Res> {
  _$VoteFailureCopyWithImpl(this._self, this._then);

  final VoteFailure _self;
  final $Res Function(VoteFailure) _then;

/// Create a copy of EventVoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vote = null,}) {
  return _then(VoteFailure(
null == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
