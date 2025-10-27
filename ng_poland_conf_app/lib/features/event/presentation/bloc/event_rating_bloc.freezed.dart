// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_rating_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventRatingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventRatingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventRatingEvent()';
}


}

/// @nodoc
class $EventRatingEventCopyWith<$Res>  {
$EventRatingEventCopyWith(EventRatingEvent _, $Res Function(EventRatingEvent) __);
}


/// Adds pattern-matching-related methods to [EventRatingEvent].
extension EventRatingEventPatterns on EventRatingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetRateForEvent value)?  getRateForEvent,TResult Function( _RateEvent value)?  rateEvent,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetRateForEvent() when getRateForEvent != null:
return getRateForEvent(_that);case _RateEvent() when rateEvent != null:
return rateEvent(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetRateForEvent value)  getRateForEvent,required TResult Function( _RateEvent value)  rateEvent,}){
final _that = this;
switch (_that) {
case _GetRateForEvent():
return getRateForEvent(_that);case _RateEvent():
return rateEvent(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetRateForEvent value)?  getRateForEvent,TResult? Function( _RateEvent value)?  rateEvent,}){
final _that = this;
switch (_that) {
case _GetRateForEvent() when getRateForEvent != null:
return getRateForEvent(_that);case _RateEvent() when rateEvent != null:
return rateEvent(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  getRateForEvent,TResult Function( int rate)?  rateEvent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetRateForEvent() when getRateForEvent != null:
return getRateForEvent();case _RateEvent() when rateEvent != null:
return rateEvent(_that.rate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  getRateForEvent,required TResult Function( int rate)  rateEvent,}) {final _that = this;
switch (_that) {
case _GetRateForEvent():
return getRateForEvent();case _RateEvent():
return rateEvent(_that.rate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  getRateForEvent,TResult? Function( int rate)?  rateEvent,}) {final _that = this;
switch (_that) {
case _GetRateForEvent() when getRateForEvent != null:
return getRateForEvent();case _RateEvent() when rateEvent != null:
return rateEvent(_that.rate);case _:
  return null;

}
}

}

/// @nodoc


class _GetRateForEvent implements EventRatingEvent {
  const _GetRateForEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetRateForEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventRatingEvent.getRateForEvent()';
}


}




/// @nodoc


class _RateEvent implements EventRatingEvent {
  const _RateEvent({required this.rate});
  

 final  int rate;

/// Create a copy of EventRatingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateEventCopyWith<_RateEvent> get copyWith => __$RateEventCopyWithImpl<_RateEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateEvent&&(identical(other.rate, rate) || other.rate == rate));
}


@override
int get hashCode => Object.hash(runtimeType,rate);

@override
String toString() {
  return 'EventRatingEvent.rateEvent(rate: $rate)';
}


}

/// @nodoc
abstract mixin class _$RateEventCopyWith<$Res> implements $EventRatingEventCopyWith<$Res> {
  factory _$RateEventCopyWith(_RateEvent value, $Res Function(_RateEvent) _then) = __$RateEventCopyWithImpl;
@useResult
$Res call({
 int rate
});




}
/// @nodoc
class __$RateEventCopyWithImpl<$Res>
    implements _$RateEventCopyWith<$Res> {
  __$RateEventCopyWithImpl(this._self, this._then);

  final _RateEvent _self;
  final $Res Function(_RateEvent) _then;

/// Create a copy of EventRatingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rate = null,}) {
  return _then(_RateEvent(
rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$EventRatingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventRatingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventRatingState()';
}


}

/// @nodoc
class $EventRatingStateCopyWith<$Res>  {
$EventRatingStateCopyWith(EventRatingState _, $Res Function(EventRatingState) __);
}


/// Adds pattern-matching-related methods to [EventRatingState].
extension EventRatingStatePatterns on EventRatingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _ReadyToRate value)?  readyToRate,TResult Function( _Rated value)?  rated,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _ReadyToRate() when readyToRate != null:
return readyToRate(_that);case _Rated() when rated != null:
return rated(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _ReadyToRate value)  readyToRate,required TResult Function( _Rated value)  rated,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _ReadyToRate():
return readyToRate(_that);case _Rated():
return rated(_that);case _Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _ReadyToRate value)?  readyToRate,TResult? Function( _Rated value)?  rated,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _ReadyToRate() when readyToRate != null:
return readyToRate(_that);case _Rated() when rated != null:
return rated(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  readyToRate,TResult Function( int rateForEvent)?  rated,TResult Function()?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _ReadyToRate() when readyToRate != null:
return readyToRate();case _Rated() when rated != null:
return rated(_that.rateForEvent);case _Failure() when failure != null:
return failure();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  readyToRate,required TResult Function( int rateForEvent)  rated,required TResult Function()  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _ReadyToRate():
return readyToRate();case _Rated():
return rated(_that.rateForEvent);case _Failure():
return failure();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  readyToRate,TResult? Function( int rateForEvent)?  rated,TResult? Function()?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _ReadyToRate() when readyToRate != null:
return readyToRate();case _Rated() when rated != null:
return rated(_that.rateForEvent);case _Failure() when failure != null:
return failure();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements EventRatingState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventRatingState.initial()';
}


}




/// @nodoc


class _Loading implements EventRatingState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventRatingState.loading()';
}


}




/// @nodoc


class _ReadyToRate implements EventRatingState {
  const _ReadyToRate();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadyToRate);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventRatingState.readyToRate()';
}


}




/// @nodoc


class _Rated implements EventRatingState {
  const _Rated({required this.rateForEvent});
  

 final  int rateForEvent;

/// Create a copy of EventRatingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatedCopyWith<_Rated> get copyWith => __$RatedCopyWithImpl<_Rated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Rated&&(identical(other.rateForEvent, rateForEvent) || other.rateForEvent == rateForEvent));
}


@override
int get hashCode => Object.hash(runtimeType,rateForEvent);

@override
String toString() {
  return 'EventRatingState.rated(rateForEvent: $rateForEvent)';
}


}

/// @nodoc
abstract mixin class _$RatedCopyWith<$Res> implements $EventRatingStateCopyWith<$Res> {
  factory _$RatedCopyWith(_Rated value, $Res Function(_Rated) _then) = __$RatedCopyWithImpl;
@useResult
$Res call({
 int rateForEvent
});




}
/// @nodoc
class __$RatedCopyWithImpl<$Res>
    implements _$RatedCopyWith<$Res> {
  __$RatedCopyWithImpl(this._self, this._then);

  final _Rated _self;
  final $Res Function(_Rated) _then;

/// Create a copy of EventRatingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rateForEvent = null,}) {
  return _then(_Rated(
rateForEvent: null == rateForEvent ? _self.rateForEvent : rateForEvent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Failure implements EventRatingState {
  const _Failure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventRatingState.failure()';
}


}




// dart format on
