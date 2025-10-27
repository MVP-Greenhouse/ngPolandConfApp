// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conferences_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConferencesModel {

@HiveField(0) List<ConferenceModel?>? get items;
/// Create a copy of ConferencesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConferencesModelCopyWith<ConferencesModel> get copyWith => _$ConferencesModelCopyWithImpl<ConferencesModel>(this as ConferencesModel, _$identity);

  /// Serializes this ConferencesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConferencesModel&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ConferencesModel(items: $items)';
}


}

/// @nodoc
abstract mixin class $ConferencesModelCopyWith<$Res>  {
  factory $ConferencesModelCopyWith(ConferencesModel value, $Res Function(ConferencesModel) _then) = _$ConferencesModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) List<ConferenceModel?>? items
});




}
/// @nodoc
class _$ConferencesModelCopyWithImpl<$Res>
    implements $ConferencesModelCopyWith<$Res> {
  _$ConferencesModelCopyWithImpl(this._self, this._then);

  final ConferencesModel _self;
  final $Res Function(ConferencesModel) _then;

/// Create a copy of ConferencesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = freezed,}) {
  return _then(_self.copyWith(
items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ConferenceModel?>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConferencesModel].
extension ConferencesModelPatterns on ConferencesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConferencesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConferencesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConferencesModel value)  $default,){
final _that = this;
switch (_that) {
case _ConferencesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConferencesModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConferencesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  List<ConferenceModel?>? items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConferencesModel() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  List<ConferenceModel?>? items)  $default,) {final _that = this;
switch (_that) {
case _ConferencesModel():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  List<ConferenceModel?>? items)?  $default,) {final _that = this;
switch (_that) {
case _ConferencesModel() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConferencesModel extends ConferencesModel {
  const _ConferencesModel({@HiveField(0) final  List<ConferenceModel?>? items}): _items = items,super._();
  factory _ConferencesModel.fromJson(Map<String, dynamic> json) => _$ConferencesModelFromJson(json);

 final  List<ConferenceModel?>? _items;
@override@HiveField(0) List<ConferenceModel?>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ConferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConferencesModelCopyWith<_ConferencesModel> get copyWith => __$ConferencesModelCopyWithImpl<_ConferencesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConferencesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConferencesModel&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ConferencesModel(items: $items)';
}


}

/// @nodoc
abstract mixin class _$ConferencesModelCopyWith<$Res> implements $ConferencesModelCopyWith<$Res> {
  factory _$ConferencesModelCopyWith(_ConferencesModel value, $Res Function(_ConferencesModel) _then) = __$ConferencesModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) List<ConferenceModel?>? items
});




}
/// @nodoc
class __$ConferencesModelCopyWithImpl<$Res>
    implements _$ConferencesModelCopyWith<$Res> {
  __$ConferencesModelCopyWithImpl(this._self, this._then);

  final _ConferencesModel _self;
  final $Res Function(_ConferencesModel) _then;

/// Create a copy of ConferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = freezed,}) {
  return _then(_ConferencesModel(
items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ConferenceModel?>?,
  ));
}


}

// dart format on
