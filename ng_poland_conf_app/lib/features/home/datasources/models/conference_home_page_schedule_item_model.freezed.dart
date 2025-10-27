// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conference_home_page_schedule_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConferenceHomePageScheduleItemModel {

@HiveField(0) String get name;@HiveField(1) String get desc;
/// Create a copy of ConferenceHomePageScheduleItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConferenceHomePageScheduleItemModelCopyWith<ConferenceHomePageScheduleItemModel> get copyWith => _$ConferenceHomePageScheduleItemModelCopyWithImpl<ConferenceHomePageScheduleItemModel>(this as ConferenceHomePageScheduleItemModel, _$identity);

  /// Serializes this ConferenceHomePageScheduleItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConferenceHomePageScheduleItemModel&&(identical(other.name, name) || other.name == name)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,desc);

@override
String toString() {
  return 'ConferenceHomePageScheduleItemModel(name: $name, desc: $desc)';
}


}

/// @nodoc
abstract mixin class $ConferenceHomePageScheduleItemModelCopyWith<$Res>  {
  factory $ConferenceHomePageScheduleItemModelCopyWith(ConferenceHomePageScheduleItemModel value, $Res Function(ConferenceHomePageScheduleItemModel) _then) = _$ConferenceHomePageScheduleItemModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String name,@HiveField(1) String desc
});




}
/// @nodoc
class _$ConferenceHomePageScheduleItemModelCopyWithImpl<$Res>
    implements $ConferenceHomePageScheduleItemModelCopyWith<$Res> {
  _$ConferenceHomePageScheduleItemModelCopyWithImpl(this._self, this._then);

  final ConferenceHomePageScheduleItemModel _self;
  final $Res Function(ConferenceHomePageScheduleItemModel) _then;

/// Create a copy of ConferenceHomePageScheduleItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? desc = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConferenceHomePageScheduleItemModel].
extension ConferenceHomePageScheduleItemModelPatterns on ConferenceHomePageScheduleItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConferenceHomePageScheduleItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConferenceHomePageScheduleItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConferenceHomePageScheduleItemModel value)  $default,){
final _that = this;
switch (_that) {
case _ConferenceHomePageScheduleItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConferenceHomePageScheduleItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConferenceHomePageScheduleItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String name, @HiveField(1)  String desc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConferenceHomePageScheduleItemModel() when $default != null:
return $default(_that.name,_that.desc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String name, @HiveField(1)  String desc)  $default,) {final _that = this;
switch (_that) {
case _ConferenceHomePageScheduleItemModel():
return $default(_that.name,_that.desc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String name, @HiveField(1)  String desc)?  $default,) {final _that = this;
switch (_that) {
case _ConferenceHomePageScheduleItemModel() when $default != null:
return $default(_that.name,_that.desc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConferenceHomePageScheduleItemModel extends ConferenceHomePageScheduleItemModel {
  const _ConferenceHomePageScheduleItemModel({@HiveField(0) required this.name, @HiveField(1) required this.desc}): super._();
  factory _ConferenceHomePageScheduleItemModel.fromJson(Map<String, dynamic> json) => _$ConferenceHomePageScheduleItemModelFromJson(json);

@override@HiveField(0) final  String name;
@override@HiveField(1) final  String desc;

/// Create a copy of ConferenceHomePageScheduleItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConferenceHomePageScheduleItemModelCopyWith<_ConferenceHomePageScheduleItemModel> get copyWith => __$ConferenceHomePageScheduleItemModelCopyWithImpl<_ConferenceHomePageScheduleItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConferenceHomePageScheduleItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConferenceHomePageScheduleItemModel&&(identical(other.name, name) || other.name == name)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,desc);

@override
String toString() {
  return 'ConferenceHomePageScheduleItemModel(name: $name, desc: $desc)';
}


}

/// @nodoc
abstract mixin class _$ConferenceHomePageScheduleItemModelCopyWith<$Res> implements $ConferenceHomePageScheduleItemModelCopyWith<$Res> {
  factory _$ConferenceHomePageScheduleItemModelCopyWith(_ConferenceHomePageScheduleItemModel value, $Res Function(_ConferenceHomePageScheduleItemModel) _then) = __$ConferenceHomePageScheduleItemModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String name,@HiveField(1) String desc
});




}
/// @nodoc
class __$ConferenceHomePageScheduleItemModelCopyWithImpl<$Res>
    implements _$ConferenceHomePageScheduleItemModelCopyWith<$Res> {
  __$ConferenceHomePageScheduleItemModelCopyWithImpl(this._self, this._then);

  final _ConferenceHomePageScheduleItemModel _self;
  final $Res Function(_ConferenceHomePageScheduleItemModel) _then;

/// Create a copy of ConferenceHomePageScheduleItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? desc = null,}) {
  return _then(_ConferenceHomePageScheduleItemModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
