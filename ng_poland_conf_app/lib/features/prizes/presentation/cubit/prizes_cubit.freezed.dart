// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prizes_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrizesState {

 bool get hasPrizes; List<UserPrize> get prizes; bool get loading;
/// Create a copy of PrizesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrizesStateCopyWith<PrizesState> get copyWith => _$PrizesStateCopyWithImpl<PrizesState>(this as PrizesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrizesState&&(identical(other.hasPrizes, hasPrizes) || other.hasPrizes == hasPrizes)&&const DeepCollectionEquality().equals(other.prizes, prizes)&&(identical(other.loading, loading) || other.loading == loading));
}


@override
int get hashCode => Object.hash(runtimeType,hasPrizes,const DeepCollectionEquality().hash(prizes),loading);

@override
String toString() {
  return 'PrizesState(hasPrizes: $hasPrizes, prizes: $prizes, loading: $loading)';
}


}

/// @nodoc
abstract mixin class $PrizesStateCopyWith<$Res>  {
  factory $PrizesStateCopyWith(PrizesState value, $Res Function(PrizesState) _then) = _$PrizesStateCopyWithImpl;
@useResult
$Res call({
 bool hasPrizes, List<UserPrize> prizes, bool loading
});




}
/// @nodoc
class _$PrizesStateCopyWithImpl<$Res>
    implements $PrizesStateCopyWith<$Res> {
  _$PrizesStateCopyWithImpl(this._self, this._then);

  final PrizesState _self;
  final $Res Function(PrizesState) _then;

/// Create a copy of PrizesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasPrizes = null,Object? prizes = null,Object? loading = null,}) {
  return _then(_self.copyWith(
hasPrizes: null == hasPrizes ? _self.hasPrizes : hasPrizes // ignore: cast_nullable_to_non_nullable
as bool,prizes: null == prizes ? _self.prizes : prizes // ignore: cast_nullable_to_non_nullable
as List<UserPrize>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PrizesState].
extension PrizesStatePatterns on PrizesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrizesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrizesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrizesState value)  $default,){
final _that = this;
switch (_that) {
case _PrizesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrizesState value)?  $default,){
final _that = this;
switch (_that) {
case _PrizesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasPrizes,  List<UserPrize> prizes,  bool loading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrizesState() when $default != null:
return $default(_that.hasPrizes,_that.prizes,_that.loading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasPrizes,  List<UserPrize> prizes,  bool loading)  $default,) {final _that = this;
switch (_that) {
case _PrizesState():
return $default(_that.hasPrizes,_that.prizes,_that.loading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasPrizes,  List<UserPrize> prizes,  bool loading)?  $default,) {final _that = this;
switch (_that) {
case _PrizesState() when $default != null:
return $default(_that.hasPrizes,_that.prizes,_that.loading);case _:
  return null;

}
}

}

/// @nodoc


class _PrizesState implements PrizesState {
  const _PrizesState({this.hasPrizes = false, final  List<UserPrize> prizes = const <UserPrize>[], this.loading = true}): _prizes = prizes;
  

@override@JsonKey() final  bool hasPrizes;
 final  List<UserPrize> _prizes;
@override@JsonKey() List<UserPrize> get prizes {
  if (_prizes is EqualUnmodifiableListView) return _prizes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prizes);
}

@override@JsonKey() final  bool loading;

/// Create a copy of PrizesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrizesStateCopyWith<_PrizesState> get copyWith => __$PrizesStateCopyWithImpl<_PrizesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrizesState&&(identical(other.hasPrizes, hasPrizes) || other.hasPrizes == hasPrizes)&&const DeepCollectionEquality().equals(other._prizes, _prizes)&&(identical(other.loading, loading) || other.loading == loading));
}


@override
int get hashCode => Object.hash(runtimeType,hasPrizes,const DeepCollectionEquality().hash(_prizes),loading);

@override
String toString() {
  return 'PrizesState(hasPrizes: $hasPrizes, prizes: $prizes, loading: $loading)';
}


}

/// @nodoc
abstract mixin class _$PrizesStateCopyWith<$Res> implements $PrizesStateCopyWith<$Res> {
  factory _$PrizesStateCopyWith(_PrizesState value, $Res Function(_PrizesState) _then) = __$PrizesStateCopyWithImpl;
@override @useResult
$Res call({
 bool hasPrizes, List<UserPrize> prizes, bool loading
});




}
/// @nodoc
class __$PrizesStateCopyWithImpl<$Res>
    implements _$PrizesStateCopyWith<$Res> {
  __$PrizesStateCopyWithImpl(this._self, this._then);

  final _PrizesState _self;
  final $Res Function(_PrizesState) _then;

/// Create a copy of PrizesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasPrizes = null,Object? prizes = null,Object? loading = null,}) {
  return _then(_PrizesState(
hasPrizes: null == hasPrizes ? _self.hasPrizes : hasPrizes // ignore: cast_nullable_to_non_nullable
as bool,prizes: null == prizes ? _self._prizes : prizes // ignore: cast_nullable_to_non_nullable
as List<UserPrize>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
