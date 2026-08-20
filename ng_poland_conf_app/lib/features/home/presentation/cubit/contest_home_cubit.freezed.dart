// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contest_home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContestHomeState {

 ContestHomeView get view; String? get latestConfId; UserProfile? get profile; bool get joinFailed;
/// Create a copy of ContestHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContestHomeStateCopyWith<ContestHomeState> get copyWith => _$ContestHomeStateCopyWithImpl<ContestHomeState>(this as ContestHomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContestHomeState&&(identical(other.view, view) || other.view == view)&&(identical(other.latestConfId, latestConfId) || other.latestConfId == latestConfId)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.joinFailed, joinFailed) || other.joinFailed == joinFailed));
}


@override
int get hashCode => Object.hash(runtimeType,view,latestConfId,profile,joinFailed);

@override
String toString() {
  return 'ContestHomeState(view: $view, latestConfId: $latestConfId, profile: $profile, joinFailed: $joinFailed)';
}


}

/// @nodoc
abstract mixin class $ContestHomeStateCopyWith<$Res>  {
  factory $ContestHomeStateCopyWith(ContestHomeState value, $Res Function(ContestHomeState) _then) = _$ContestHomeStateCopyWithImpl;
@useResult
$Res call({
 ContestHomeView view, String? latestConfId, UserProfile? profile, bool joinFailed
});




}
/// @nodoc
class _$ContestHomeStateCopyWithImpl<$Res>
    implements $ContestHomeStateCopyWith<$Res> {
  _$ContestHomeStateCopyWithImpl(this._self, this._then);

  final ContestHomeState _self;
  final $Res Function(ContestHomeState) _then;

/// Create a copy of ContestHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? view = null,Object? latestConfId = freezed,Object? profile = freezed,Object? joinFailed = null,}) {
  return _then(_self.copyWith(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as ContestHomeView,latestConfId: freezed == latestConfId ? _self.latestConfId : latestConfId // ignore: cast_nullable_to_non_nullable
as String?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,joinFailed: null == joinFailed ? _self.joinFailed : joinFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ContestHomeState].
extension ContestHomeStatePatterns on ContestHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContestHomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContestHomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContestHomeState value)  $default,){
final _that = this;
switch (_that) {
case _ContestHomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContestHomeState value)?  $default,){
final _that = this;
switch (_that) {
case _ContestHomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ContestHomeView view,  String? latestConfId,  UserProfile? profile,  bool joinFailed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContestHomeState() when $default != null:
return $default(_that.view,_that.latestConfId,_that.profile,_that.joinFailed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ContestHomeView view,  String? latestConfId,  UserProfile? profile,  bool joinFailed)  $default,) {final _that = this;
switch (_that) {
case _ContestHomeState():
return $default(_that.view,_that.latestConfId,_that.profile,_that.joinFailed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ContestHomeView view,  String? latestConfId,  UserProfile? profile,  bool joinFailed)?  $default,) {final _that = this;
switch (_that) {
case _ContestHomeState() when $default != null:
return $default(_that.view,_that.latestConfId,_that.profile,_that.joinFailed);case _:
  return null;

}
}

}

/// @nodoc


class _ContestHomeState extends ContestHomeState {
  const _ContestHomeState({this.view = ContestHomeView.hidden, this.latestConfId, this.profile, this.joinFailed = false}): super._();
  

@override@JsonKey() final  ContestHomeView view;
@override final  String? latestConfId;
@override final  UserProfile? profile;
@override@JsonKey() final  bool joinFailed;

/// Create a copy of ContestHomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContestHomeStateCopyWith<_ContestHomeState> get copyWith => __$ContestHomeStateCopyWithImpl<_ContestHomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContestHomeState&&(identical(other.view, view) || other.view == view)&&(identical(other.latestConfId, latestConfId) || other.latestConfId == latestConfId)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.joinFailed, joinFailed) || other.joinFailed == joinFailed));
}


@override
int get hashCode => Object.hash(runtimeType,view,latestConfId,profile,joinFailed);

@override
String toString() {
  return 'ContestHomeState(view: $view, latestConfId: $latestConfId, profile: $profile, joinFailed: $joinFailed)';
}


}

/// @nodoc
abstract mixin class _$ContestHomeStateCopyWith<$Res> implements $ContestHomeStateCopyWith<$Res> {
  factory _$ContestHomeStateCopyWith(_ContestHomeState value, $Res Function(_ContestHomeState) _then) = __$ContestHomeStateCopyWithImpl;
@override @useResult
$Res call({
 ContestHomeView view, String? latestConfId, UserProfile? profile, bool joinFailed
});




}
/// @nodoc
class __$ContestHomeStateCopyWithImpl<$Res>
    implements _$ContestHomeStateCopyWith<$Res> {
  __$ContestHomeStateCopyWithImpl(this._self, this._then);

  final _ContestHomeState _self;
  final $Res Function(_ContestHomeState) _then;

/// Create a copy of ContestHomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? view = null,Object? latestConfId = freezed,Object? profile = freezed,Object? joinFailed = null,}) {
  return _then(_ContestHomeState(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as ContestHomeView,latestConfId: freezed == latestConfId ? _self.latestConfId : latestConfId // ignore: cast_nullable_to_non_nullable
as String?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,joinFailed: null == joinFailed ? _self.joinFailed : joinFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
