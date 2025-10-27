// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ngGirls_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NgGirlsModel {

@HiveField(0) String get myId;@HiveField(1) String? get title;@HiveField(2) String? get text;@HiveField(3) String get confId;@HiveField(4) DateTime? get lastUpdate;
/// Create a copy of NgGirlsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NgGirlsModelCopyWith<NgGirlsModel> get copyWith => _$NgGirlsModelCopyWithImpl<NgGirlsModel>(this as NgGirlsModel, _$identity);

  /// Serializes this NgGirlsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NgGirlsModel&&(identical(other.myId, myId) || other.myId == myId)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,myId,title,text,confId,lastUpdate);

@override
String toString() {
  return 'NgGirlsModel(myId: $myId, title: $title, text: $text, confId: $confId, lastUpdate: $lastUpdate)';
}


}

/// @nodoc
abstract mixin class $NgGirlsModelCopyWith<$Res>  {
  factory $NgGirlsModelCopyWith(NgGirlsModel value, $Res Function(NgGirlsModel) _then) = _$NgGirlsModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String myId,@HiveField(1) String? title,@HiveField(2) String? text,@HiveField(3) String confId,@HiveField(4) DateTime? lastUpdate
});




}
/// @nodoc
class _$NgGirlsModelCopyWithImpl<$Res>
    implements $NgGirlsModelCopyWith<$Res> {
  _$NgGirlsModelCopyWithImpl(this._self, this._then);

  final NgGirlsModel _self;
  final $Res Function(NgGirlsModel) _then;

/// Create a copy of NgGirlsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? myId = null,Object? title = freezed,Object? text = freezed,Object? confId = null,Object? lastUpdate = freezed,}) {
  return _then(_self.copyWith(
myId: null == myId ? _self.myId : myId // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,lastUpdate: freezed == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [NgGirlsModel].
extension NgGirlsModelPatterns on NgGirlsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NgGirlsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NgGirlsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NgGirlsModel value)  $default,){
final _that = this;
switch (_that) {
case _NgGirlsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NgGirlsModel value)?  $default,){
final _that = this;
switch (_that) {
case _NgGirlsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String myId, @HiveField(1)  String? title, @HiveField(2)  String? text, @HiveField(3)  String confId, @HiveField(4)  DateTime? lastUpdate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NgGirlsModel() when $default != null:
return $default(_that.myId,_that.title,_that.text,_that.confId,_that.lastUpdate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String myId, @HiveField(1)  String? title, @HiveField(2)  String? text, @HiveField(3)  String confId, @HiveField(4)  DateTime? lastUpdate)  $default,) {final _that = this;
switch (_that) {
case _NgGirlsModel():
return $default(_that.myId,_that.title,_that.text,_that.confId,_that.lastUpdate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String myId, @HiveField(1)  String? title, @HiveField(2)  String? text, @HiveField(3)  String confId, @HiveField(4)  DateTime? lastUpdate)?  $default,) {final _that = this;
switch (_that) {
case _NgGirlsModel() when $default != null:
return $default(_that.myId,_that.title,_that.text,_that.confId,_that.lastUpdate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NgGirlsModel extends NgGirlsModel {
  const _NgGirlsModel({@HiveField(0) required this.myId, @HiveField(1) required this.title, @HiveField(2) required this.text, @HiveField(3) required this.confId, @HiveField(4) this.lastUpdate}): super._();
  factory _NgGirlsModel.fromJson(Map<String, dynamic> json) => _$NgGirlsModelFromJson(json);

@override@HiveField(0) final  String myId;
@override@HiveField(1) final  String? title;
@override@HiveField(2) final  String? text;
@override@HiveField(3) final  String confId;
@override@HiveField(4) final  DateTime? lastUpdate;

/// Create a copy of NgGirlsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NgGirlsModelCopyWith<_NgGirlsModel> get copyWith => __$NgGirlsModelCopyWithImpl<_NgGirlsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NgGirlsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NgGirlsModel&&(identical(other.myId, myId) || other.myId == myId)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,myId,title,text,confId,lastUpdate);

@override
String toString() {
  return 'NgGirlsModel(myId: $myId, title: $title, text: $text, confId: $confId, lastUpdate: $lastUpdate)';
}


}

/// @nodoc
abstract mixin class _$NgGirlsModelCopyWith<$Res> implements $NgGirlsModelCopyWith<$Res> {
  factory _$NgGirlsModelCopyWith(_NgGirlsModel value, $Res Function(_NgGirlsModel) _then) = __$NgGirlsModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String myId,@HiveField(1) String? title,@HiveField(2) String? text,@HiveField(3) String confId,@HiveField(4) DateTime? lastUpdate
});




}
/// @nodoc
class __$NgGirlsModelCopyWithImpl<$Res>
    implements _$NgGirlsModelCopyWith<$Res> {
  __$NgGirlsModelCopyWithImpl(this._self, this._then);

  final _NgGirlsModel _self;
  final $Res Function(_NgGirlsModel) _then;

/// Create a copy of NgGirlsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? myId = null,Object? title = freezed,Object? text = freezed,Object? confId = null,Object? lastUpdate = freezed,}) {
  return _then(_NgGirlsModel(
myId: null == myId ? _self.myId : myId // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,lastUpdate: freezed == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
