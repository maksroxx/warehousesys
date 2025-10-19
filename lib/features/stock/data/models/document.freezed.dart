// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DocumentListItem _$DocumentListItemFromJson(Map<String, dynamic> json) {
  return _DocumentListItem.fromJson(json);
}

/// @nodoc
mixin _$DocumentListItem {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_name')
  String? get warehouseName => throw _privateConstructorUsedError;
  @JsonKey(name: 'counterparty_name')
  String? get counterpartyName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_count', defaultValue: 0)
  int get totalItems => throw _privateConstructorUsedError;

  /// Serializes this DocumentListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentListItemCopyWith<DocumentListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentListItemCopyWith<$Res> {
  factory $DocumentListItemCopyWith(
    DocumentListItem value,
    $Res Function(DocumentListItem) then,
  ) = _$DocumentListItemCopyWithImpl<$Res, DocumentListItem>;
  @useResult
  $Res call({
    int id,
    String type,
    String number,
    @JsonKey(name: 'warehouse_name') String? warehouseName,
    @JsonKey(name: 'counterparty_name') String? counterpartyName,
    String status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'item_count', defaultValue: 0) int totalItems,
  });
}

/// @nodoc
class _$DocumentListItemCopyWithImpl<$Res, $Val extends DocumentListItem>
    implements $DocumentListItemCopyWith<$Res> {
  _$DocumentListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? number = null,
    Object? warehouseName = freezed,
    Object? counterpartyName = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? totalItems = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as String,
            warehouseName: freezed == warehouseName
                ? _value.warehouseName
                : warehouseName // ignore: cast_nullable_to_non_nullable
                      as String?,
            counterpartyName: freezed == counterpartyName
                ? _value.counterpartyName
                : counterpartyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalItems: null == totalItems
                ? _value.totalItems
                : totalItems // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentListItemImplCopyWith<$Res>
    implements $DocumentListItemCopyWith<$Res> {
  factory _$$DocumentListItemImplCopyWith(
    _$DocumentListItemImpl value,
    $Res Function(_$DocumentListItemImpl) then,
  ) = __$$DocumentListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String type,
    String number,
    @JsonKey(name: 'warehouse_name') String? warehouseName,
    @JsonKey(name: 'counterparty_name') String? counterpartyName,
    String status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'item_count', defaultValue: 0) int totalItems,
  });
}

/// @nodoc
class __$$DocumentListItemImplCopyWithImpl<$Res>
    extends _$DocumentListItemCopyWithImpl<$Res, _$DocumentListItemImpl>
    implements _$$DocumentListItemImplCopyWith<$Res> {
  __$$DocumentListItemImplCopyWithImpl(
    _$DocumentListItemImpl _value,
    $Res Function(_$DocumentListItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocumentListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? number = null,
    Object? warehouseName = freezed,
    Object? counterpartyName = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? totalItems = null,
  }) {
    return _then(
      _$DocumentListItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as String,
        warehouseName: freezed == warehouseName
            ? _value.warehouseName
            : warehouseName // ignore: cast_nullable_to_non_nullable
                  as String?,
        counterpartyName: freezed == counterpartyName
            ? _value.counterpartyName
            : counterpartyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalItems: null == totalItems
            ? _value.totalItems
            : totalItems // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentListItemImpl implements _DocumentListItem {
  const _$DocumentListItemImpl({
    required this.id,
    required this.type,
    required this.number,
    @JsonKey(name: 'warehouse_name') this.warehouseName,
    @JsonKey(name: 'counterparty_name') this.counterpartyName,
    required this.status,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'item_count', defaultValue: 0) required this.totalItems,
  });

  factory _$DocumentListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentListItemImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final String number;
  @override
  @JsonKey(name: 'warehouse_name')
  final String? warehouseName;
  @override
  @JsonKey(name: 'counterparty_name')
  final String? counterpartyName;
  @override
  final String status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'item_count', defaultValue: 0)
  final int totalItems;

  @override
  String toString() {
    return 'DocumentListItem(id: $id, type: $type, number: $number, warehouseName: $warehouseName, counterpartyName: $counterpartyName, status: $status, createdAt: $createdAt, totalItems: $totalItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.warehouseName, warehouseName) ||
                other.warehouseName == warehouseName) &&
            (identical(other.counterpartyName, counterpartyName) ||
                other.counterpartyName == counterpartyName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    number,
    warehouseName,
    counterpartyName,
    status,
    createdAt,
    totalItems,
  );

  /// Create a copy of DocumentListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentListItemImplCopyWith<_$DocumentListItemImpl> get copyWith =>
      __$$DocumentListItemImplCopyWithImpl<_$DocumentListItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentListItemImplToJson(this);
  }
}

abstract class _DocumentListItem implements DocumentListItem {
  const factory _DocumentListItem({
    required final int id,
    required final String type,
    required final String number,
    @JsonKey(name: 'warehouse_name') final String? warehouseName,
    @JsonKey(name: 'counterparty_name') final String? counterpartyName,
    required final String status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'item_count', defaultValue: 0) required final int totalItems,
  }) = _$DocumentListItemImpl;

  factory _DocumentListItem.fromJson(Map<String, dynamic> json) =
      _$DocumentListItemImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  String get number;
  @override
  @JsonKey(name: 'warehouse_name')
  String? get warehouseName;
  @override
  @JsonKey(name: 'counterparty_name')
  String? get counterpartyName;
  @override
  String get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'item_count', defaultValue: 0)
  int get totalItems;

  /// Create a copy of DocumentListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentListItemImplCopyWith<_$DocumentListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DocumentFilter {
  List<String> get types => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // draft, posted, canceled
  String? get search => throw _privateConstructorUsedError;
  DateTime? get dateFrom => throw _privateConstructorUsedError;
  DateTime? get dateTo => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;

  /// Create a copy of DocumentFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentFilterCopyWith<DocumentFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentFilterCopyWith<$Res> {
  factory $DocumentFilterCopyWith(
    DocumentFilter value,
    $Res Function(DocumentFilter) then,
  ) = _$DocumentFilterCopyWithImpl<$Res, DocumentFilter>;
  @useResult
  $Res call({
    List<String> types,
    String? status,
    String? search,
    DateTime? dateFrom,
    DateTime? dateTo,
    int limit,
    int offset,
  });
}

/// @nodoc
class _$DocumentFilterCopyWithImpl<$Res, $Val extends DocumentFilter>
    implements $DocumentFilterCopyWith<$Res> {
  _$DocumentFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? types = null,
    Object? status = freezed,
    Object? search = freezed,
    Object? dateFrom = freezed,
    Object? dateTo = freezed,
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(
      _value.copyWith(
            types: null == types
                ? _value.types
                : types // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            search: freezed == search
                ? _value.search
                : search // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateFrom: freezed == dateFrom
                ? _value.dateFrom
                : dateFrom // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            dateTo: freezed == dateTo
                ? _value.dateTo
                : dateTo // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentFilterImplCopyWith<$Res>
    implements $DocumentFilterCopyWith<$Res> {
  factory _$$DocumentFilterImplCopyWith(
    _$DocumentFilterImpl value,
    $Res Function(_$DocumentFilterImpl) then,
  ) = __$$DocumentFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String> types,
    String? status,
    String? search,
    DateTime? dateFrom,
    DateTime? dateTo,
    int limit,
    int offset,
  });
}

/// @nodoc
class __$$DocumentFilterImplCopyWithImpl<$Res>
    extends _$DocumentFilterCopyWithImpl<$Res, _$DocumentFilterImpl>
    implements _$$DocumentFilterImplCopyWith<$Res> {
  __$$DocumentFilterImplCopyWithImpl(
    _$DocumentFilterImpl _value,
    $Res Function(_$DocumentFilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocumentFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? types = null,
    Object? status = freezed,
    Object? search = freezed,
    Object? dateFrom = freezed,
    Object? dateTo = freezed,
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(
      _$DocumentFilterImpl(
        types: null == types
            ? _value._types
            : types // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        search: freezed == search
            ? _value.search
            : search // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateFrom: freezed == dateFrom
            ? _value.dateFrom
            : dateFrom // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        dateTo: freezed == dateTo
            ? _value.dateTo
            : dateTo // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$DocumentFilterImpl implements _DocumentFilter {
  const _$DocumentFilterImpl({
    final List<String> types = const ['INCOME', 'OUTCOME'],
    this.status,
    this.search,
    this.dateFrom,
    this.dateTo,
    this.limit = 20,
    this.offset = 0,
  }) : _types = types;

  final List<String> _types;
  @override
  @JsonKey()
  List<String> get types {
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_types);
  }

  @override
  final String? status;
  // draft, posted, canceled
  @override
  final String? search;
  @override
  final DateTime? dateFrom;
  @override
  final DateTime? dateTo;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int offset;

  @override
  String toString() {
    return 'DocumentFilter(types: $types, status: $status, search: $search, dateFrom: $dateFrom, dateTo: $dateTo, limit: $limit, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentFilterImpl &&
            const DeepCollectionEquality().equals(other._types, _types) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.dateFrom, dateFrom) ||
                other.dateFrom == dateFrom) &&
            (identical(other.dateTo, dateTo) || other.dateTo == dateTo) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_types),
    status,
    search,
    dateFrom,
    dateTo,
    limit,
    offset,
  );

  /// Create a copy of DocumentFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentFilterImplCopyWith<_$DocumentFilterImpl> get copyWith =>
      __$$DocumentFilterImplCopyWithImpl<_$DocumentFilterImpl>(
        this,
        _$identity,
      );
}

abstract class _DocumentFilter implements DocumentFilter {
  const factory _DocumentFilter({
    final List<String> types,
    final String? status,
    final String? search,
    final DateTime? dateFrom,
    final DateTime? dateTo,
    final int limit,
    final int offset,
  }) = _$DocumentFilterImpl;

  @override
  List<String> get types;
  @override
  String? get status; // draft, posted, canceled
  @override
  String? get search;
  @override
  DateTime? get dateFrom;
  @override
  DateTime? get dateTo;
  @override
  int get limit;
  @override
  int get offset;

  /// Create a copy of DocumentFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentFilterImplCopyWith<_$DocumentFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
