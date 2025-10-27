// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_items_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InfoItemsModel {

@HiveField(0) List<InfoItemModel>? get items;@HiveField(1) DateTime? get lastUpdate;@HiveField(2) dynamic get confId;
/// Create a copy of InfoItemsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfoItemsModelCopyWith<InfoItemsModel> get copyWith => _$InfoItemsModelCopyWithImpl<InfoItemsModel>(this as InfoItemsModel, _$identity);

  /// Serializes this InfoItemsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfoItemsModel&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate)&&const DeepCollectionEquality().equals(other.confId, confId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),lastUpdate,const DeepCollectionEquality().hash(confId));

@override
String toString() {
  return 'InfoItemsModel(items: $items, lastUpdate: $lastUpdate, confId: $confId)';
}


}

/// @nodoc
abstract mixin class $InfoItemsModelCopyWith<$Res>  {
  factory $InfoItemsModelCopyWith(InfoItemsModel value, $Res Function(InfoItemsModel) _then) = _$InfoItemsModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) List<InfoItemModel>? items,@HiveField(1) DateTime? lastUpdate,@HiveField(2) dynamic confId
});




}
/// @nodoc
class _$InfoItemsModelCopyWithImpl<$Res>
    implements $InfoItemsModelCopyWith<$Res> {
  _$InfoItemsModelCopyWithImpl(this._self, this._then);

  final InfoItemsModel _self;
  final $Res Function(InfoItemsModel) _then;

/// Create a copy of InfoItemsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = freezed,Object? lastUpdate = freezed,Object? confId = freezed,}) {
  return _then(_self.copyWith(
items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<InfoItemModel>?,lastUpdate: freezed == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as DateTime?,confId: freezed == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [InfoItemsModel].
extension InfoItemsModelPatterns on InfoItemsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InfoItemsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InfoItemsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InfoItemsModel value)  $default,){
final _that = this;
switch (_that) {
case _InfoItemsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InfoItemsModel value)?  $default,){
final _that = this;
switch (_that) {
case _InfoItemsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  List<InfoItemModel>? items, @HiveField(1)  DateTime? lastUpdate, @HiveField(2)  dynamic confId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InfoItemsModel() when $default != null:
return $default(_that.items,_that.lastUpdate,_that.confId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  List<InfoItemModel>? items, @HiveField(1)  DateTime? lastUpdate, @HiveField(2)  dynamic confId)  $default,) {final _that = this;
switch (_that) {
case _InfoItemsModel():
return $default(_that.items,_that.lastUpdate,_that.confId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  List<InfoItemModel>? items, @HiveField(1)  DateTime? lastUpdate, @HiveField(2)  dynamic confId)?  $default,) {final _that = this;
switch (_that) {
case _InfoItemsModel() when $default != null:
return $default(_that.items,_that.lastUpdate,_that.confId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InfoItemsModel extends InfoItemsModel {
  const _InfoItemsModel({@HiveField(0) required final  List<InfoItemModel>? items, @HiveField(1) this.lastUpdate, @HiveField(2) this.confId}): _items = items,super._();
  factory _InfoItemsModel.fromJson(Map<String, dynamic> json) => _$InfoItemsModelFromJson(json);

 final  List<InfoItemModel>? _items;
@override@HiveField(0) List<InfoItemModel>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@HiveField(1) final  DateTime? lastUpdate;
@override@HiveField(2) final  dynamic confId;

/// Create a copy of InfoItemsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfoItemsModelCopyWith<_InfoItemsModel> get copyWith => __$InfoItemsModelCopyWithImpl<_InfoItemsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InfoItemsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InfoItemsModel&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate)&&const DeepCollectionEquality().equals(other.confId, confId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),lastUpdate,const DeepCollectionEquality().hash(confId));

@override
String toString() {
  return 'InfoItemsModel(items: $items, lastUpdate: $lastUpdate, confId: $confId)';
}


}

/// @nodoc
abstract mixin class _$InfoItemsModelCopyWith<$Res> implements $InfoItemsModelCopyWith<$Res> {
  factory _$InfoItemsModelCopyWith(_InfoItemsModel value, $Res Function(_InfoItemsModel) _then) = __$InfoItemsModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) List<InfoItemModel>? items,@HiveField(1) DateTime? lastUpdate,@HiveField(2) dynamic confId
});




}
/// @nodoc
class __$InfoItemsModelCopyWithImpl<$Res>
    implements _$InfoItemsModelCopyWith<$Res> {
  __$InfoItemsModelCopyWithImpl(this._self, this._then);

  final _InfoItemsModel _self;
  final $Res Function(_InfoItemsModel) _then;

/// Create a copy of InfoItemsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = freezed,Object? lastUpdate = freezed,Object? confId = freezed,}) {
  return _then(_InfoItemsModel(
items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<InfoItemModel>?,lastUpdate: freezed == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as DateTime?,confId: freezed == confId ? _self.confId : confId // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
