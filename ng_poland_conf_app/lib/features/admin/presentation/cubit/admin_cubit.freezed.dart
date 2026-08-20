// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminState {

 bool get isAdmin; String? get latestConfId; EngagementConfig? get config; List<SpeakerVoteRank> get ranking; List<ContestParticipant> get participants; List<ContestWinner> get winners; String? get message; bool get loading;
/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminStateCopyWith<AdminState> get copyWith => _$AdminStateCopyWithImpl<AdminState>(this as AdminState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminState&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&(identical(other.latestConfId, latestConfId) || other.latestConfId == latestConfId)&&(identical(other.config, config) || other.config == config)&&const DeepCollectionEquality().equals(other.ranking, ranking)&&const DeepCollectionEquality().equals(other.participants, participants)&&const DeepCollectionEquality().equals(other.winners, winners)&&(identical(other.message, message) || other.message == message)&&(identical(other.loading, loading) || other.loading == loading));
}


@override
int get hashCode => Object.hash(runtimeType,isAdmin,latestConfId,config,const DeepCollectionEquality().hash(ranking),const DeepCollectionEquality().hash(participants),const DeepCollectionEquality().hash(winners),message,loading);

@override
String toString() {
  return 'AdminState(isAdmin: $isAdmin, latestConfId: $latestConfId, config: $config, ranking: $ranking, participants: $participants, winners: $winners, message: $message, loading: $loading)';
}


}

/// @nodoc
abstract mixin class $AdminStateCopyWith<$Res>  {
  factory $AdminStateCopyWith(AdminState value, $Res Function(AdminState) _then) = _$AdminStateCopyWithImpl;
@useResult
$Res call({
 bool isAdmin, String? latestConfId, EngagementConfig? config, List<SpeakerVoteRank> ranking, List<ContestParticipant> participants, List<ContestWinner> winners, String? message, bool loading
});




}
/// @nodoc
class _$AdminStateCopyWithImpl<$Res>
    implements $AdminStateCopyWith<$Res> {
  _$AdminStateCopyWithImpl(this._self, this._then);

  final AdminState _self;
  final $Res Function(AdminState) _then;

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAdmin = null,Object? latestConfId = freezed,Object? config = freezed,Object? ranking = null,Object? participants = null,Object? winners = null,Object? message = freezed,Object? loading = null,}) {
  return _then(_self.copyWith(
isAdmin: null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,latestConfId: freezed == latestConfId ? _self.latestConfId : latestConfId // ignore: cast_nullable_to_non_nullable
as String?,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as EngagementConfig?,ranking: null == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as List<SpeakerVoteRank>,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<ContestParticipant>,winners: null == winners ? _self.winners : winners // ignore: cast_nullable_to_non_nullable
as List<ContestWinner>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminState].
extension AdminStatePatterns on AdminState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminState value)  $default,){
final _that = this;
switch (_that) {
case _AdminState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isAdmin,  String? latestConfId,  EngagementConfig? config,  List<SpeakerVoteRank> ranking,  List<ContestParticipant> participants,  List<ContestWinner> winners,  String? message,  bool loading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminState() when $default != null:
return $default(_that.isAdmin,_that.latestConfId,_that.config,_that.ranking,_that.participants,_that.winners,_that.message,_that.loading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isAdmin,  String? latestConfId,  EngagementConfig? config,  List<SpeakerVoteRank> ranking,  List<ContestParticipant> participants,  List<ContestWinner> winners,  String? message,  bool loading)  $default,) {final _that = this;
switch (_that) {
case _AdminState():
return $default(_that.isAdmin,_that.latestConfId,_that.config,_that.ranking,_that.participants,_that.winners,_that.message,_that.loading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isAdmin,  String? latestConfId,  EngagementConfig? config,  List<SpeakerVoteRank> ranking,  List<ContestParticipant> participants,  List<ContestWinner> winners,  String? message,  bool loading)?  $default,) {final _that = this;
switch (_that) {
case _AdminState() when $default != null:
return $default(_that.isAdmin,_that.latestConfId,_that.config,_that.ranking,_that.participants,_that.winners,_that.message,_that.loading);case _:
  return null;

}
}

}

/// @nodoc


class _AdminState extends AdminState {
  const _AdminState({this.isAdmin = false, this.latestConfId, this.config, final  List<SpeakerVoteRank> ranking = const <SpeakerVoteRank>[], final  List<ContestParticipant> participants = const <ContestParticipant>[], final  List<ContestWinner> winners = const <ContestWinner>[], this.message, this.loading = false}): _ranking = ranking,_participants = participants,_winners = winners,super._();
  

@override@JsonKey() final  bool isAdmin;
@override final  String? latestConfId;
@override final  EngagementConfig? config;
 final  List<SpeakerVoteRank> _ranking;
@override@JsonKey() List<SpeakerVoteRank> get ranking {
  if (_ranking is EqualUnmodifiableListView) return _ranking;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ranking);
}

 final  List<ContestParticipant> _participants;
@override@JsonKey() List<ContestParticipant> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

 final  List<ContestWinner> _winners;
@override@JsonKey() List<ContestWinner> get winners {
  if (_winners is EqualUnmodifiableListView) return _winners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_winners);
}

@override final  String? message;
@override@JsonKey() final  bool loading;

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminStateCopyWith<_AdminState> get copyWith => __$AdminStateCopyWithImpl<_AdminState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminState&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&(identical(other.latestConfId, latestConfId) || other.latestConfId == latestConfId)&&(identical(other.config, config) || other.config == config)&&const DeepCollectionEquality().equals(other._ranking, _ranking)&&const DeepCollectionEquality().equals(other._participants, _participants)&&const DeepCollectionEquality().equals(other._winners, _winners)&&(identical(other.message, message) || other.message == message)&&(identical(other.loading, loading) || other.loading == loading));
}


@override
int get hashCode => Object.hash(runtimeType,isAdmin,latestConfId,config,const DeepCollectionEquality().hash(_ranking),const DeepCollectionEquality().hash(_participants),const DeepCollectionEquality().hash(_winners),message,loading);

@override
String toString() {
  return 'AdminState(isAdmin: $isAdmin, latestConfId: $latestConfId, config: $config, ranking: $ranking, participants: $participants, winners: $winners, message: $message, loading: $loading)';
}


}

/// @nodoc
abstract mixin class _$AdminStateCopyWith<$Res> implements $AdminStateCopyWith<$Res> {
  factory _$AdminStateCopyWith(_AdminState value, $Res Function(_AdminState) _then) = __$AdminStateCopyWithImpl;
@override @useResult
$Res call({
 bool isAdmin, String? latestConfId, EngagementConfig? config, List<SpeakerVoteRank> ranking, List<ContestParticipant> participants, List<ContestWinner> winners, String? message, bool loading
});




}
/// @nodoc
class __$AdminStateCopyWithImpl<$Res>
    implements _$AdminStateCopyWith<$Res> {
  __$AdminStateCopyWithImpl(this._self, this._then);

  final _AdminState _self;
  final $Res Function(_AdminState) _then;

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAdmin = null,Object? latestConfId = freezed,Object? config = freezed,Object? ranking = null,Object? participants = null,Object? winners = null,Object? message = freezed,Object? loading = null,}) {
  return _then(_AdminState(
isAdmin: null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,latestConfId: freezed == latestConfId ? _self.latestConfId : latestConfId // ignore: cast_nullable_to_non_nullable
as String?,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as EngagementConfig?,ranking: null == ranking ? _self._ranking : ranking // ignore: cast_nullable_to_non_nullable
as List<SpeakerVoteRank>,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<ContestParticipant>,winners: null == winners ? _self._winners : winners // ignore: cast_nullable_to_non_nullable
as List<ContestWinner>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
