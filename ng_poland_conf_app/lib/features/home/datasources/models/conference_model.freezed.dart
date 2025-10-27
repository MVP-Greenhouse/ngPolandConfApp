// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conference_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConferenceModel {

@HiveField(0) String get confId;@HiveField(1) String get confName;@HiveField(2) String? get description;@HiveField(3) String? get conferencesStartDate;@JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)@HiveField(4) List<ConferenceHomePageScheduleItemModel>? get listItems;
/// Create a copy of ConferenceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConferenceModelCopyWith<ConferenceModel> get copyWith => _$ConferenceModelCopyWithImpl<ConferenceModel>(this as ConferenceModel, _$identity);

  /// Serializes this ConferenceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConferenceModel&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.confName, confName) || other.confName == confName)&&(identical(other.description, description) || other.description == description)&&(identical(other.conferencesStartDate, conferencesStartDate) || other.conferencesStartDate == conferencesStartDate)&&const DeepCollectionEquality().equals(other.listItems, listItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,confId,confName,description,conferencesStartDate,const DeepCollectionEquality().hash(listItems));

@override
String toString() {
  return 'ConferenceModel(confId: $confId, confName: $confName, description: $description, conferencesStartDate: $conferencesStartDate, listItems: $listItems)';
}


}

/// @nodoc
abstract mixin class $ConferenceModelCopyWith<$Res>  {
  factory $ConferenceModelCopyWith(ConferenceModel value, $Res Function(ConferenceModel) _then) = _$ConferenceModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String confId,@HiveField(1) String confName,@HiveField(2) String? description,@HiveField(3) String? conferencesStartDate,@JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)@HiveField(4) List<ConferenceHomePageScheduleItemModel>? listItems
});




}
/// @nodoc
class _$ConferenceModelCopyWithImpl<$Res>
    implements $ConferenceModelCopyWith<$Res> {
  _$ConferenceModelCopyWithImpl(this._self, this._then);

  final ConferenceModel _self;
  final $Res Function(ConferenceModel) _then;

/// Create a copy of ConferenceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? confId = null,Object? confName = null,Object? description = freezed,Object? conferencesStartDate = freezed,Object? listItems = freezed,}) {
  return _then(_self.copyWith(
confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,confName: null == confName ? _self.confName : confName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,conferencesStartDate: freezed == conferencesStartDate ? _self.conferencesStartDate : conferencesStartDate // ignore: cast_nullable_to_non_nullable
as String?,listItems: freezed == listItems ? _self.listItems : listItems // ignore: cast_nullable_to_non_nullable
as List<ConferenceHomePageScheduleItemModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConferenceModel].
extension ConferenceModelPatterns on ConferenceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConferenceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConferenceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConferenceModel value)  $default,){
final _that = this;
switch (_that) {
case _ConferenceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConferenceModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConferenceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String confId, @HiveField(1)  String confName, @HiveField(2)  String? description, @HiveField(3)  String? conferencesStartDate, @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)@HiveField(4)  List<ConferenceHomePageScheduleItemModel>? listItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConferenceModel() when $default != null:
return $default(_that.confId,_that.confName,_that.description,_that.conferencesStartDate,_that.listItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String confId, @HiveField(1)  String confName, @HiveField(2)  String? description, @HiveField(3)  String? conferencesStartDate, @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)@HiveField(4)  List<ConferenceHomePageScheduleItemModel>? listItems)  $default,) {final _that = this;
switch (_that) {
case _ConferenceModel():
return $default(_that.confId,_that.confName,_that.description,_that.conferencesStartDate,_that.listItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String confId, @HiveField(1)  String confName, @HiveField(2)  String? description, @HiveField(3)  String? conferencesStartDate, @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)@HiveField(4)  List<ConferenceHomePageScheduleItemModel>? listItems)?  $default,) {final _that = this;
switch (_that) {
case _ConferenceModel() when $default != null:
return $default(_that.confId,_that.confName,_that.description,_that.conferencesStartDate,_that.listItems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConferenceModel extends ConferenceModel {
  const _ConferenceModel({@HiveField(0) required this.confId, @HiveField(1) required this.confName, @HiveField(2) this.description, @HiveField(3) this.conferencesStartDate, @JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)@HiveField(4) final  List<ConferenceHomePageScheduleItemModel>? listItems}): _listItems = listItems,super._();
  factory _ConferenceModel.fromJson(Map<String, dynamic> json) => _$ConferenceModelFromJson(json);

@override@HiveField(0) final  String confId;
@override@HiveField(1) final  String confName;
@override@HiveField(2) final  String? description;
@override@HiveField(3) final  String? conferencesStartDate;
 final  List<ConferenceHomePageScheduleItemModel>? _listItems;
@override@JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)@HiveField(4) List<ConferenceHomePageScheduleItemModel>? get listItems {
  final value = _listItems;
  if (value == null) return null;
  if (_listItems is EqualUnmodifiableListView) return _listItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ConferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConferenceModelCopyWith<_ConferenceModel> get copyWith => __$ConferenceModelCopyWithImpl<_ConferenceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConferenceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConferenceModel&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.confName, confName) || other.confName == confName)&&(identical(other.description, description) || other.description == description)&&(identical(other.conferencesStartDate, conferencesStartDate) || other.conferencesStartDate == conferencesStartDate)&&const DeepCollectionEquality().equals(other._listItems, _listItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,confId,confName,description,conferencesStartDate,const DeepCollectionEquality().hash(_listItems));

@override
String toString() {
  return 'ConferenceModel(confId: $confId, confName: $confName, description: $description, conferencesStartDate: $conferencesStartDate, listItems: $listItems)';
}


}

/// @nodoc
abstract mixin class _$ConferenceModelCopyWith<$Res> implements $ConferenceModelCopyWith<$Res> {
  factory _$ConferenceModelCopyWith(_ConferenceModel value, $Res Function(_ConferenceModel) _then) = __$ConferenceModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String confId,@HiveField(1) String confName,@HiveField(2) String? description,@HiveField(3) String? conferencesStartDate,@JsonKey(name: 'conferenceHomePageSchedule', fromJson: _listItemsFromJson)@HiveField(4) List<ConferenceHomePageScheduleItemModel>? listItems
});




}
/// @nodoc
class __$ConferenceModelCopyWithImpl<$Res>
    implements _$ConferenceModelCopyWith<$Res> {
  __$ConferenceModelCopyWithImpl(this._self, this._then);

  final _ConferenceModel _self;
  final $Res Function(_ConferenceModel) _then;

/// Create a copy of ConferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? confId = null,Object? confName = null,Object? description = freezed,Object? conferencesStartDate = freezed,Object? listItems = freezed,}) {
  return _then(_ConferenceModel(
confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,confName: null == confName ? _self.confName : confName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,conferencesStartDate: freezed == conferencesStartDate ? _self.conferencesStartDate : conferencesStartDate // ignore: cast_nullable_to_non_nullable
as String?,listItems: freezed == listItems ? _self._listItems : listItems // ignore: cast_nullable_to_non_nullable
as List<ConferenceHomePageScheduleItemModel>?,
  ));
}


}

// dart format on
