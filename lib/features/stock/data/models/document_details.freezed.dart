// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DocumentDetailsDTO _$DocumentDetailsDTOFromJson(Map<String, dynamic> json) {
  return _DocumentDetailsDTO.fromJson(json);
}

/// @nodoc
mixin _$DocumentDetailsDTO {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_name')
  String? get warehouseName => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  List<DocumentItemDTO> get items => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'posted_at')
  DateTime? get postedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError; // Добавляем опциональные поля для других типов документов
  @JsonKey(name: 'counterparty_name')
  String? get counterpartyName => throw _privateConstructorUsedError;

  /// Serializes this DocumentDetailsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentDetailsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentDetailsDTOCopyWith<DocumentDetailsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentDetailsDTOCopyWith<$Res> {
  factory $DocumentDetailsDTOCopyWith(
    DocumentDetailsDTO value,
    $Res Function(DocumentDetailsDTO) then,
  ) = _$DocumentDetailsDTOCopyWithImpl<$Res, DocumentDetailsDTO>;
  @useResult
  $Res call({
    int id,
    String type,
    String number,
    @JsonKey(name: 'warehouse_id') int? warehouseId,
    @JsonKey(name: 'warehouse_name') String? warehouseName,
    String? comment,
    List<DocumentItemDTO> items,
    String status,
    @JsonKey(name: 'posted_at') DateTime? postedAt,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'counterparty_name') String? counterpartyName,
  });
}

/// @nodoc
class _$DocumentDetailsDTOCopyWithImpl<$Res, $Val extends DocumentDetailsDTO>
    implements $DocumentDetailsDTOCopyWith<$Res> {
  _$DocumentDetailsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentDetailsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? number = null,
    Object? warehouseId = freezed,
    Object? warehouseName = freezed,
    Object? comment = freezed,
    Object? items = null,
    Object? status = null,
    Object? postedAt = freezed,
    Object? createdAt = null,
    Object? counterpartyName = freezed,
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
            warehouseId: freezed == warehouseId
                ? _value.warehouseId
                : warehouseId // ignore: cast_nullable_to_non_nullable
                      as int?,
            warehouseName: freezed == warehouseName
                ? _value.warehouseName
                : warehouseName // ignore: cast_nullable_to_non_nullable
                      as String?,
            comment: freezed == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<DocumentItemDTO>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            postedAt: freezed == postedAt
                ? _value.postedAt
                : postedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            counterpartyName: freezed == counterpartyName
                ? _value.counterpartyName
                : counterpartyName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentDetailsDTOImplCopyWith<$Res>
    implements $DocumentDetailsDTOCopyWith<$Res> {
  factory _$$DocumentDetailsDTOImplCopyWith(
    _$DocumentDetailsDTOImpl value,
    $Res Function(_$DocumentDetailsDTOImpl) then,
  ) = __$$DocumentDetailsDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String type,
    String number,
    @JsonKey(name: 'warehouse_id') int? warehouseId,
    @JsonKey(name: 'warehouse_name') String? warehouseName,
    String? comment,
    List<DocumentItemDTO> items,
    String status,
    @JsonKey(name: 'posted_at') DateTime? postedAt,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'counterparty_name') String? counterpartyName,
  });
}

/// @nodoc
class __$$DocumentDetailsDTOImplCopyWithImpl<$Res>
    extends _$DocumentDetailsDTOCopyWithImpl<$Res, _$DocumentDetailsDTOImpl>
    implements _$$DocumentDetailsDTOImplCopyWith<$Res> {
  __$$DocumentDetailsDTOImplCopyWithImpl(
    _$DocumentDetailsDTOImpl _value,
    $Res Function(_$DocumentDetailsDTOImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocumentDetailsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? number = null,
    Object? warehouseId = freezed,
    Object? warehouseName = freezed,
    Object? comment = freezed,
    Object? items = null,
    Object? status = null,
    Object? postedAt = freezed,
    Object? createdAt = null,
    Object? counterpartyName = freezed,
  }) {
    return _then(
      _$DocumentDetailsDTOImpl(
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
        warehouseId: freezed == warehouseId
            ? _value.warehouseId
            : warehouseId // ignore: cast_nullable_to_non_nullable
                  as int?,
        warehouseName: freezed == warehouseName
            ? _value.warehouseName
            : warehouseName // ignore: cast_nullable_to_non_nullable
                  as String?,
        comment: freezed == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<DocumentItemDTO>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        postedAt: freezed == postedAt
            ? _value.postedAt
            : postedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        counterpartyName: freezed == counterpartyName
            ? _value.counterpartyName
            : counterpartyName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentDetailsDTOImpl implements _DocumentDetailsDTO {
  const _$DocumentDetailsDTOImpl({
    required this.id,
    required this.type,
    required this.number,
    @JsonKey(name: 'warehouse_id') this.warehouseId,
    @JsonKey(name: 'warehouse_name') this.warehouseName,
    this.comment,
    final List<DocumentItemDTO> items = const [],
    required this.status,
    @JsonKey(name: 'posted_at') this.postedAt,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'counterparty_name') this.counterpartyName,
  }) : _items = items;

  factory _$DocumentDetailsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentDetailsDTOImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final String number;
  @override
  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;
  @override
  @JsonKey(name: 'warehouse_name')
  final String? warehouseName;
  @override
  final String? comment;
  final List<DocumentItemDTO> _items;
  @override
  @JsonKey()
  List<DocumentItemDTO> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String status;
  @override
  @JsonKey(name: 'posted_at')
  final DateTime? postedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  // Добавляем опциональные поля для других типов документов
  @override
  @JsonKey(name: 'counterparty_name')
  final String? counterpartyName;

  @override
  String toString() {
    return 'DocumentDetailsDTO(id: $id, type: $type, number: $number, warehouseId: $warehouseId, warehouseName: $warehouseName, comment: $comment, items: $items, status: $status, postedAt: $postedAt, createdAt: $createdAt, counterpartyName: $counterpartyName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentDetailsDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.warehouseName, warehouseName) ||
                other.warehouseName == warehouseName) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.postedAt, postedAt) ||
                other.postedAt == postedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.counterpartyName, counterpartyName) ||
                other.counterpartyName == counterpartyName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    number,
    warehouseId,
    warehouseName,
    comment,
    const DeepCollectionEquality().hash(_items),
    status,
    postedAt,
    createdAt,
    counterpartyName,
  );

  /// Create a copy of DocumentDetailsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentDetailsDTOImplCopyWith<_$DocumentDetailsDTOImpl> get copyWith =>
      __$$DocumentDetailsDTOImplCopyWithImpl<_$DocumentDetailsDTOImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentDetailsDTOImplToJson(this);
  }
}

abstract class _DocumentDetailsDTO implements DocumentDetailsDTO {
  const factory _DocumentDetailsDTO({
    required final int id,
    required final String type,
    required final String number,
    @JsonKey(name: 'warehouse_id') final int? warehouseId,
    @JsonKey(name: 'warehouse_name') final String? warehouseName,
    final String? comment,
    final List<DocumentItemDTO> items,
    required final String status,
    @JsonKey(name: 'posted_at') final DateTime? postedAt,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'counterparty_name') final String? counterpartyName,
  }) = _$DocumentDetailsDTOImpl;

  factory _DocumentDetailsDTO.fromJson(Map<String, dynamic> json) =
      _$DocumentDetailsDTOImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  String get number;
  @override
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId;
  @override
  @JsonKey(name: 'warehouse_name')
  String? get warehouseName;
  @override
  String? get comment;
  @override
  List<DocumentItemDTO> get items;
  @override
  String get status;
  @override
  @JsonKey(name: 'posted_at')
  DateTime? get postedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt; // Добавляем опциональные поля для других типов документов
  @override
  @JsonKey(name: 'counterparty_name')
  String? get counterpartyName;

  /// Create a copy of DocumentDetailsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentDetailsDTOImplCopyWith<_$DocumentDetailsDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DocumentItemDTO _$DocumentItemDTOFromJson(Map<String, dynamic> json) {
  return _DocumentItemDTO.fromJson(json);
}

/// @nodoc
mixin _$DocumentItemDTO {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant_id')
  int get variantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant_sku')
  String get variantSku => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get productName => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;

  /// Serializes this DocumentItemDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentItemDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentItemDTOCopyWith<DocumentItemDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentItemDTOCopyWith<$Res> {
  factory $DocumentItemDTOCopyWith(
    DocumentItemDTO value,
    $Res Function(DocumentItemDTO) then,
  ) = _$DocumentItemDTOCopyWithImpl<$Res, DocumentItemDTO>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'variant_id') int variantId,
    @JsonKey(name: 'variant_sku') String variantSku,
    @JsonKey(name: 'product_name') String productName,
    String quantity,
    String? price,
  });
}

/// @nodoc
class _$DocumentItemDTOCopyWithImpl<$Res, $Val extends DocumentItemDTO>
    implements $DocumentItemDTOCopyWith<$Res> {
  _$DocumentItemDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentItemDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? variantId = null,
    Object? variantSku = null,
    Object? productName = null,
    Object? quantity = null,
    Object? price = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            variantId: null == variantId
                ? _value.variantId
                : variantId // ignore: cast_nullable_to_non_nullable
                      as int,
            variantSku: null == variantSku
                ? _value.variantSku
                : variantSku // ignore: cast_nullable_to_non_nullable
                      as String,
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as String,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentItemDTOImplCopyWith<$Res>
    implements $DocumentItemDTOCopyWith<$Res> {
  factory _$$DocumentItemDTOImplCopyWith(
    _$DocumentItemDTOImpl value,
    $Res Function(_$DocumentItemDTOImpl) then,
  ) = __$$DocumentItemDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'variant_id') int variantId,
    @JsonKey(name: 'variant_sku') String variantSku,
    @JsonKey(name: 'product_name') String productName,
    String quantity,
    String? price,
  });
}

/// @nodoc
class __$$DocumentItemDTOImplCopyWithImpl<$Res>
    extends _$DocumentItemDTOCopyWithImpl<$Res, _$DocumentItemDTOImpl>
    implements _$$DocumentItemDTOImplCopyWith<$Res> {
  __$$DocumentItemDTOImplCopyWithImpl(
    _$DocumentItemDTOImpl _value,
    $Res Function(_$DocumentItemDTOImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocumentItemDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? variantId = null,
    Object? variantSku = null,
    Object? productName = null,
    Object? quantity = null,
    Object? price = freezed,
  }) {
    return _then(
      _$DocumentItemDTOImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        variantId: null == variantId
            ? _value.variantId
            : variantId // ignore: cast_nullable_to_non_nullable
                  as int,
        variantSku: null == variantSku
            ? _value.variantSku
            : variantSku // ignore: cast_nullable_to_non_nullable
                  as String,
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as String,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentItemDTOImpl implements _DocumentItemDTO {
  const _$DocumentItemDTOImpl({
    required this.id,
    @JsonKey(name: 'variant_id') required this.variantId,
    @JsonKey(name: 'variant_sku') required this.variantSku,
    @JsonKey(name: 'product_name') required this.productName,
    required this.quantity,
    this.price,
  });

  factory _$DocumentItemDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentItemDTOImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'variant_id')
  final int variantId;
  @override
  @JsonKey(name: 'variant_sku')
  final String variantSku;
  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  final String quantity;
  @override
  final String? price;

  @override
  String toString() {
    return 'DocumentItemDTO(id: $id, variantId: $variantId, variantSku: $variantSku, productName: $productName, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentItemDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.variantSku, variantSku) ||
                other.variantSku == variantSku) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    variantId,
    variantSku,
    productName,
    quantity,
    price,
  );

  /// Create a copy of DocumentItemDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentItemDTOImplCopyWith<_$DocumentItemDTOImpl> get copyWith =>
      __$$DocumentItemDTOImplCopyWithImpl<_$DocumentItemDTOImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentItemDTOImplToJson(this);
  }
}

abstract class _DocumentItemDTO implements DocumentItemDTO {
  const factory _DocumentItemDTO({
    required final int id,
    @JsonKey(name: 'variant_id') required final int variantId,
    @JsonKey(name: 'variant_sku') required final String variantSku,
    @JsonKey(name: 'product_name') required final String productName,
    required final String quantity,
    final String? price,
  }) = _$DocumentItemDTOImpl;

  factory _DocumentItemDTO.fromJson(Map<String, dynamic> json) =
      _$DocumentItemDTOImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'variant_id')
  int get variantId;
  @override
  @JsonKey(name: 'variant_sku')
  String get variantSku;
  @override
  @JsonKey(name: 'product_name')
  String get productName;
  @override
  String get quantity;
  @override
  String? get price;

  /// Create a copy of DocumentItemDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentItemDTOImplCopyWith<_$DocumentItemDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
