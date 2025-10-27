// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InfoItemModel {

@HiveField(0) String get title;@HiveField(1) int get order;@HiveField(2) String get icon;@HiveField(3) String? get description;@HiveField(4) String get confId;@HiveField(5) String? get urlLink;
/// Create a copy of InfoItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfoItemModelCopyWith<InfoItemModel> get copyWith => _$InfoItemModelCopyWithImpl<InfoItemModel>(this as InfoItemModel, _$identity);

  /// Serializes this InfoItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfoItemModel&&(identical(other.title, title) || other.title == title)&&(identical(other.order, order) || other.order == order)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.urlLink, urlLink) || other.urlLink == urlLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,order,icon,description,confId,urlLink);

@override
String toString() {
  return 'InfoItemModel(title: $title, order: $order, icon: $icon, description: $description, confId: $confId, urlLink: $urlLink)';
}


}

/// @nodoc
abstract mixin class $InfoItemModelCopyWith<$Res>  {
  factory $InfoItemModelCopyWith(InfoItemModel value, $Res Function(InfoItemModel) _then) = _$InfoItemModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String title,@HiveField(1) int order,@HiveField(2) String icon,@HiveField(3) String? description,@HiveField(4) String confId,@HiveField(5) String? urlLink
});




}
/// @nodoc
class _$InfoItemModelCopyWithImpl<$Res>
    implements $InfoItemModelCopyWith<$Res> {
  _$InfoItemModelCopyWithImpl(this._self, this._then);

  final InfoItemModel _self;
  final $Res Function(InfoItemModel) _then;

/// Create a copy of InfoItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? order = null,Object? icon = null,Object? description = freezed,Object? confId = null,Object? urlLink = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,urlLink: freezed == urlLink ? _self.urlLink : urlLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InfoItemModel].
extension InfoItemModelPatterns on InfoItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InfoItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InfoItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InfoItemModel value)  $default,){
final _that = this;
switch (_that) {
case _InfoItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InfoItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _InfoItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String title, @HiveField(1)  int order, @HiveField(2)  String icon, @HiveField(3)  String? description, @HiveField(4)  String confId, @HiveField(5)  String? urlLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InfoItemModel() when $default != null:
return $default(_that.title,_that.order,_that.icon,_that.description,_that.confId,_that.urlLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String title, @HiveField(1)  int order, @HiveField(2)  String icon, @HiveField(3)  String? description, @HiveField(4)  String confId, @HiveField(5)  String? urlLink)  $default,) {final _that = this;
switch (_that) {
case _InfoItemModel():
return $default(_that.title,_that.order,_that.icon,_that.description,_that.confId,_that.urlLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String title, @HiveField(1)  int order, @HiveField(2)  String icon, @HiveField(3)  String? description, @HiveField(4)  String confId, @HiveField(5)  String? urlLink)?  $default,) {final _that = this;
switch (_that) {
case _InfoItemModel() when $default != null:
return $default(_that.title,_that.order,_that.icon,_that.description,_that.confId,_that.urlLink);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InfoItemModel extends InfoItemModel {
  const _InfoItemModel({@HiveField(0) required this.title, @HiveField(1) required this.order, @HiveField(2) required this.icon, @HiveField(3) this.description, @HiveField(4) required this.confId, @HiveField(5) this.urlLink}): super._();
  factory _InfoItemModel.fromJson(Map<String, dynamic> json) => _$InfoItemModelFromJson(json);

@override@HiveField(0) final  String title;
@override@HiveField(1) final  int order;
@override@HiveField(2) final  String icon;
@override@HiveField(3) final  String? description;
@override@HiveField(4) final  String confId;
@override@HiveField(5) final  String? urlLink;

/// Create a copy of InfoItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfoItemModelCopyWith<_InfoItemModel> get copyWith => __$InfoItemModelCopyWithImpl<_InfoItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InfoItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InfoItemModel&&(identical(other.title, title) || other.title == title)&&(identical(other.order, order) || other.order == order)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.urlLink, urlLink) || other.urlLink == urlLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,order,icon,description,confId,urlLink);

@override
String toString() {
  return 'InfoItemModel(title: $title, order: $order, icon: $icon, description: $description, confId: $confId, urlLink: $urlLink)';
}


}

/// @nodoc
abstract mixin class _$InfoItemModelCopyWith<$Res> implements $InfoItemModelCopyWith<$Res> {
  factory _$InfoItemModelCopyWith(_InfoItemModel value, $Res Function(_InfoItemModel) _then) = __$InfoItemModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String title,@HiveField(1) int order,@HiveField(2) String icon,@HiveField(3) String? description,@HiveField(4) String confId,@HiveField(5) String? urlLink
});




}
/// @nodoc
class __$InfoItemModelCopyWithImpl<$Res>
    implements _$InfoItemModelCopyWith<$Res> {
  __$InfoItemModelCopyWithImpl(this._self, this._then);

  final _InfoItemModel _self;
  final $Res Function(_InfoItemModel) _then;

/// Create a copy of InfoItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? order = null,Object? icon = null,Object? description = freezed,Object? confId = null,Object? urlLink = freezed,}) {
  return _then(_InfoItemModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,confId: null == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as String,urlLink: freezed == urlLink ? _self.urlLink : urlLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
