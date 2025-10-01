// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_rating_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventRatingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getRateForEvent,
    required TResult Function(int rate) rateEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getRateForEvent,
    TResult? Function(int rate)? rateEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getRateForEvent,
    TResult Function(int rate)? rateEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRateForEvent value) getRateForEvent,
    required TResult Function(_RateEvent value) rateEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRateForEvent value)? getRateForEvent,
    TResult? Function(_RateEvent value)? rateEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRateForEvent value)? getRateForEvent,
    TResult Function(_RateEvent value)? rateEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventRatingEventCopyWith<$Res> {
  factory $EventRatingEventCopyWith(
          EventRatingEvent value, $Res Function(EventRatingEvent) then) =
      _$EventRatingEventCopyWithImpl<$Res, EventRatingEvent>;
}

/// @nodoc
class _$EventRatingEventCopyWithImpl<$Res, $Val extends EventRatingEvent>
    implements $EventRatingEventCopyWith<$Res> {
  _$EventRatingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventRatingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GetRateForEventImplCopyWith<$Res> {
  factory _$$GetRateForEventImplCopyWith(_$GetRateForEventImpl value,
          $Res Function(_$GetRateForEventImpl) then) =
      __$$GetRateForEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetRateForEventImplCopyWithImpl<$Res>
    extends _$EventRatingEventCopyWithImpl<$Res, _$GetRateForEventImpl>
    implements _$$GetRateForEventImplCopyWith<$Res> {
  __$$GetRateForEventImplCopyWithImpl(
      _$GetRateForEventImpl _value, $Res Function(_$GetRateForEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventRatingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetRateForEventImpl implements _GetRateForEvent {
  const _$GetRateForEventImpl();

  @override
  String toString() {
    return 'EventRatingEvent.getRateForEvent()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetRateForEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getRateForEvent,
    required TResult Function(int rate) rateEvent,
  }) {
    return getRateForEvent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getRateForEvent,
    TResult? Function(int rate)? rateEvent,
  }) {
    return getRateForEvent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getRateForEvent,
    TResult Function(int rate)? rateEvent,
    required TResult orElse(),
  }) {
    if (getRateForEvent != null) {
      return getRateForEvent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRateForEvent value) getRateForEvent,
    required TResult Function(_RateEvent value) rateEvent,
  }) {
    return getRateForEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRateForEvent value)? getRateForEvent,
    TResult? Function(_RateEvent value)? rateEvent,
  }) {
    return getRateForEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRateForEvent value)? getRateForEvent,
    TResult Function(_RateEvent value)? rateEvent,
    required TResult orElse(),
  }) {
    if (getRateForEvent != null) {
      return getRateForEvent(this);
    }
    return orElse();
  }
}

abstract class _GetRateForEvent implements EventRatingEvent {
  const factory _GetRateForEvent() = _$GetRateForEventImpl;
}

/// @nodoc
abstract class _$$RateEventImplCopyWith<$Res> {
  factory _$$RateEventImplCopyWith(
          _$RateEventImpl value, $Res Function(_$RateEventImpl) then) =
      __$$RateEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int rate});
}

/// @nodoc
class __$$RateEventImplCopyWithImpl<$Res>
    extends _$EventRatingEventCopyWithImpl<$Res, _$RateEventImpl>
    implements _$$RateEventImplCopyWith<$Res> {
  __$$RateEventImplCopyWithImpl(
      _$RateEventImpl _value, $Res Function(_$RateEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventRatingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rate = null,
  }) {
    return _then(_$RateEventImpl(
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RateEventImpl implements _RateEvent {
  const _$RateEventImpl({required this.rate});

  @override
  final int rate;

  @override
  String toString() {
    return 'EventRatingEvent.rateEvent(rate: $rate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateEventImpl &&
            (identical(other.rate, rate) || other.rate == rate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rate);

  /// Create a copy of EventRatingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RateEventImplCopyWith<_$RateEventImpl> get copyWith =>
      __$$RateEventImplCopyWithImpl<_$RateEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getRateForEvent,
    required TResult Function(int rate) rateEvent,
  }) {
    return rateEvent(rate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getRateForEvent,
    TResult? Function(int rate)? rateEvent,
  }) {
    return rateEvent?.call(rate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getRateForEvent,
    TResult Function(int rate)? rateEvent,
    required TResult orElse(),
  }) {
    if (rateEvent != null) {
      return rateEvent(rate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRateForEvent value) getRateForEvent,
    required TResult Function(_RateEvent value) rateEvent,
  }) {
    return rateEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRateForEvent value)? getRateForEvent,
    TResult? Function(_RateEvent value)? rateEvent,
  }) {
    return rateEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRateForEvent value)? getRateForEvent,
    TResult Function(_RateEvent value)? rateEvent,
    required TResult orElse(),
  }) {
    if (rateEvent != null) {
      return rateEvent(this);
    }
    return orElse();
  }
}

abstract class _RateEvent implements EventRatingEvent {
  const factory _RateEvent({required final int rate}) = _$RateEventImpl;

  int get rate;

  /// Create a copy of EventRatingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RateEventImplCopyWith<_$RateEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EventRatingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() readyToRate,
    required TResult Function(int rateForEvent) rated,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? readyToRate,
    TResult? Function(int rateForEvent)? rated,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? readyToRate,
    TResult Function(int rateForEvent)? rated,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadyToRate value) readyToRate,
    required TResult Function(_Rated value) rated,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReadyToRate value)? readyToRate,
    TResult? Function(_Rated value)? rated,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadyToRate value)? readyToRate,
    TResult Function(_Rated value)? rated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventRatingStateCopyWith<$Res> {
  factory $EventRatingStateCopyWith(
          EventRatingState value, $Res Function(EventRatingState) then) =
      _$EventRatingStateCopyWithImpl<$Res, EventRatingState>;
}

/// @nodoc
class _$EventRatingStateCopyWithImpl<$Res, $Val extends EventRatingState>
    implements $EventRatingStateCopyWith<$Res> {
  _$EventRatingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventRatingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$EventRatingStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventRatingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'EventRatingState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() readyToRate,
    required TResult Function(int rateForEvent) rated,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? readyToRate,
    TResult? Function(int rateForEvent)? rated,
    TResult? Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? readyToRate,
    TResult Function(int rateForEvent)? rated,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadyToRate value) readyToRate,
    required TResult Function(_Rated value) rated,
    required TResult Function(_Failure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReadyToRate value)? readyToRate,
    TResult? Function(_Rated value)? rated,
    TResult? Function(_Failure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadyToRate value)? readyToRate,
    TResult Function(_Rated value)? rated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements EventRatingState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$EventRatingStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventRatingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'EventRatingState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() readyToRate,
    required TResult Function(int rateForEvent) rated,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? readyToRate,
    TResult? Function(int rateForEvent)? rated,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? readyToRate,
    TResult Function(int rateForEvent)? rated,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadyToRate value) readyToRate,
    required TResult Function(_Rated value) rated,
    required TResult Function(_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReadyToRate value)? readyToRate,
    TResult? Function(_Rated value)? rated,
    TResult? Function(_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadyToRate value)? readyToRate,
    TResult Function(_Rated value)? rated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements EventRatingState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$ReadyToRateImplCopyWith<$Res> {
  factory _$$ReadyToRateImplCopyWith(
          _$ReadyToRateImpl value, $Res Function(_$ReadyToRateImpl) then) =
      __$$ReadyToRateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReadyToRateImplCopyWithImpl<$Res>
    extends _$EventRatingStateCopyWithImpl<$Res, _$ReadyToRateImpl>
    implements _$$ReadyToRateImplCopyWith<$Res> {
  __$$ReadyToRateImplCopyWithImpl(
      _$ReadyToRateImpl _value, $Res Function(_$ReadyToRateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventRatingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReadyToRateImpl implements _ReadyToRate {
  const _$ReadyToRateImpl();

  @override
  String toString() {
    return 'EventRatingState.readyToRate()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReadyToRateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() readyToRate,
    required TResult Function(int rateForEvent) rated,
    required TResult Function() failure,
  }) {
    return readyToRate();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? readyToRate,
    TResult? Function(int rateForEvent)? rated,
    TResult? Function()? failure,
  }) {
    return readyToRate?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? readyToRate,
    TResult Function(int rateForEvent)? rated,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (readyToRate != null) {
      return readyToRate();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadyToRate value) readyToRate,
    required TResult Function(_Rated value) rated,
    required TResult Function(_Failure value) failure,
  }) {
    return readyToRate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReadyToRate value)? readyToRate,
    TResult? Function(_Rated value)? rated,
    TResult? Function(_Failure value)? failure,
  }) {
    return readyToRate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadyToRate value)? readyToRate,
    TResult Function(_Rated value)? rated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (readyToRate != null) {
      return readyToRate(this);
    }
    return orElse();
  }
}

abstract class _ReadyToRate implements EventRatingState {
  const factory _ReadyToRate() = _$ReadyToRateImpl;
}

/// @nodoc
abstract class _$$RatedImplCopyWith<$Res> {
  factory _$$RatedImplCopyWith(
          _$RatedImpl value, $Res Function(_$RatedImpl) then) =
      __$$RatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int rateForEvent});
}

/// @nodoc
class __$$RatedImplCopyWithImpl<$Res>
    extends _$EventRatingStateCopyWithImpl<$Res, _$RatedImpl>
    implements _$$RatedImplCopyWith<$Res> {
  __$$RatedImplCopyWithImpl(
      _$RatedImpl _value, $Res Function(_$RatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventRatingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rateForEvent = null,
  }) {
    return _then(_$RatedImpl(
      rateForEvent: null == rateForEvent
          ? _value.rateForEvent
          : rateForEvent // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RatedImpl implements _Rated {
  const _$RatedImpl({required this.rateForEvent});

  @override
  final int rateForEvent;

  @override
  String toString() {
    return 'EventRatingState.rated(rateForEvent: $rateForEvent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatedImpl &&
            (identical(other.rateForEvent, rateForEvent) ||
                other.rateForEvent == rateForEvent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rateForEvent);

  /// Create a copy of EventRatingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatedImplCopyWith<_$RatedImpl> get copyWith =>
      __$$RatedImplCopyWithImpl<_$RatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() readyToRate,
    required TResult Function(int rateForEvent) rated,
    required TResult Function() failure,
  }) {
    return rated(rateForEvent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? readyToRate,
    TResult? Function(int rateForEvent)? rated,
    TResult? Function()? failure,
  }) {
    return rated?.call(rateForEvent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? readyToRate,
    TResult Function(int rateForEvent)? rated,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (rated != null) {
      return rated(rateForEvent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadyToRate value) readyToRate,
    required TResult Function(_Rated value) rated,
    required TResult Function(_Failure value) failure,
  }) {
    return rated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReadyToRate value)? readyToRate,
    TResult? Function(_Rated value)? rated,
    TResult? Function(_Failure value)? failure,
  }) {
    return rated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadyToRate value)? readyToRate,
    TResult Function(_Rated value)? rated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (rated != null) {
      return rated(this);
    }
    return orElse();
  }
}

abstract class _Rated implements EventRatingState {
  const factory _Rated({required final int rateForEvent}) = _$RatedImpl;

  int get rateForEvent;

  /// Create a copy of EventRatingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatedImplCopyWith<_$RatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$EventRatingStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventRatingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl();

  @override
  String toString() {
    return 'EventRatingState.failure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() readyToRate,
    required TResult Function(int rateForEvent) rated,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? readyToRate,
    TResult? Function(int rateForEvent)? rated,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? readyToRate,
    TResult Function(int rateForEvent)? rated,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ReadyToRate value) readyToRate,
    required TResult Function(_Rated value) rated,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ReadyToRate value)? readyToRate,
    TResult? Function(_Rated value)? rated,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ReadyToRate value)? readyToRate,
    TResult Function(_Rated value)? rated,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements EventRatingState {
  const factory _Failure() = _$FailureImpl;
}
