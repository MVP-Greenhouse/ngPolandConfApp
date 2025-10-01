// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speaker_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SpeakerModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  List<String> get confIds => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get role => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get bio => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get photoFileUrl => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get photoTitle => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get photoDescription => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get email => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get urlGithub => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get urlLinkedIn => throw _privateConstructorUsedError;
  @HiveField(11)
  String? get urlTwitter => throw _privateConstructorUsedError;
  @HiveField(12)
  String? get urlWww => throw _privateConstructorUsedError;

  /// Create a copy of SpeakerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpeakerModelCopyWith<SpeakerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeakerModelCopyWith<$Res> {
  factory $SpeakerModelCopyWith(
          SpeakerModel value, $Res Function(SpeakerModel) then) =
      _$SpeakerModelCopyWithImpl<$Res, SpeakerModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) List<String> confIds,
      @HiveField(3) String? role,
      @HiveField(4) String? bio,
      @HiveField(5) String? photoFileUrl,
      @HiveField(6) String? photoTitle,
      @HiveField(7) String? photoDescription,
      @HiveField(8) String? email,
      @HiveField(9) String? urlGithub,
      @HiveField(10) String? urlLinkedIn,
      @HiveField(11) String? urlTwitter,
      @HiveField(12) String? urlWww});
}

/// @nodoc
class _$SpeakerModelCopyWithImpl<$Res, $Val extends SpeakerModel>
    implements $SpeakerModelCopyWith<$Res> {
  _$SpeakerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpeakerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? confIds = null,
    Object? role = freezed,
    Object? bio = freezed,
    Object? photoFileUrl = freezed,
    Object? photoTitle = freezed,
    Object? photoDescription = freezed,
    Object? email = freezed,
    Object? urlGithub = freezed,
    Object? urlLinkedIn = freezed,
    Object? urlTwitter = freezed,
    Object? urlWww = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      confIds: null == confIds
          ? _value.confIds
          : confIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      photoFileUrl: freezed == photoFileUrl
          ? _value.photoFileUrl
          : photoFileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      photoTitle: freezed == photoTitle
          ? _value.photoTitle
          : photoTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      photoDescription: freezed == photoDescription
          ? _value.photoDescription
          : photoDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      urlGithub: freezed == urlGithub
          ? _value.urlGithub
          : urlGithub // ignore: cast_nullable_to_non_nullable
              as String?,
      urlLinkedIn: freezed == urlLinkedIn
          ? _value.urlLinkedIn
          : urlLinkedIn // ignore: cast_nullable_to_non_nullable
              as String?,
      urlTwitter: freezed == urlTwitter
          ? _value.urlTwitter
          : urlTwitter // ignore: cast_nullable_to_non_nullable
              as String?,
      urlWww: freezed == urlWww
          ? _value.urlWww
          : urlWww // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpeakerModelImplCopyWith<$Res>
    implements $SpeakerModelCopyWith<$Res> {
  factory _$$SpeakerModelImplCopyWith(
          _$SpeakerModelImpl value, $Res Function(_$SpeakerModelImpl) then) =
      __$$SpeakerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) List<String> confIds,
      @HiveField(3) String? role,
      @HiveField(4) String? bio,
      @HiveField(5) String? photoFileUrl,
      @HiveField(6) String? photoTitle,
      @HiveField(7) String? photoDescription,
      @HiveField(8) String? email,
      @HiveField(9) String? urlGithub,
      @HiveField(10) String? urlLinkedIn,
      @HiveField(11) String? urlTwitter,
      @HiveField(12) String? urlWww});
}

/// @nodoc
class __$$SpeakerModelImplCopyWithImpl<$Res>
    extends _$SpeakerModelCopyWithImpl<$Res, _$SpeakerModelImpl>
    implements _$$SpeakerModelImplCopyWith<$Res> {
  __$$SpeakerModelImplCopyWithImpl(
      _$SpeakerModelImpl _value, $Res Function(_$SpeakerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpeakerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? confIds = null,
    Object? role = freezed,
    Object? bio = freezed,
    Object? photoFileUrl = freezed,
    Object? photoTitle = freezed,
    Object? photoDescription = freezed,
    Object? email = freezed,
    Object? urlGithub = freezed,
    Object? urlLinkedIn = freezed,
    Object? urlTwitter = freezed,
    Object? urlWww = freezed,
  }) {
    return _then(_$SpeakerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      confIds: null == confIds
          ? _value._confIds
          : confIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      photoFileUrl: freezed == photoFileUrl
          ? _value.photoFileUrl
          : photoFileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      photoTitle: freezed == photoTitle
          ? _value.photoTitle
          : photoTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      photoDescription: freezed == photoDescription
          ? _value.photoDescription
          : photoDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      urlGithub: freezed == urlGithub
          ? _value.urlGithub
          : urlGithub // ignore: cast_nullable_to_non_nullable
              as String?,
      urlLinkedIn: freezed == urlLinkedIn
          ? _value.urlLinkedIn
          : urlLinkedIn // ignore: cast_nullable_to_non_nullable
              as String?,
      urlTwitter: freezed == urlTwitter
          ? _value.urlTwitter
          : urlTwitter // ignore: cast_nullable_to_non_nullable
              as String?,
      urlWww: freezed == urlWww
          ? _value.urlWww
          : urlWww // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SpeakerModelImpl extends _SpeakerModel {
  const _$SpeakerModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required final List<String> confIds,
      @HiveField(3) this.role,
      @HiveField(4) this.bio,
      @HiveField(5) this.photoFileUrl,
      @HiveField(6) this.photoTitle,
      @HiveField(7) this.photoDescription,
      @HiveField(8) this.email,
      @HiveField(9) this.urlGithub,
      @HiveField(10) this.urlLinkedIn,
      @HiveField(11) this.urlTwitter,
      @HiveField(12) this.urlWww})
      : _confIds = confIds,
        super._();

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  final List<String> _confIds;
  @override
  @HiveField(2)
  List<String> get confIds {
    if (_confIds is EqualUnmodifiableListView) return _confIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_confIds);
  }

  @override
  @HiveField(3)
  final String? role;
  @override
  @HiveField(4)
  final String? bio;
  @override
  @HiveField(5)
  final String? photoFileUrl;
  @override
  @HiveField(6)
  final String? photoTitle;
  @override
  @HiveField(7)
  final String? photoDescription;
  @override
  @HiveField(8)
  final String? email;
  @override
  @HiveField(9)
  final String? urlGithub;
  @override
  @HiveField(10)
  final String? urlLinkedIn;
  @override
  @HiveField(11)
  final String? urlTwitter;
  @override
  @HiveField(12)
  final String? urlWww;

  @override
  String toString() {
    return 'SpeakerModel(id: $id, name: $name, confIds: $confIds, role: $role, bio: $bio, photoFileUrl: $photoFileUrl, photoTitle: $photoTitle, photoDescription: $photoDescription, email: $email, urlGithub: $urlGithub, urlLinkedIn: $urlLinkedIn, urlTwitter: $urlTwitter, urlWww: $urlWww)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpeakerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._confIds, _confIds) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.photoFileUrl, photoFileUrl) ||
                other.photoFileUrl == photoFileUrl) &&
            (identical(other.photoTitle, photoTitle) ||
                other.photoTitle == photoTitle) &&
            (identical(other.photoDescription, photoDescription) ||
                other.photoDescription == photoDescription) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.urlGithub, urlGithub) ||
                other.urlGithub == urlGithub) &&
            (identical(other.urlLinkedIn, urlLinkedIn) ||
                other.urlLinkedIn == urlLinkedIn) &&
            (identical(other.urlTwitter, urlTwitter) ||
                other.urlTwitter == urlTwitter) &&
            (identical(other.urlWww, urlWww) || other.urlWww == urlWww));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_confIds),
      role,
      bio,
      photoFileUrl,
      photoTitle,
      photoDescription,
      email,
      urlGithub,
      urlLinkedIn,
      urlTwitter,
      urlWww);

  /// Create a copy of SpeakerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpeakerModelImplCopyWith<_$SpeakerModelImpl> get copyWith =>
      __$$SpeakerModelImplCopyWithImpl<_$SpeakerModelImpl>(this, _$identity);
}

abstract class _SpeakerModel extends SpeakerModel {
  const factory _SpeakerModel(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final List<String> confIds,
      @HiveField(3) final String? role,
      @HiveField(4) final String? bio,
      @HiveField(5) final String? photoFileUrl,
      @HiveField(6) final String? photoTitle,
      @HiveField(7) final String? photoDescription,
      @HiveField(8) final String? email,
      @HiveField(9) final String? urlGithub,
      @HiveField(10) final String? urlLinkedIn,
      @HiveField(11) final String? urlTwitter,
      @HiveField(12) final String? urlWww}) = _$SpeakerModelImpl;
  const _SpeakerModel._() : super._();

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  List<String> get confIds;
  @override
  @HiveField(3)
  String? get role;
  @override
  @HiveField(4)
  String? get bio;
  @override
  @HiveField(5)
  String? get photoFileUrl;
  @override
  @HiveField(6)
  String? get photoTitle;
  @override
  @HiveField(7)
  String? get photoDescription;
  @override
  @HiveField(8)
  String? get email;
  @override
  @HiveField(9)
  String? get urlGithub;
  @override
  @HiveField(10)
  String? get urlLinkedIn;
  @override
  @HiveField(11)
  String? get urlTwitter;
  @override
  @HiveField(12)
  String? get urlWww;

  /// Create a copy of SpeakerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpeakerModelImplCopyWith<_$SpeakerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
