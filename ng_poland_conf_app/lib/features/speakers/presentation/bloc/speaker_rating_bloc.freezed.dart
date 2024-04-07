// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speaker_rating_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SpeakerRatingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getRateForSpeaker,
    required TResult Function(int rate) rateSpeaker,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getRateForSpeaker,
    TResult? Function(int rate)? rateSpeaker,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getRateForSpeaker,
    TResult Function(int rate)? rateSpeaker,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRateForSpeaker value) getRateForSpeaker,
    required TResult Function(_RateSpeaker value) rateSpeaker,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRateForSpeaker value)? getRateForSpeaker,
    TResult? Function(_RateSpeaker value)? rateSpeaker,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRateForSpeaker value)? getRateForSpeaker,
    TResult Function(_RateSpeaker value)? rateSpeaker,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeakerRatingEventCopyWith<$Res> {
  factory $SpeakerRatingEventCopyWith(
          SpeakerRatingEvent value, $Res Function(SpeakerRatingEvent) then) =
      _$SpeakerRatingEventCopyWithImpl<$Res, SpeakerRatingEvent>;
}

/// @nodoc
class _$SpeakerRatingEventCopyWithImpl<$Res, $Val extends SpeakerRatingEvent>
    implements $SpeakerRatingEventCopyWith<$Res> {
  _$SpeakerRatingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetRateForSpeakerImplCopyWith<$Res> {
  factory _$$GetRateForSpeakerImplCopyWith(_$GetRateForSpeakerImpl value,
          $Res Function(_$GetRateForSpeakerImpl) then) =
      __$$GetRateForSpeakerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetRateForSpeakerImplCopyWithImpl<$Res>
    extends _$SpeakerRatingEventCopyWithImpl<$Res, _$GetRateForSpeakerImpl>
    implements _$$GetRateForSpeakerImplCopyWith<$Res> {
  __$$GetRateForSpeakerImplCopyWithImpl(_$GetRateForSpeakerImpl _value,
      $Res Function(_$GetRateForSpeakerImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetRateForSpeakerImpl implements _GetRateForSpeaker {
  const _$GetRateForSpeakerImpl();

  @override
  String toString() {
    return 'SpeakerRatingEvent.getRateForSpeaker()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetRateForSpeakerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getRateForSpeaker,
    required TResult Function(int rate) rateSpeaker,
  }) {
    return getRateForSpeaker();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getRateForSpeaker,
    TResult? Function(int rate)? rateSpeaker,
  }) {
    return getRateForSpeaker?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getRateForSpeaker,
    TResult Function(int rate)? rateSpeaker,
    required TResult orElse(),
  }) {
    if (getRateForSpeaker != null) {
      return getRateForSpeaker();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRateForSpeaker value) getRateForSpeaker,
    required TResult Function(_RateSpeaker value) rateSpeaker,
  }) {
    return getRateForSpeaker(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRateForSpeaker value)? getRateForSpeaker,
    TResult? Function(_RateSpeaker value)? rateSpeaker,
  }) {
    return getRateForSpeaker?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRateForSpeaker value)? getRateForSpeaker,
    TResult Function(_RateSpeaker value)? rateSpeaker,
    required TResult orElse(),
  }) {
    if (getRateForSpeaker != null) {
      return getRateForSpeaker(this);
    }
    return orElse();
  }
}

abstract class _GetRateForSpeaker implements SpeakerRatingEvent {
  const factory _GetRateForSpeaker() = _$GetRateForSpeakerImpl;
}

/// @nodoc
abstract class _$$RateSpeakerImplCopyWith<$Res> {
  factory _$$RateSpeakerImplCopyWith(
          _$RateSpeakerImpl value, $Res Function(_$RateSpeakerImpl) then) =
      __$$RateSpeakerImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int rate});
}

/// @nodoc
class __$$RateSpeakerImplCopyWithImpl<$Res>
    extends _$SpeakerRatingEventCopyWithImpl<$Res, _$RateSpeakerImpl>
    implements _$$RateSpeakerImplCopyWith<$Res> {
  __$$RateSpeakerImplCopyWithImpl(
      _$RateSpeakerImpl _value, $Res Function(_$RateSpeakerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rate = null,
  }) {
    return _then(_$RateSpeakerImpl(
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RateSpeakerImpl implements _RateSpeaker {
  const _$RateSpeakerImpl({required this.rate});

  @override
  final int rate;

  @override
  String toString() {
    return 'SpeakerRatingEvent.rateSpeaker(rate: $rate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateSpeakerImpl &&
            (identical(other.rate, rate) || other.rate == rate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RateSpeakerImplCopyWith<_$RateSpeakerImpl> get copyWith =>
      __$$RateSpeakerImplCopyWithImpl<_$RateSpeakerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getRateForSpeaker,
    required TResult Function(int rate) rateSpeaker,
  }) {
    return rateSpeaker(rate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getRateForSpeaker,
    TResult? Function(int rate)? rateSpeaker,
  }) {
    return rateSpeaker?.call(rate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getRateForSpeaker,
    TResult Function(int rate)? rateSpeaker,
    required TResult orElse(),
  }) {
    if (rateSpeaker != null) {
      return rateSpeaker(rate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRateForSpeaker value) getRateForSpeaker,
    required TResult Function(_RateSpeaker value) rateSpeaker,
  }) {
    return rateSpeaker(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRateForSpeaker value)? getRateForSpeaker,
    TResult? Function(_RateSpeaker value)? rateSpeaker,
  }) {
    return rateSpeaker?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRateForSpeaker value)? getRateForSpeaker,
    TResult Function(_RateSpeaker value)? rateSpeaker,
    required TResult orElse(),
  }) {
    if (rateSpeaker != null) {
      return rateSpeaker(this);
    }
    return orElse();
  }
}

abstract class _RateSpeaker implements SpeakerRatingEvent {
  const factory _RateSpeaker({required final int rate}) = _$RateSpeakerImpl;

  int get rate;
  @JsonKey(ignore: true)
  _$$RateSpeakerImplCopyWith<_$RateSpeakerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SpeakerRatingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() readyToRate,
    required TResult Function(int rateForSpeaker) rated,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? readyToRate,
    TResult? Function(int rateForSpeaker)? rated,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? readyToRate,
    TResult Function(int rateForSpeaker)? rated,
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
abstract class $SpeakerRatingStateCopyWith<$Res> {
  factory $SpeakerRatingStateCopyWith(
          SpeakerRatingState value, $Res Function(SpeakerRatingState) then) =
      _$SpeakerRatingStateCopyWithImpl<$Res, SpeakerRatingState>;
}

/// @nodoc
class _$SpeakerRatingStateCopyWithImpl<$Res, $Val extends SpeakerRatingState>
    implements $SpeakerRatingStateCopyWith<$Res> {
  _$SpeakerRatingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SpeakerRatingStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SpeakerRatingState.initial()';
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
    required TResult Function(int rateForSpeaker) rated,
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
    TResult? Function(int rateForSpeaker)? rated,
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
    TResult Function(int rateForSpeaker)? rated,
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

abstract class _Initial implements SpeakerRatingState {
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
    extends _$SpeakerRatingStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'SpeakerRatingState.loading()';
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
    required TResult Function(int rateForSpeaker) rated,
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
    TResult? Function(int rateForSpeaker)? rated,
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
    TResult Function(int rateForSpeaker)? rated,
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

abstract class _Loading implements SpeakerRatingState {
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
    extends _$SpeakerRatingStateCopyWithImpl<$Res, _$ReadyToRateImpl>
    implements _$$ReadyToRateImplCopyWith<$Res> {
  __$$ReadyToRateImplCopyWithImpl(
      _$ReadyToRateImpl _value, $Res Function(_$ReadyToRateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ReadyToRateImpl implements _ReadyToRate {
  const _$ReadyToRateImpl();

  @override
  String toString() {
    return 'SpeakerRatingState.readyToRate()';
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
    required TResult Function(int rateForSpeaker) rated,
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
    TResult? Function(int rateForSpeaker)? rated,
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
    TResult Function(int rateForSpeaker)? rated,
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

abstract class _ReadyToRate implements SpeakerRatingState {
  const factory _ReadyToRate() = _$ReadyToRateImpl;
}

/// @nodoc
abstract class _$$RatedImplCopyWith<$Res> {
  factory _$$RatedImplCopyWith(
          _$RatedImpl value, $Res Function(_$RatedImpl) then) =
      __$$RatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int rateForSpeaker});
}

/// @nodoc
class __$$RatedImplCopyWithImpl<$Res>
    extends _$SpeakerRatingStateCopyWithImpl<$Res, _$RatedImpl>
    implements _$$RatedImplCopyWith<$Res> {
  __$$RatedImplCopyWithImpl(
      _$RatedImpl _value, $Res Function(_$RatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rateForSpeaker = null,
  }) {
    return _then(_$RatedImpl(
      rateForSpeaker: null == rateForSpeaker
          ? _value.rateForSpeaker
          : rateForSpeaker // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RatedImpl implements _Rated {
  const _$RatedImpl({required this.rateForSpeaker});

  @override
  final int rateForSpeaker;

  @override
  String toString() {
    return 'SpeakerRatingState.rated(rateForSpeaker: $rateForSpeaker)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatedImpl &&
            (identical(other.rateForSpeaker, rateForSpeaker) ||
                other.rateForSpeaker == rateForSpeaker));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rateForSpeaker);

  @JsonKey(ignore: true)
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
    required TResult Function(int rateForSpeaker) rated,
    required TResult Function() failure,
  }) {
    return rated(rateForSpeaker);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? readyToRate,
    TResult? Function(int rateForSpeaker)? rated,
    TResult? Function()? failure,
  }) {
    return rated?.call(rateForSpeaker);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? readyToRate,
    TResult Function(int rateForSpeaker)? rated,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (rated != null) {
      return rated(rateForSpeaker);
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

abstract class _Rated implements SpeakerRatingState {
  const factory _Rated({required final int rateForSpeaker}) = _$RatedImpl;

  int get rateForSpeaker;
  @JsonKey(ignore: true)
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
    extends _$SpeakerRatingStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl();

  @override
  String toString() {
    return 'SpeakerRatingState.failure()';
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
    required TResult Function(int rateForSpeaker) rated,
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
    TResult? Function(int rateForSpeaker)? rated,
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
    TResult Function(int rateForSpeaker)? rated,
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

abstract class _Failure implements SpeakerRatingState {
  const factory _Failure() = _$FailureImpl;
}
