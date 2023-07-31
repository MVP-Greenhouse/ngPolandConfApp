// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_items_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InfoItemsModel _$InfoItemsModelFromJson(Map<String, dynamic> json) {
  return _InfoItemsModel.fromJson(json);
}

/// @nodoc
mixin _$InfoItemsModel {
  List<InfoItemModel>? get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InfoItemsModelCopyWith<InfoItemsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoItemsModelCopyWith<$Res> {
  factory $InfoItemsModelCopyWith(
          InfoItemsModel value, $Res Function(InfoItemsModel) then) =
      _$InfoItemsModelCopyWithImpl<$Res, InfoItemsModel>;
  @useResult
  $Res call({List<InfoItemModel>? items});
}

/// @nodoc
class _$InfoItemsModelCopyWithImpl<$Res, $Val extends InfoItemsModel>
    implements $InfoItemsModelCopyWith<$Res> {
  _$InfoItemsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<InfoItemModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InfoItemsModelCopyWith<$Res>
    implements $InfoItemsModelCopyWith<$Res> {
  factory _$$_InfoItemsModelCopyWith(
          _$_InfoItemsModel value, $Res Function(_$_InfoItemsModel) then) =
      __$$_InfoItemsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<InfoItemModel>? items});
}

/// @nodoc
class __$$_InfoItemsModelCopyWithImpl<$Res>
    extends _$InfoItemsModelCopyWithImpl<$Res, _$_InfoItemsModel>
    implements _$$_InfoItemsModelCopyWith<$Res> {
  __$$_InfoItemsModelCopyWithImpl(
      _$_InfoItemsModel _value, $Res Function(_$_InfoItemsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_$_InfoItemsModel(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<InfoItemModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InfoItemsModel extends _InfoItemsModel {
  const _$_InfoItemsModel({required final List<InfoItemModel>? items})
      : _items = items,
        super._();

  factory _$_InfoItemsModel.fromJson(Map<String, dynamic> json) =>
      _$$_InfoItemsModelFromJson(json);

  final List<InfoItemModel>? _items;
  @override
  List<InfoItemModel>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'InfoItemsModel(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InfoItemsModel &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InfoItemsModelCopyWith<_$_InfoItemsModel> get copyWith =>
      __$$_InfoItemsModelCopyWithImpl<_$_InfoItemsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InfoItemsModelToJson(
      this,
    );
  }
}

abstract class _InfoItemsModel extends InfoItemsModel {
  const factory _InfoItemsModel({required final List<InfoItemModel>? items}) =
      _$_InfoItemsModel;
  const _InfoItemsModel._() : super._();

  factory _InfoItemsModel.fromJson(Map<String, dynamic> json) =
      _$_InfoItemsModel.fromJson;

  @override
  List<InfoItemModel>? get items;
  @override
  @JsonKey(ignore: true)
  _$$_InfoItemsModelCopyWith<_$_InfoItemsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
