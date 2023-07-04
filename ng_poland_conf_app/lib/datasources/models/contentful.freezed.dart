// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contentful.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InfoItem _$InfoItemFromJson(Map<String, dynamic> json) {
  return _InfoItem.fromJson(json);
}

/// @nodoc
mixin _$InfoItem {
  String get title => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get confId => throw _privateConstructorUsedError;
  String get urlLink => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InfoItemCopyWith<InfoItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoItemCopyWith<$Res> {
  factory $InfoItemCopyWith(InfoItem value, $Res Function(InfoItem) then) =
      _$InfoItemCopyWithImpl<$Res, InfoItem>;
  @useResult
  $Res call(
      {String title,
      int order,
      String icon,
      String description,
      String confId,
      String urlLink});
}

/// @nodoc
class _$InfoItemCopyWithImpl<$Res, $Val extends InfoItem>
    implements $InfoItemCopyWith<$Res> {
  _$InfoItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? order = null,
    Object? icon = null,
    Object? description = null,
    Object? confId = null,
    Object? urlLink = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      urlLink: null == urlLink
          ? _value.urlLink
          : urlLink // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InfoItemCopyWith<$Res> implements $InfoItemCopyWith<$Res> {
  factory _$$_InfoItemCopyWith(
          _$_InfoItem value, $Res Function(_$_InfoItem) then) =
      __$$_InfoItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      int order,
      String icon,
      String description,
      String confId,
      String urlLink});
}

/// @nodoc
class __$$_InfoItemCopyWithImpl<$Res>
    extends _$InfoItemCopyWithImpl<$Res, _$_InfoItem>
    implements _$$_InfoItemCopyWith<$Res> {
  __$$_InfoItemCopyWithImpl(
      _$_InfoItem _value, $Res Function(_$_InfoItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? order = null,
    Object? icon = null,
    Object? description = null,
    Object? confId = null,
    Object? urlLink = null,
  }) {
    return _then(_$_InfoItem(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      urlLink: null == urlLink
          ? _value.urlLink
          : urlLink // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InfoItem implements _InfoItem {
  const _$_InfoItem(
      {required this.title,
      required this.order,
      required this.icon,
      required this.description,
      required this.confId,
      required this.urlLink});

  factory _$_InfoItem.fromJson(Map<String, dynamic> json) =>
      _$$_InfoItemFromJson(json);

  @override
  final String title;
  @override
  final int order;
  @override
  final String icon;
  @override
  final String description;
  @override
  final String confId;
  @override
  final String urlLink;

  @override
  String toString() {
    return 'InfoItem(title: $title, order: $order, icon: $icon, description: $description, confId: $confId, urlLink: $urlLink)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InfoItem &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.urlLink, urlLink) || other.urlLink == urlLink));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, title, order, icon, description, confId, urlLink);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InfoItemCopyWith<_$_InfoItem> get copyWith =>
      __$$_InfoItemCopyWithImpl<_$_InfoItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InfoItemToJson(
      this,
    );
  }
}

abstract class _InfoItem implements InfoItem {
  const factory _InfoItem(
      {required final String title,
      required final int order,
      required final String icon,
      required final String description,
      required final String confId,
      required final String urlLink}) = _$_InfoItem;

  factory _InfoItem.fromJson(Map<String, dynamic> json) = _$_InfoItem.fromJson;

  @override
  String get title;
  @override
  int get order;
  @override
  String get icon;
  @override
  String get description;
  @override
  String get confId;
  @override
  String get urlLink;
  @override
  @JsonKey(ignore: true)
  _$$_InfoItemCopyWith<_$_InfoItem> get copyWith =>
      throw _privateConstructorUsedError;
}

EventItem _$EventItemFromJson(Map<String, dynamic> json) {
  return _EventItem.fromJson(json);
}

/// @nodoc
mixin _$EventItem {
  String get title => throw _privateConstructorUsedError;
  String get confId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get shortDescription => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  Speaker get speaker => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventItemCopyWith<EventItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventItemCopyWith<$Res> {
  factory $EventItemCopyWith(EventItem value, $Res Function(EventItem) then) =
      _$EventItemCopyWithImpl<$Res, EventItem>;
  @useResult
  $Res call(
      {String title,
      String confId,
      String type,
      String category,
      String shortDescription,
      String description,
      String startDate,
      String endDate,
      Speaker speaker});

  $SpeakerCopyWith<$Res> get speaker;
}

/// @nodoc
class _$EventItemCopyWithImpl<$Res, $Val extends EventItem>
    implements $EventItemCopyWith<$Res> {
  _$EventItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? confId = null,
    Object? type = null,
    Object? category = null,
    Object? shortDescription = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? speaker = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as Speaker,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SpeakerCopyWith<$Res> get speaker {
    return $SpeakerCopyWith<$Res>(_value.speaker, (value) {
      return _then(_value.copyWith(speaker: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventItemCopyWith<$Res> implements $EventItemCopyWith<$Res> {
  factory _$$_EventItemCopyWith(
          _$_EventItem value, $Res Function(_$_EventItem) then) =
      __$$_EventItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String confId,
      String type,
      String category,
      String shortDescription,
      String description,
      String startDate,
      String endDate,
      Speaker speaker});

  @override
  $SpeakerCopyWith<$Res> get speaker;
}

/// @nodoc
class __$$_EventItemCopyWithImpl<$Res>
    extends _$EventItemCopyWithImpl<$Res, _$_EventItem>
    implements _$$_EventItemCopyWith<$Res> {
  __$$_EventItemCopyWithImpl(
      _$_EventItem _value, $Res Function(_$_EventItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? confId = null,
    Object? type = null,
    Object? category = null,
    Object? shortDescription = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? speaker = null,
  }) {
    return _then(_$_EventItem(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as Speaker,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventItem implements _EventItem {
  const _$_EventItem(
      {required this.title,
      required this.confId,
      required this.type,
      required this.category,
      required this.shortDescription,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.speaker});

  factory _$_EventItem.fromJson(Map<String, dynamic> json) =>
      _$$_EventItemFromJson(json);

  @override
  final String title;
  @override
  final String confId;
  @override
  final String type;
  @override
  final String category;
  @override
  final String shortDescription;
  @override
  final String description;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final Speaker speaker;

  @override
  String toString() {
    return 'EventItem(title: $title, confId: $confId, type: $type, category: $category, shortDescription: $shortDescription, description: $description, startDate: $startDate, endDate: $endDate, speaker: $speaker)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventItem &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.speaker, speaker) || other.speaker == speaker));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, confId, type, category,
      shortDescription, description, startDate, endDate, speaker);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventItemCopyWith<_$_EventItem> get copyWith =>
      __$$_EventItemCopyWithImpl<_$_EventItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventItemToJson(
      this,
    );
  }
}

abstract class _EventItem implements EventItem {
  const factory _EventItem(
      {required final String title,
      required final String confId,
      required final String type,
      required final String category,
      required final String shortDescription,
      required final String description,
      required final String startDate,
      required final String endDate,
      required final Speaker speaker}) = _$_EventItem;

  factory _EventItem.fromJson(Map<String, dynamic> json) =
      _$_EventItem.fromJson;

  @override
  String get title;
  @override
  String get confId;
  @override
  String get type;
  @override
  String get category;
  @override
  String get shortDescription;
  @override
  String get description;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  Speaker get speaker;
  @override
  @JsonKey(ignore: true)
  _$$_EventItemCopyWith<_$_EventItem> get copyWith =>
      throw _privateConstructorUsedError;
}

Speaker _$SpeakerFromJson(Map<String, dynamic> json) {
  return _Speaker.fromJson(json);
}

/// @nodoc
mixin _$Speaker {
  String get name => throw _privateConstructorUsedError;
  String get confIds => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  String get photoFileUrl => throw _privateConstructorUsedError;
  String get photoTitle => throw _privateConstructorUsedError;
  String get photoDescription => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get urlGithub => throw _privateConstructorUsedError;
  String get urlLinkedIn => throw _privateConstructorUsedError;
  String get urlTwitter => throw _privateConstructorUsedError;
  String get urlWww => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SpeakerCopyWith<Speaker> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeakerCopyWith<$Res> {
  factory $SpeakerCopyWith(Speaker value, $Res Function(Speaker) then) =
      _$SpeakerCopyWithImpl<$Res, Speaker>;
  @useResult
  $Res call(
      {String name,
      String confIds,
      String role,
      String bio,
      String photoFileUrl,
      String photoTitle,
      String photoDescription,
      String email,
      String urlGithub,
      String urlLinkedIn,
      String urlTwitter,
      String urlWww});
}

/// @nodoc
class _$SpeakerCopyWithImpl<$Res, $Val extends Speaker>
    implements $SpeakerCopyWith<$Res> {
  _$SpeakerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? confIds = null,
    Object? role = null,
    Object? bio = null,
    Object? photoFileUrl = null,
    Object? photoTitle = null,
    Object? photoDescription = null,
    Object? email = null,
    Object? urlGithub = null,
    Object? urlLinkedIn = null,
    Object? urlTwitter = null,
    Object? urlWww = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      confIds: null == confIds
          ? _value.confIds
          : confIds // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      photoFileUrl: null == photoFileUrl
          ? _value.photoFileUrl
          : photoFileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      photoTitle: null == photoTitle
          ? _value.photoTitle
          : photoTitle // ignore: cast_nullable_to_non_nullable
              as String,
      photoDescription: null == photoDescription
          ? _value.photoDescription
          : photoDescription // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      urlGithub: null == urlGithub
          ? _value.urlGithub
          : urlGithub // ignore: cast_nullable_to_non_nullable
              as String,
      urlLinkedIn: null == urlLinkedIn
          ? _value.urlLinkedIn
          : urlLinkedIn // ignore: cast_nullable_to_non_nullable
              as String,
      urlTwitter: null == urlTwitter
          ? _value.urlTwitter
          : urlTwitter // ignore: cast_nullable_to_non_nullable
              as String,
      urlWww: null == urlWww
          ? _value.urlWww
          : urlWww // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpeakerCopyWith<$Res> implements $SpeakerCopyWith<$Res> {
  factory _$$_SpeakerCopyWith(
          _$_Speaker value, $Res Function(_$_Speaker) then) =
      __$$_SpeakerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String confIds,
      String role,
      String bio,
      String photoFileUrl,
      String photoTitle,
      String photoDescription,
      String email,
      String urlGithub,
      String urlLinkedIn,
      String urlTwitter,
      String urlWww});
}

/// @nodoc
class __$$_SpeakerCopyWithImpl<$Res>
    extends _$SpeakerCopyWithImpl<$Res, _$_Speaker>
    implements _$$_SpeakerCopyWith<$Res> {
  __$$_SpeakerCopyWithImpl(_$_Speaker _value, $Res Function(_$_Speaker) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? confIds = null,
    Object? role = null,
    Object? bio = null,
    Object? photoFileUrl = null,
    Object? photoTitle = null,
    Object? photoDescription = null,
    Object? email = null,
    Object? urlGithub = null,
    Object? urlLinkedIn = null,
    Object? urlTwitter = null,
    Object? urlWww = null,
  }) {
    return _then(_$_Speaker(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      confIds: null == confIds
          ? _value.confIds
          : confIds // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      photoFileUrl: null == photoFileUrl
          ? _value.photoFileUrl
          : photoFileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      photoTitle: null == photoTitle
          ? _value.photoTitle
          : photoTitle // ignore: cast_nullable_to_non_nullable
              as String,
      photoDescription: null == photoDescription
          ? _value.photoDescription
          : photoDescription // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      urlGithub: null == urlGithub
          ? _value.urlGithub
          : urlGithub // ignore: cast_nullable_to_non_nullable
              as String,
      urlLinkedIn: null == urlLinkedIn
          ? _value.urlLinkedIn
          : urlLinkedIn // ignore: cast_nullable_to_non_nullable
              as String,
      urlTwitter: null == urlTwitter
          ? _value.urlTwitter
          : urlTwitter // ignore: cast_nullable_to_non_nullable
              as String,
      urlWww: null == urlWww
          ? _value.urlWww
          : urlWww // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Speaker implements _Speaker {
  const _$_Speaker(
      {required this.name,
      required this.confIds,
      required this.role,
      required this.bio,
      required this.photoFileUrl,
      required this.photoTitle,
      required this.photoDescription,
      required this.email,
      required this.urlGithub,
      required this.urlLinkedIn,
      required this.urlTwitter,
      required this.urlWww});

  factory _$_Speaker.fromJson(Map<String, dynamic> json) =>
      _$$_SpeakerFromJson(json);

  @override
  final String name;
  @override
  final String confIds;
  @override
  final String role;
  @override
  final String bio;
  @override
  final String photoFileUrl;
  @override
  final String photoTitle;
  @override
  final String photoDescription;
  @override
  final String email;
  @override
  final String urlGithub;
  @override
  final String urlLinkedIn;
  @override
  final String urlTwitter;
  @override
  final String urlWww;

  @override
  String toString() {
    return 'Speaker(name: $name, confIds: $confIds, role: $role, bio: $bio, photoFileUrl: $photoFileUrl, photoTitle: $photoTitle, photoDescription: $photoDescription, email: $email, urlGithub: $urlGithub, urlLinkedIn: $urlLinkedIn, urlTwitter: $urlTwitter, urlWww: $urlWww)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Speaker &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.confIds, confIds) || other.confIds == confIds) &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      confIds,
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpeakerCopyWith<_$_Speaker> get copyWith =>
      __$$_SpeakerCopyWithImpl<_$_Speaker>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SpeakerToJson(
      this,
    );
  }
}

abstract class _Speaker implements Speaker {
  const factory _Speaker(
      {required final String name,
      required final String confIds,
      required final String role,
      required final String bio,
      required final String photoFileUrl,
      required final String photoTitle,
      required final String photoDescription,
      required final String email,
      required final String urlGithub,
      required final String urlLinkedIn,
      required final String urlTwitter,
      required final String urlWww}) = _$_Speaker;

  factory _Speaker.fromJson(Map<String, dynamic> json) = _$_Speaker.fromJson;

  @override
  String get name;
  @override
  String get confIds;
  @override
  String get role;
  @override
  String get bio;
  @override
  String get photoFileUrl;
  @override
  String get photoTitle;
  @override
  String get photoDescription;
  @override
  String get email;
  @override
  String get urlGithub;
  @override
  String get urlLinkedIn;
  @override
  String get urlTwitter;
  @override
  String get urlWww;
  @override
  @JsonKey(ignore: true)
  _$$_SpeakerCopyWith<_$_Speaker> get copyWith =>
      throw _privateConstructorUsedError;
}

SimpleContent _$SimpleContentFromJson(Map<String, dynamic> json) {
  return _SimpleContent.fromJson(json);
}

/// @nodoc
mixin _$SimpleContent {
  String get myId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get confId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimpleContentCopyWith<SimpleContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleContentCopyWith<$Res> {
  factory $SimpleContentCopyWith(
          SimpleContent value, $Res Function(SimpleContent) then) =
      _$SimpleContentCopyWithImpl<$Res, SimpleContent>;
  @useResult
  $Res call({String myId, String title, String text, String confId});
}

/// @nodoc
class _$SimpleContentCopyWithImpl<$Res, $Val extends SimpleContent>
    implements $SimpleContentCopyWith<$Res> {
  _$SimpleContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myId = null,
    Object? title = null,
    Object? text = null,
    Object? confId = null,
  }) {
    return _then(_value.copyWith(
      myId: null == myId
          ? _value.myId
          : myId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SimpleContentCopyWith<$Res>
    implements $SimpleContentCopyWith<$Res> {
  factory _$$_SimpleContentCopyWith(
          _$_SimpleContent value, $Res Function(_$_SimpleContent) then) =
      __$$_SimpleContentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String myId, String title, String text, String confId});
}

/// @nodoc
class __$$_SimpleContentCopyWithImpl<$Res>
    extends _$SimpleContentCopyWithImpl<$Res, _$_SimpleContent>
    implements _$$_SimpleContentCopyWith<$Res> {
  __$$_SimpleContentCopyWithImpl(
      _$_SimpleContent _value, $Res Function(_$_SimpleContent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myId = null,
    Object? title = null,
    Object? text = null,
    Object? confId = null,
  }) {
    return _then(_$_SimpleContent(
      myId: null == myId
          ? _value.myId
          : myId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SimpleContent implements _SimpleContent {
  const _$_SimpleContent(
      {required this.myId,
      required this.title,
      required this.text,
      required this.confId});

  factory _$_SimpleContent.fromJson(Map<String, dynamic> json) =>
      _$$_SimpleContentFromJson(json);

  @override
  final String myId;
  @override
  final String title;
  @override
  final String text;
  @override
  final String confId;

  @override
  String toString() {
    return 'SimpleContent(myId: $myId, title: $title, text: $text, confId: $confId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SimpleContent &&
            (identical(other.myId, myId) || other.myId == myId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.confId, confId) || other.confId == confId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, myId, title, text, confId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SimpleContentCopyWith<_$_SimpleContent> get copyWith =>
      __$$_SimpleContentCopyWithImpl<_$_SimpleContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SimpleContentToJson(
      this,
    );
  }
}

abstract class _SimpleContent implements SimpleContent {
  const factory _SimpleContent(
      {required final String myId,
      required final String title,
      required final String text,
      required final String confId}) = _$_SimpleContent;

  factory _SimpleContent.fromJson(Map<String, dynamic> json) =
      _$_SimpleContent.fromJson;

  @override
  String get myId;
  @override
  String get title;
  @override
  String get text;
  @override
  String get confId;
  @override
  @JsonKey(ignore: true)
  _$$_SimpleContentCopyWith<_$_SimpleContent> get copyWith =>
      throw _privateConstructorUsedError;
}

Workshop _$WorkshopFromJson(Map<String, dynamic> json) {
  return _Workshop.fromJson(json);
}

/// @nodoc
mixin _$Workshop {
  String get title => throw _privateConstructorUsedError;
  String get confId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Speaker get speaker => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  String get locationDescription => throw _privateConstructorUsedError;
  String get pricePln => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkshopCopyWith<Workshop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkshopCopyWith<$Res> {
  factory $WorkshopCopyWith(Workshop value, $Res Function(Workshop) then) =
      _$WorkshopCopyWithImpl<$Res, Workshop>;
  @useResult
  $Res call(
      {String title,
      String confId,
      String description,
      Speaker speaker,
      String startDate,
      String endDate,
      String locationDescription,
      String pricePln});

  $SpeakerCopyWith<$Res> get speaker;
}

/// @nodoc
class _$WorkshopCopyWithImpl<$Res, $Val extends Workshop>
    implements $WorkshopCopyWith<$Res> {
  _$WorkshopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? confId = null,
    Object? description = null,
    Object? speaker = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? locationDescription = null,
    Object? pricePln = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as Speaker,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      locationDescription: null == locationDescription
          ? _value.locationDescription
          : locationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      pricePln: null == pricePln
          ? _value.pricePln
          : pricePln // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SpeakerCopyWith<$Res> get speaker {
    return $SpeakerCopyWith<$Res>(_value.speaker, (value) {
      return _then(_value.copyWith(speaker: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WorkshopCopyWith<$Res> implements $WorkshopCopyWith<$Res> {
  factory _$$_WorkshopCopyWith(
          _$_Workshop value, $Res Function(_$_Workshop) then) =
      __$$_WorkshopCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String confId,
      String description,
      Speaker speaker,
      String startDate,
      String endDate,
      String locationDescription,
      String pricePln});

  @override
  $SpeakerCopyWith<$Res> get speaker;
}

/// @nodoc
class __$$_WorkshopCopyWithImpl<$Res>
    extends _$WorkshopCopyWithImpl<$Res, _$_Workshop>
    implements _$$_WorkshopCopyWith<$Res> {
  __$$_WorkshopCopyWithImpl(
      _$_Workshop _value, $Res Function(_$_Workshop) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? confId = null,
    Object? description = null,
    Object? speaker = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? locationDescription = null,
    Object? pricePln = null,
  }) {
    return _then(_$_Workshop(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      confId: null == confId
          ? _value.confId
          : confId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as Speaker,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      locationDescription: null == locationDescription
          ? _value.locationDescription
          : locationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      pricePln: null == pricePln
          ? _value.pricePln
          : pricePln // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Workshop implements _Workshop {
  const _$_Workshop(
      {required this.title,
      required this.confId,
      required this.description,
      required this.speaker,
      required this.startDate,
      required this.endDate,
      required this.locationDescription,
      required this.pricePln});

  factory _$_Workshop.fromJson(Map<String, dynamic> json) =>
      _$$_WorkshopFromJson(json);

  @override
  final String title;
  @override
  final String confId;
  @override
  final String description;
  @override
  final Speaker speaker;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final String locationDescription;
  @override
  final String pricePln;

  @override
  String toString() {
    return 'Workshop(title: $title, confId: $confId, description: $description, speaker: $speaker, startDate: $startDate, endDate: $endDate, locationDescription: $locationDescription, pricePln: $pricePln)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Workshop &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.confId, confId) || other.confId == confId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.speaker, speaker) || other.speaker == speaker) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.locationDescription, locationDescription) ||
                other.locationDescription == locationDescription) &&
            (identical(other.pricePln, pricePln) ||
                other.pricePln == pricePln));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, confId, description,
      speaker, startDate, endDate, locationDescription, pricePln);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WorkshopCopyWith<_$_Workshop> get copyWith =>
      __$$_WorkshopCopyWithImpl<_$_Workshop>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WorkshopToJson(
      this,
    );
  }
}

abstract class _Workshop implements Workshop {
  const factory _Workshop(
      {required final String title,
      required final String confId,
      required final String description,
      required final Speaker speaker,
      required final String startDate,
      required final String endDate,
      required final String locationDescription,
      required final String pricePln}) = _$_Workshop;

  factory _Workshop.fromJson(Map<String, dynamic> json) = _$_Workshop.fromJson;

  @override
  String get title;
  @override
  String get confId;
  @override
  String get description;
  @override
  Speaker get speaker;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  String get locationDescription;
  @override
  String get pricePln;
  @override
  @JsonKey(ignore: true)
  _$$_WorkshopCopyWith<_$_Workshop> get copyWith =>
      throw _privateConstructorUsedError;
}
