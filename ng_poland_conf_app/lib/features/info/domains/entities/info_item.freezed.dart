// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InfoItem {

 String get title; int get order; String get icon; String? get description; String get confId; String? get urlLink;
/// Create a copy of InfoItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfoItemCopyWith<InfoItem> get copyWith => _$InfoItemCopyWithImpl<InfoItem>(this as InfoItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfoItem&&(identical(other.title, title) || other.title == title)&&(identical(other.order, order) || other.order == order)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.urlLink, urlLink) || other.urlLink == urlLink));
}


@override
int get hashCode => Object.hash(runtimeType,title,order,icon,description,confId,urlLink);

@override
String toString() {
  return 'InfoItem(title: $title, order: $order, icon: $icon, description: $description, confId: $confId, urlLink: $urlLink)';
}


}

/// @nodoc
abstract mixin class $InfoItemCopyWith<$Res>  {
  factory $InfoItemCopyWith(InfoItem value, $Res Function(InfoItem) _then) = _$InfoItemCopyWithImpl;
@useResult
$Res call({
 String title, int order, String icon, String? description, String confId, String? urlLink
});




}
/// @nodoc
class _$InfoItemCopyWithImpl<$Res>
    implements $InfoItemCopyWith<$Res> {
  _$InfoItemCopyWithImpl(this._self, this._then);

  final InfoItem _self;
  final $Res Function(InfoItem) _then;

/// Create a copy of InfoItem
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


/// Adds pattern-matching-related methods to [InfoItem].
extension InfoItemPatterns on InfoItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InfoItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InfoItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InfoItem value)  $default,){
final _that = this;
switch (_that) {
case _InfoItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InfoItem value)?  $default,){
final _that = this;
switch (_that) {
case _InfoItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  int order,  String icon,  String? description,  String confId,  String? urlLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InfoItem() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  int order,  String icon,  String? description,  String confId,  String? urlLink)  $default,) {final _that = this;
switch (_that) {
case _InfoItem():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  int order,  String icon,  String? description,  String confId,  String? urlLink)?  $default,) {final _that = this;
switch (_that) {
case _InfoItem() when $default != null:
return $default(_that.title,_that.order,_that.icon,_that.description,_that.confId,_that.urlLink);case _:
  return null;

}
}

}

/// @nodoc


class _InfoItem implements InfoItem {
  const _InfoItem({required this.title, required this.order, required this.icon, required this.description, required this.confId, required this.urlLink});
  

@override final  String title;
@override final  int order;
@override final  String icon;
@override final  String? description;
@override final  String confId;
@override final  String? urlLink;

/// Create a copy of InfoItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfoItemCopyWith<_InfoItem> get copyWith => __$InfoItemCopyWithImpl<_InfoItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InfoItem&&(identical(other.title, title) || other.title == title)&&(identical(other.order, order) || other.order == order)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.confId, confId) || other.confId == confId)&&(identical(other.urlLink, urlLink) || other.urlLink == urlLink));
}


@override
int get hashCode => Object.hash(runtimeType,title,order,icon,description,confId,urlLink);

@override
String toString() {
  return 'InfoItem(title: $title, order: $order, icon: $icon, description: $description, confId: $confId, urlLink: $urlLink)';
}


}

/// @nodoc
abstract mixin class _$InfoItemCopyWith<$Res> implements $InfoItemCopyWith<$Res> {
  factory _$InfoItemCopyWith(_InfoItem value, $Res Function(_InfoItem) _then) = __$InfoItemCopyWithImpl;
@override @useResult
$Res call({
 String title, int order, String icon, String? description, String confId, String? urlLink
});




}
/// @nodoc
class __$InfoItemCopyWithImpl<$Res>
    implements _$InfoItemCopyWith<$Res> {
  __$InfoItemCopyWithImpl(this._self, this._then);

  final _InfoItem _self;
  final $Res Function(_InfoItem) _then;

/// Create a copy of InfoItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? order = null,Object? icon = null,Object? description = freezed,Object? confId = null,Object? urlLink = freezed,}) {
  return _then(_InfoItem(
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
