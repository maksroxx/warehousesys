// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VariantStock _$VariantStockFromJson(Map<String, dynamic> json) {
  return _VariantStock.fromJson(json);
}

/// @nodoc
mixin _$VariantStock {
  @JsonKey(name: 'warehouse_id')
  int get warehouseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_name')
  String get warehouseName => throw _privateConstructorUsedError;
  @JsonKey(name: 'on_hand')
  String get onHand => throw _privateConstructorUsedError;
  String get reserved => throw _privateConstructorUsedError;
  String get available => throw _privateConstructorUsedError;

  /// Serializes this VariantStock to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VariantStock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VariantStockCopyWith<VariantStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariantStockCopyWith<$Res> {
  factory $VariantStockCopyWith(
    VariantStock value,
    $Res Function(VariantStock) then,
  ) = _$VariantStockCopyWithImpl<$Res, VariantStock>;
  @useResult
  $Res call({
    @JsonKey(name: 'warehouse_id') int warehouseId,
    @JsonKey(name: 'warehouse_name') String warehouseName,
    @JsonKey(name: 'on_hand') String onHand,
    String reserved,
    String available,
  });
}

/// @nodoc
class _$VariantStockCopyWithImpl<$Res, $Val extends VariantStock>
    implements $VariantStockCopyWith<$Res> {
  _$VariantStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VariantStock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? warehouseId = null,
    Object? warehouseName = null,
    Object? onHand = null,
    Object? reserved = null,
    Object? available = null,
  }) {
    return _then(
      _value.copyWith(
            warehouseId: null == warehouseId
                ? _value.warehouseId
                : warehouseId // ignore: cast_nullable_to_non_nullable
                      as int,
            warehouseName: null == warehouseName
                ? _value.warehouseName
                : warehouseName // ignore: cast_nullable_to_non_nullable
                      as String,
            onHand: null == onHand
                ? _value.onHand
                : onHand // ignore: cast_nullable_to_non_nullable
                      as String,
            reserved: null == reserved
                ? _value.reserved
                : reserved // ignore: cast_nullable_to_non_nullable
                      as String,
            available: null == available
                ? _value.available
                : available // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VariantStockImplCopyWith<$Res>
    implements $VariantStockCopyWith<$Res> {
  factory _$$VariantStockImplCopyWith(
    _$VariantStockImpl value,
    $Res Function(_$VariantStockImpl) then,
  ) = __$$VariantStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'warehouse_id') int warehouseId,
    @JsonKey(name: 'warehouse_name') String warehouseName,
    @JsonKey(name: 'on_hand') String onHand,
    String reserved,
    String available,
  });
}

/// @nodoc
class __$$VariantStockImplCopyWithImpl<$Res>
    extends _$VariantStockCopyWithImpl<$Res, _$VariantStockImpl>
    implements _$$VariantStockImplCopyWith<$Res> {
  __$$VariantStockImplCopyWithImpl(
    _$VariantStockImpl _value,
    $Res Function(_$VariantStockImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VariantStock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? warehouseId = null,
    Object? warehouseName = null,
    Object? onHand = null,
    Object? reserved = null,
    Object? available = null,
  }) {
    return _then(
      _$VariantStockImpl(
        warehouseId: null == warehouseId
            ? _value.warehouseId
            : warehouseId // ignore: cast_nullable_to_non_nullable
                  as int,
        warehouseName: null == warehouseName
            ? _value.warehouseName
            : warehouseName // ignore: cast_nullable_to_non_nullable
                  as String,
        onHand: null == onHand
            ? _value.onHand
            : onHand // ignore: cast_nullable_to_non_nullable
                  as String,
        reserved: null == reserved
            ? _value.reserved
            : reserved // ignore: cast_nullable_to_non_nullable
                  as String,
        available: null == available
            ? _value.available
            : available // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VariantStockImpl implements _VariantStock {
  const _$VariantStockImpl({
    @JsonKey(name: 'warehouse_id') required this.warehouseId,
    @JsonKey(name: 'warehouse_name') required this.warehouseName,
    @JsonKey(name: 'on_hand') required this.onHand,
    required this.reserved,
    required this.available,
  });

  factory _$VariantStockImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariantStockImplFromJson(json);

  @override
  @JsonKey(name: 'warehouse_id')
  final int warehouseId;
  @override
  @JsonKey(name: 'warehouse_name')
  final String warehouseName;
  @override
  @JsonKey(name: 'on_hand')
  final String onHand;
  @override
  final String reserved;
  @override
  final String available;

  @override
  String toString() {
    return 'VariantStock(warehouseId: $warehouseId, warehouseName: $warehouseName, onHand: $onHand, reserved: $reserved, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariantStockImpl &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.warehouseName, warehouseName) ||
                other.warehouseName == warehouseName) &&
            (identical(other.onHand, onHand) || other.onHand == onHand) &&
            (identical(other.reserved, reserved) ||
                other.reserved == reserved) &&
            (identical(other.available, available) ||
                other.available == available));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    warehouseId,
    warehouseName,
    onHand,
    reserved,
    available,
  );

  /// Create a copy of VariantStock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VariantStockImplCopyWith<_$VariantStockImpl> get copyWith =>
      __$$VariantStockImplCopyWithImpl<_$VariantStockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VariantStockImplToJson(this);
  }
}

abstract class _VariantStock implements VariantStock {
  const factory _VariantStock({
    @JsonKey(name: 'warehouse_id') required final int warehouseId,
    @JsonKey(name: 'warehouse_name') required final String warehouseName,
    @JsonKey(name: 'on_hand') required final String onHand,
    required final String reserved,
    required final String available,
  }) = _$VariantStockImpl;

  factory _VariantStock.fromJson(Map<String, dynamic> json) =
      _$VariantStockImpl.fromJson;

  @override
  @JsonKey(name: 'warehouse_id')
  int get warehouseId;
  @override
  @JsonKey(name: 'warehouse_name')
  String get warehouseName;
  @override
  @JsonKey(name: 'on_hand')
  String get onHand;
  @override
  String get reserved;
  @override
  String get available;

  /// Create a copy of VariantStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VariantStockImplCopyWith<_$VariantStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StockMovement _$StockMovementFromJson(Map<String, dynamic> json) {
  return _StockMovement.fromJson(json);
}

/// @nodoc
mixin _$StockMovement {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'document_id')
  int? get documentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'document_number')
  String? get documentNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant_sku')
  String get variantSku => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_name')
  String get warehouseName => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError; // "INCOME", "OUTCOME"
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this StockMovement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockMovementCopyWith<StockMovement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockMovementCopyWith<$Res> {
  factory $StockMovementCopyWith(
    StockMovement value,
    $Res Function(StockMovement) then,
  ) = _$StockMovementCopyWithImpl<$Res, StockMovement>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'document_id') int? documentId,
    @JsonKey(name: 'document_number') String? documentNumber,
    @JsonKey(name: 'variant_sku') String variantSku,
    @JsonKey(name: 'product_name') String productName,
    @JsonKey(name: 'warehouse_name') String warehouseName,
    String quantity,
    String type,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$StockMovementCopyWithImpl<$Res, $Val extends StockMovement>
    implements $StockMovementCopyWith<$Res> {
  _$StockMovementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = freezed,
    Object? documentNumber = freezed,
    Object? variantSku = null,
    Object? productName = null,
    Object? warehouseName = null,
    Object? quantity = null,
    Object? type = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            documentId: freezed == documentId
                ? _value.documentId
                : documentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            documentNumber: freezed == documentNumber
                ? _value.documentNumber
                : documentNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            variantSku: null == variantSku
                ? _value.variantSku
                : variantSku // ignore: cast_nullable_to_non_nullable
                      as String,
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            warehouseName: null == warehouseName
                ? _value.warehouseName
                : warehouseName // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StockMovementImplCopyWith<$Res>
    implements $StockMovementCopyWith<$Res> {
  factory _$$StockMovementImplCopyWith(
    _$StockMovementImpl value,
    $Res Function(_$StockMovementImpl) then,
  ) = __$$StockMovementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'document_id') int? documentId,
    @JsonKey(name: 'document_number') String? documentNumber,
    @JsonKey(name: 'variant_sku') String variantSku,
    @JsonKey(name: 'product_name') String productName,
    @JsonKey(name: 'warehouse_name') String warehouseName,
    String quantity,
    String type,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$StockMovementImplCopyWithImpl<$Res>
    extends _$StockMovementCopyWithImpl<$Res, _$StockMovementImpl>
    implements _$$StockMovementImplCopyWith<$Res> {
  __$$StockMovementImplCopyWithImpl(
    _$StockMovementImpl _value,
    $Res Function(_$StockMovementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StockMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = freezed,
    Object? documentNumber = freezed,
    Object? variantSku = null,
    Object? productName = null,
    Object? warehouseName = null,
    Object? quantity = null,
    Object? type = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$StockMovementImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        documentId: freezed == documentId
            ? _value.documentId
            : documentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        documentNumber: freezed == documentNumber
            ? _value.documentNumber
            : documentNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        variantSku: null == variantSku
            ? _value.variantSku
            : variantSku // ignore: cast_nullable_to_non_nullable
                  as String,
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        warehouseName: null == warehouseName
            ? _value.warehouseName
            : warehouseName // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StockMovementImpl implements _StockMovement {
  const _$StockMovementImpl({
    required this.id,
    @JsonKey(name: 'document_id') this.documentId,
    @JsonKey(name: 'document_number') this.documentNumber,
    @JsonKey(name: 'variant_sku') required this.variantSku,
    @JsonKey(name: 'product_name') required this.productName,
    @JsonKey(name: 'warehouse_name') required this.warehouseName,
    required this.quantity,
    required this.type,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$StockMovementImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockMovementImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'document_id')
  final int? documentId;
  @override
  @JsonKey(name: 'document_number')
  final String? documentNumber;
  @override
  @JsonKey(name: 'variant_sku')
  final String variantSku;
  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  @JsonKey(name: 'warehouse_name')
  final String warehouseName;
  @override
  final String quantity;
  @override
  final String type;
  // "INCOME", "OUTCOME"
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'StockMovement(id: $id, documentId: $documentId, documentNumber: $documentNumber, variantSku: $variantSku, productName: $productName, warehouseName: $warehouseName, quantity: $quantity, type: $type, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockMovementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.documentNumber, documentNumber) ||
                other.documentNumber == documentNumber) &&
            (identical(other.variantSku, variantSku) ||
                other.variantSku == variantSku) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.warehouseName, warehouseName) ||
                other.warehouseName == warehouseName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    documentId,
    documentNumber,
    variantSku,
    productName,
    warehouseName,
    quantity,
    type,
    createdAt,
  );

  /// Create a copy of StockMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockMovementImplCopyWith<_$StockMovementImpl> get copyWith =>
      __$$StockMovementImplCopyWithImpl<_$StockMovementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockMovementImplToJson(this);
  }
}

abstract class _StockMovement implements StockMovement {
  const factory _StockMovement({
    required final int id,
    @JsonKey(name: 'document_id') final int? documentId,
    @JsonKey(name: 'document_number') final String? documentNumber,
    @JsonKey(name: 'variant_sku') required final String variantSku,
    @JsonKey(name: 'product_name') required final String productName,
    @JsonKey(name: 'warehouse_name') required final String warehouseName,
    required final String quantity,
    required final String type,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$StockMovementImpl;

  factory _StockMovement.fromJson(Map<String, dynamic> json) =
      _$StockMovementImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'document_id')
  int? get documentId;
  @override
  @JsonKey(name: 'document_number')
  String? get documentNumber;
  @override
  @JsonKey(name: 'variant_sku')
  String get variantSku;
  @override
  @JsonKey(name: 'product_name')
  String get productName;
  @override
  @JsonKey(name: 'warehouse_name')
  String get warehouseName;
  @override
  String get quantity;
  @override
  String get type; // "INCOME", "OUTCOME"
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of StockMovement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockMovementImplCopyWith<_$StockMovementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
