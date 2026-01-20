// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VariantFilterImpl _$$VariantFilterImplFromJson(Map<String, dynamic> json) =>
    _$VariantFilterImpl(
      name: json['name'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt() ?? -1,
      warehouseId: (json['warehouseId'] as num?)?.toInt() ?? -1,
      stockStatus: json['stockStatus'] as String? ?? 'all',
      limit: (json['limit'] as num?)?.toInt() ?? 50,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$VariantFilterImplToJson(_$VariantFilterImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categoryId': instance.categoryId,
      'warehouseId': instance.warehouseId,
      'stockStatus': instance.stockStatus,
      'limit': instance.limit,
      'offset': instance.offset,
    };

_$ProductImageImpl _$$ProductImageImplFromJson(Map<String, dynamic> json) =>
    _$ProductImageImpl(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$$ProductImageImplToJson(_$ProductImageImpl instance) =>
    <String, dynamic>{'id': instance.id, 'url': instance.url};

_$InventoryItemImpl _$$InventoryItemImplFromJson(Map<String, dynamic> json) =>
    _$InventoryItemImpl(
      id: (json['id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      productName: json['product_name'] as String,
      categoryId: (json['category_id'] as num).toInt(),
      categoryName: json['category_name'] as String,
      sku: json['sku'] as String,
      unitId: (json['unit_id'] as num).toInt(),
      unitName: json['unit_name'] as String,
      quantityOnStock: json['quantity_on_stock'] as String? ?? '0',
      characteristics: (json['characteristics'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$InventoryItemImplToJson(_$InventoryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'sku': instance.sku,
      'unit_id': instance.unitId,
      'unit_name': instance.unitName,
      'quantity_on_stock': instance.quantityOnStock,
      'characteristics': instance.characteristics,
      'images': instance.images,
    };
