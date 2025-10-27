// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speaker_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpeakerModel {

@HiveField(0) String get id;@HiveField(1) String get name;@HiveField(2) List<String> get confIds;@HiveField(3) String? get role;@HiveField(4) String? get bio;@HiveField(5) String? get photoFileUrl;@HiveField(6) String? get photoTitle;@HiveField(7) String? get photoDescription;@HiveField(8) String? get email;@HiveField(9) String? get urlGithub;@HiveField(10) String? get urlLinkedIn;@HiveField(11) String? get urlTwitter;@HiveField(12) String? get urlWww;
/// Create a copy of SpeakerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakerModelCopyWith<SpeakerModel> get copyWith => _$SpeakerModelCopyWithImpl<SpeakerModel>(this as SpeakerModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.confIds, confIds)&&(identical(other.role, role) || other.role == role)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.photoFileUrl, photoFileUrl) || other.photoFileUrl == photoFileUrl)&&(identical(other.photoTitle, photoTitle) || other.photoTitle == photoTitle)&&(identical(other.photoDescription, photoDescription) || other.photoDescription == photoDescription)&&(identical(other.email, email) || other.email == email)&&(identical(other.urlGithub, urlGithub) || other.urlGithub == urlGithub)&&(identical(other.urlLinkedIn, urlLinkedIn) || other.urlLinkedIn == urlLinkedIn)&&(identical(other.urlTwitter, urlTwitter) || other.urlTwitter == urlTwitter)&&(identical(other.urlWww, urlWww) || other.urlWww == urlWww));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(confIds),role,bio,photoFileUrl,photoTitle,photoDescription,email,urlGithub,urlLinkedIn,urlTwitter,urlWww);

@override
String toString() {
  return 'SpeakerModel(id: $id, name: $name, confIds: $confIds, role: $role, bio: $bio, photoFileUrl: $photoFileUrl, photoTitle: $photoTitle, photoDescription: $photoDescription, email: $email, urlGithub: $urlGithub, urlLinkedIn: $urlLinkedIn, urlTwitter: $urlTwitter, urlWww: $urlWww)';
}


}

/// @nodoc
abstract mixin class $SpeakerModelCopyWith<$Res>  {
  factory $SpeakerModelCopyWith(SpeakerModel value, $Res Function(SpeakerModel) _then) = _$SpeakerModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String name,@HiveField(2) List<String> confIds,@HiveField(3) String? role,@HiveField(4) String? bio,@HiveField(5) String? photoFileUrl,@HiveField(6) String? photoTitle,@HiveField(7) String? photoDescription,@HiveField(8) String? email,@HiveField(9) String? urlGithub,@HiveField(10) String? urlLinkedIn,@HiveField(11) String? urlTwitter,@HiveField(12) String? urlWww
});




}
/// @nodoc
class _$SpeakerModelCopyWithImpl<$Res>
    implements $SpeakerModelCopyWith<$Res> {
  _$SpeakerModelCopyWithImpl(this._self, this._then);

  final SpeakerModel _self;
  final $Res Function(SpeakerModel) _then;

/// Create a copy of SpeakerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? confIds = null,Object? role = freezed,Object? bio = freezed,Object? photoFileUrl = freezed,Object? photoTitle = freezed,Object? photoDescription = freezed,Object? email = freezed,Object? urlGithub = freezed,Object? urlLinkedIn = freezed,Object? urlTwitter = freezed,Object? urlWww = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,confIds: null == confIds ? _self.confIds : confIds // ignore: cast_nullable_to_non_nullable
as List<String>,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,photoFileUrl: freezed == photoFileUrl ? _self.photoFileUrl : photoFileUrl // ignore: cast_nullable_to_non_nullable
as String?,photoTitle: freezed == photoTitle ? _self.photoTitle : photoTitle // ignore: cast_nullable_to_non_nullable
as String?,photoDescription: freezed == photoDescription ? _self.photoDescription : photoDescription // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,urlGithub: freezed == urlGithub ? _self.urlGithub : urlGithub // ignore: cast_nullable_to_non_nullable
as String?,urlLinkedIn: freezed == urlLinkedIn ? _self.urlLinkedIn : urlLinkedIn // ignore: cast_nullable_to_non_nullable
as String?,urlTwitter: freezed == urlTwitter ? _self.urlTwitter : urlTwitter // ignore: cast_nullable_to_non_nullable
as String?,urlWww: freezed == urlWww ? _self.urlWww : urlWww // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeakerModel].
extension SpeakerModelPatterns on SpeakerModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakerModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakerModel value)  $default,){
final _that = this;
switch (_that) {
case _SpeakerModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakerModel value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakerModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String name, @HiveField(2)  List<String> confIds, @HiveField(3)  String? role, @HiveField(4)  String? bio, @HiveField(5)  String? photoFileUrl, @HiveField(6)  String? photoTitle, @HiveField(7)  String? photoDescription, @HiveField(8)  String? email, @HiveField(9)  String? urlGithub, @HiveField(10)  String? urlLinkedIn, @HiveField(11)  String? urlTwitter, @HiveField(12)  String? urlWww)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakerModel() when $default != null:
return $default(_that.id,_that.name,_that.confIds,_that.role,_that.bio,_that.photoFileUrl,_that.photoTitle,_that.photoDescription,_that.email,_that.urlGithub,_that.urlLinkedIn,_that.urlTwitter,_that.urlWww);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String name, @HiveField(2)  List<String> confIds, @HiveField(3)  String? role, @HiveField(4)  String? bio, @HiveField(5)  String? photoFileUrl, @HiveField(6)  String? photoTitle, @HiveField(7)  String? photoDescription, @HiveField(8)  String? email, @HiveField(9)  String? urlGithub, @HiveField(10)  String? urlLinkedIn, @HiveField(11)  String? urlTwitter, @HiveField(12)  String? urlWww)  $default,) {final _that = this;
switch (_that) {
case _SpeakerModel():
return $default(_that.id,_that.name,_that.confIds,_that.role,_that.bio,_that.photoFileUrl,_that.photoTitle,_that.photoDescription,_that.email,_that.urlGithub,_that.urlLinkedIn,_that.urlTwitter,_that.urlWww);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String name, @HiveField(2)  List<String> confIds, @HiveField(3)  String? role, @HiveField(4)  String? bio, @HiveField(5)  String? photoFileUrl, @HiveField(6)  String? photoTitle, @HiveField(7)  String? photoDescription, @HiveField(8)  String? email, @HiveField(9)  String? urlGithub, @HiveField(10)  String? urlLinkedIn, @HiveField(11)  String? urlTwitter, @HiveField(12)  String? urlWww)?  $default,) {final _that = this;
switch (_that) {
case _SpeakerModel() when $default != null:
return $default(_that.id,_that.name,_that.confIds,_that.role,_that.bio,_that.photoFileUrl,_that.photoTitle,_that.photoDescription,_that.email,_that.urlGithub,_that.urlLinkedIn,_that.urlTwitter,_that.urlWww);case _:
  return null;

}
}

}

/// @nodoc


class _SpeakerModel extends SpeakerModel {
  const _SpeakerModel({@HiveField(0) required this.id, @HiveField(1) required this.name, @HiveField(2) required final  List<String> confIds, @HiveField(3) this.role, @HiveField(4) this.bio, @HiveField(5) this.photoFileUrl, @HiveField(6) this.photoTitle, @HiveField(7) this.photoDescription, @HiveField(8) this.email, @HiveField(9) this.urlGithub, @HiveField(10) this.urlLinkedIn, @HiveField(11) this.urlTwitter, @HiveField(12) this.urlWww}): _confIds = confIds,super._();
  

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String name;
 final  List<String> _confIds;
@override@HiveField(2) List<String> get confIds {
  if (_confIds is EqualUnmodifiableListView) return _confIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_confIds);
}

@override@HiveField(3) final  String? role;
@override@HiveField(4) final  String? bio;
@override@HiveField(5) final  String? photoFileUrl;
@override@HiveField(6) final  String? photoTitle;
@override@HiveField(7) final  String? photoDescription;
@override@HiveField(8) final  String? email;
@override@HiveField(9) final  String? urlGithub;
@override@HiveField(10) final  String? urlLinkedIn;
@override@HiveField(11) final  String? urlTwitter;
@override@HiveField(12) final  String? urlWww;

/// Create a copy of SpeakerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakerModelCopyWith<_SpeakerModel> get copyWith => __$SpeakerModelCopyWithImpl<_SpeakerModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._confIds, _confIds)&&(identical(other.role, role) || other.role == role)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.photoFileUrl, photoFileUrl) || other.photoFileUrl == photoFileUrl)&&(identical(other.photoTitle, photoTitle) || other.photoTitle == photoTitle)&&(identical(other.photoDescription, photoDescription) || other.photoDescription == photoDescription)&&(identical(other.email, email) || other.email == email)&&(identical(other.urlGithub, urlGithub) || other.urlGithub == urlGithub)&&(identical(other.urlLinkedIn, urlLinkedIn) || other.urlLinkedIn == urlLinkedIn)&&(identical(other.urlTwitter, urlTwitter) || other.urlTwitter == urlTwitter)&&(identical(other.urlWww, urlWww) || other.urlWww == urlWww));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_confIds),role,bio,photoFileUrl,photoTitle,photoDescription,email,urlGithub,urlLinkedIn,urlTwitter,urlWww);

@override
String toString() {
  return 'SpeakerModel(id: $id, name: $name, confIds: $confIds, role: $role, bio: $bio, photoFileUrl: $photoFileUrl, photoTitle: $photoTitle, photoDescription: $photoDescription, email: $email, urlGithub: $urlGithub, urlLinkedIn: $urlLinkedIn, urlTwitter: $urlTwitter, urlWww: $urlWww)';
}


}

/// @nodoc
abstract mixin class _$SpeakerModelCopyWith<$Res> implements $SpeakerModelCopyWith<$Res> {
  factory _$SpeakerModelCopyWith(_SpeakerModel value, $Res Function(_SpeakerModel) _then) = __$SpeakerModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String name,@HiveField(2) List<String> confIds,@HiveField(3) String? role,@HiveField(4) String? bio,@HiveField(5) String? photoFileUrl,@HiveField(6) String? photoTitle,@HiveField(7) String? photoDescription,@HiveField(8) String? email,@HiveField(9) String? urlGithub,@HiveField(10) String? urlLinkedIn,@HiveField(11) String? urlTwitter,@HiveField(12) String? urlWww
});




}
/// @nodoc
class __$SpeakerModelCopyWithImpl<$Res>
    implements _$SpeakerModelCopyWith<$Res> {
  __$SpeakerModelCopyWithImpl(this._self, this._then);

  final _SpeakerModel _self;
  final $Res Function(_SpeakerModel) _then;

/// Create a copy of SpeakerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? confIds = null,Object? role = freezed,Object? bio = freezed,Object? photoFileUrl = freezed,Object? photoTitle = freezed,Object? photoDescription = freezed,Object? email = freezed,Object? urlGithub = freezed,Object? urlLinkedIn = freezed,Object? urlTwitter = freezed,Object? urlWww = freezed,}) {
  return _then(_SpeakerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,confIds: null == confIds ? _self._confIds : confIds // ignore: cast_nullable_to_non_nullable
as List<String>,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,photoFileUrl: freezed == photoFileUrl ? _self.photoFileUrl : photoFileUrl // ignore: cast_nullable_to_non_nullable
as String?,photoTitle: freezed == photoTitle ? _self.photoTitle : photoTitle // ignore: cast_nullable_to_non_nullable
as String?,photoDescription: freezed == photoDescription ? _self.photoDescription : photoDescription // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,urlGithub: freezed == urlGithub ? _self.urlGithub : urlGithub // ignore: cast_nullable_to_non_nullable
as String?,urlLinkedIn: freezed == urlLinkedIn ? _self.urlLinkedIn : urlLinkedIn // ignore: cast_nullable_to_non_nullable
as String?,urlTwitter: freezed == urlTwitter ? _self.urlTwitter : urlTwitter // ignore: cast_nullable_to_non_nullable
as String?,urlWww: freezed == urlWww ? _self.urlWww : urlWww // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
