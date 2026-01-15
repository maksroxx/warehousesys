// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VariantFilter _$VariantFilterFromJson(Map<String, dynamic> json) {
  return _VariantFilter.fromJson(json);
}

/// @nodoc
mixin _$VariantFilter {
  String? get name => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  int get warehouseId => throw _privateConstructorUsedError;
  String get stockStatus => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;

  /// Serializes this VariantFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VariantFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VariantFilterCopyWith<VariantFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariantFilterCopyWith<$Res> {
  factory $VariantFilterCopyWith(
    VariantFilter value,
    $Res Function(VariantFilter) then,
  ) = _$VariantFilterCopyWithImpl<$Res, VariantFilter>;
  @useResult
  $Res call({
    String? name,
    int categoryId,
    int warehouseId,
    String stockStatus,
    int limit,
    int offset,
  });
}

/// @nodoc
class _$VariantFilterCopyWithImpl<$Res, $Val extends VariantFilter>
    implements $VariantFilterCopyWith<$Res> {
  _$VariantFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VariantFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? categoryId = null,
    Object? warehouseId = null,
    Object? stockStatus = null,
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            warehouseId: null == warehouseId
                ? _value.warehouseId
                : warehouseId // ignore: cast_nullable_to_non_nullable
                      as int,
            stockStatus: null == stockStatus
                ? _value.stockStatus
                : stockStatus // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$VariantFilterImplCopyWith<$Res>
    implements $VariantFilterCopyWith<$Res> {
  factory _$$VariantFilterImplCopyWith(
    _$VariantFilterImpl value,
    $Res Function(_$VariantFilterImpl) then,
  ) = __$$VariantFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? name,
    int categoryId,
    int warehouseId,
    String stockStatus,
    int limit,
    int offset,
  });
}

/// @nodoc
class __$$VariantFilterImplCopyWithImpl<$Res>
    extends _$VariantFilterCopyWithImpl<$Res, _$VariantFilterImpl>
    implements _$$VariantFilterImplCopyWith<$Res> {
  __$$VariantFilterImplCopyWithImpl(
    _$VariantFilterImpl _value,
    $Res Function(_$VariantFilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VariantFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? categoryId = null,
    Object? warehouseId = null,
    Object? stockStatus = null,
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(
      _$VariantFilterImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        warehouseId: null == warehouseId
            ? _value.warehouseId
            : warehouseId // ignore: cast_nullable_to_non_nullable
                  as int,
        stockStatus: null == stockStatus
            ? _value.stockStatus
            : stockStatus // ignore: cast_nullable_to_non_nullable
                  as String,
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
@JsonSerializable()
class _$VariantFilterImpl implements _VariantFilter {
  const _$VariantFilterImpl({
    this.name,
    this.categoryId = -1,
    this.warehouseId = -1,
    this.stockStatus = 'all',
    this.limit = 50,
    this.offset = 0,
  });

  factory _$VariantFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariantFilterImplFromJson(json);

  @override
  final String? name;
  @override
  @JsonKey()
  final int categoryId;
  @override
  @JsonKey()
  final int warehouseId;
  @override
  @JsonKey()
  final String stockStatus;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int offset;

  @override
  String toString() {
    return 'VariantFilter(name: $name, categoryId: $categoryId, warehouseId: $warehouseId, stockStatus: $stockStatus, limit: $limit, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariantFilterImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.stockStatus, stockStatus) ||
                other.stockStatus == stockStatus) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    categoryId,
    warehouseId,
    stockStatus,
    limit,
    offset,
  );

  /// Create a copy of VariantFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VariantFilterImplCopyWith<_$VariantFilterImpl> get copyWith =>
      __$$VariantFilterImplCopyWithImpl<_$VariantFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VariantFilterImplToJson(this);
  }
}

abstract class _VariantFilter implements VariantFilter {
  const factory _VariantFilter({
    final String? name,
    final int categoryId,
    final int warehouseId,
    final String stockStatus,
    final int limit,
    final int offset,
  }) = _$VariantFilterImpl;

  factory _VariantFilter.fromJson(Map<String, dynamic> json) =
      _$VariantFilterImpl.fromJson;

  @override
  String? get name;
  @override
  int get categoryId;
  @override
  int get warehouseId;
  @override
  String get stockStatus;
  @override
  int get limit;
  @override
  int get offset;

  /// Create a copy of VariantFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VariantFilterImplCopyWith<_$VariantFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) {
  return _InventoryItem.fromJson(json);
}

/// @nodoc
mixin _$InventoryItem {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String get categoryName => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_id')
  int get unitId => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_name')
  String get unitName => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity_on_stock', defaultValue: "0")
  String get quantityOnStock => throw _privateConstructorUsedError;
  Map<String, String>? get characteristics =>
      throw _privateConstructorUsedError;

  /// Serializes this InventoryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryItemCopyWith<InventoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryItemCopyWith<$Res> {
  factory $InventoryItemCopyWith(
    InventoryItem value,
    $Res Function(InventoryItem) then,
  ) = _$InventoryItemCopyWithImpl<$Res, InventoryItem>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'product_id') int productId,
    @JsonKey(name: 'product_name') String productName,
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    String sku,
    @JsonKey(name: 'unit_id') int unitId,
    @JsonKey(name: 'unit_name') String unitName,
    @JsonKey(name: 'quantity_on_stock', defaultValue: "0")
    String quantityOnStock,
    Map<String, String>? characteristics,
  });
}

/// @nodoc
class _$InventoryItemCopyWithImpl<$Res, $Val extends InventoryItem>
    implements $InventoryItemCopyWith<$Res> {
  _$InventoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? productName = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? sku = null,
    Object? unitId = null,
    Object? unitName = null,
    Object? quantityOnStock = null,
    Object? characteristics = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as int,
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            sku: null == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                      as String,
            unitId: null == unitId
                ? _value.unitId
                : unitId // ignore: cast_nullable_to_non_nullable
                      as int,
            unitName: null == unitName
                ? _value.unitName
                : unitName // ignore: cast_nullable_to_non_nullable
                      as String,
            quantityOnStock: null == quantityOnStock
                ? _value.quantityOnStock
                : quantityOnStock // ignore: cast_nullable_to_non_nullable
                      as String,
            characteristics: freezed == characteristics
                ? _value.characteristics
                : characteristics // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryItemImplCopyWith<$Res>
    implements $InventoryItemCopyWith<$Res> {
  factory _$$InventoryItemImplCopyWith(
    _$InventoryItemImpl value,
    $Res Function(_$InventoryItemImpl) then,
  ) = __$$InventoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'product_id') int productId,
    @JsonKey(name: 'product_name') String productName,
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    String sku,
    @JsonKey(name: 'unit_id') int unitId,
    @JsonKey(name: 'unit_name') String unitName,
    @JsonKey(name: 'quantity_on_stock', defaultValue: "0")
    String quantityOnStock,
    Map<String, String>? characteristics,
  });
}

/// @nodoc
class __$$InventoryItemImplCopyWithImpl<$Res>
    extends _$InventoryItemCopyWithImpl<$Res, _$InventoryItemImpl>
    implements _$$InventoryItemImplCopyWith<$Res> {
  __$$InventoryItemImplCopyWithImpl(
    _$InventoryItemImpl _value,
    $Res Function(_$InventoryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? productName = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? sku = null,
    Object? unitId = null,
    Object? unitName = null,
    Object? quantityOnStock = null,
    Object? characteristics = freezed,
  }) {
    return _then(
      _$InventoryItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as int,
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        sku: null == sku
            ? _value.sku
            : sku // ignore: cast_nullable_to_non_nullable
                  as String,
        unitId: null == unitId
            ? _value.unitId
            : unitId // ignore: cast_nullable_to_non_nullable
                  as int,
        unitName: null == unitName
            ? _value.unitName
            : unitName // ignore: cast_nullable_to_non_nullable
                  as String,
        quantityOnStock: null == quantityOnStock
            ? _value.quantityOnStock
            : quantityOnStock // ignore: cast_nullable_to_non_nullable
                  as String,
        characteristics: freezed == characteristics
            ? _value._characteristics
            : characteristics // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryItemImpl implements _InventoryItem {
  const _$InventoryItemImpl({
    required this.id,
    @JsonKey(name: 'product_id') required this.productId,
    @JsonKey(name: 'product_name') required this.productName,
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'category_name') required this.categoryName,
    required this.sku,
    @JsonKey(name: 'unit_id') required this.unitId,
    @JsonKey(name: 'unit_name') required this.unitName,
    @JsonKey(name: 'quantity_on_stock', defaultValue: "0")
    required this.quantityOnStock,
    final Map<String, String>? characteristics,
  }) : _characteristics = characteristics;

  factory _$InventoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryItemImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  @JsonKey(name: 'category_id')
  final int categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String categoryName;
  @override
  final String sku;
  @override
  @JsonKey(name: 'unit_id')
  final int unitId;
  @override
  @JsonKey(name: 'unit_name')
  final String unitName;
  @override
  @JsonKey(name: 'quantity_on_stock', defaultValue: "0")
  final String quantityOnStock;
  final Map<String, String>? _characteristics;
  @override
  Map<String, String>? get characteristics {
    final value = _characteristics;
    if (value == null) return null;
    if (_characteristics is EqualUnmodifiableMapView) return _characteristics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'InventoryItem(id: $id, productId: $productId, productName: $productName, categoryId: $categoryId, categoryName: $categoryName, sku: $sku, unitId: $unitId, unitName: $unitName, quantityOnStock: $quantityOnStock, characteristics: $characteristics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.unitId, unitId) || other.unitId == unitId) &&
            (identical(other.unitName, unitName) ||
                other.unitName == unitName) &&
            (identical(other.quantityOnStock, quantityOnStock) ||
                other.quantityOnStock == quantityOnStock) &&
            const DeepCollectionEquality().equals(
              other._characteristics,
              _characteristics,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    productId,
    productName,
    categoryId,
    categoryName,
    sku,
    unitId,
    unitName,
    quantityOnStock,
    const DeepCollectionEquality().hash(_characteristics),
  );

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryItemImplCopyWith<_$InventoryItemImpl> get copyWith =>
      __$$InventoryItemImplCopyWithImpl<_$InventoryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryItemImplToJson(this);
  }
}

abstract class _InventoryItem implements InventoryItem {
  const factory _InventoryItem({
    required final int id,
    @JsonKey(name: 'product_id') required final int productId,
    @JsonKey(name: 'product_name') required final String productName,
    @JsonKey(name: 'category_id') required final int categoryId,
    @JsonKey(name: 'category_name') required final String categoryName,
    required final String sku,
    @JsonKey(name: 'unit_id') required final int unitId,
    @JsonKey(name: 'unit_name') required final String unitName,
    @JsonKey(name: 'quantity_on_stock', defaultValue: "0")
    required final String quantityOnStock,
    final Map<String, String>? characteristics,
  }) = _$InventoryItemImpl;

  factory _InventoryItem.fromJson(Map<String, dynamic> json) =
      _$InventoryItemImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  @JsonKey(name: 'product_name')
  String get productName;
  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String get categoryName;
  @override
  String get sku;
  @override
  @JsonKey(name: 'unit_id')
  int get unitId;
  @override
  @JsonKey(name: 'unit_name')
  String get unitName;
  @override
  @JsonKey(name: 'quantity_on_stock', defaultValue: "0")
  String get quantityOnStock;
  @override
  Map<String, String>? get characteristics;

  /// Create a copy of InventoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryItemImplCopyWith<_$InventoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
