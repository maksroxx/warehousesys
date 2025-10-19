// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VariantStockImpl _$$VariantStockImplFromJson(Map<String, dynamic> json) =>
    _$VariantStockImpl(
      warehouseId: (json['warehouse_id'] as num).toInt(),
      warehouseName: json['warehouse_name'] as String,
      onHand: json['on_hand'] as String,
      reserved: json['reserved'] as String,
      available: json['available'] as String,
    );

Map<String, dynamic> _$$VariantStockImplToJson(_$VariantStockImpl instance) =>
    <String, dynamic>{
      'warehouse_id': instance.warehouseId,
      'warehouse_name': instance.warehouseName,
      'on_hand': instance.onHand,
      'reserved': instance.reserved,
      'available': instance.available,
    };

_$StockMovementImpl _$$StockMovementImplFromJson(Map<String, dynamic> json) =>
    _$StockMovementImpl(
      id: (json['id'] as num).toInt(),
      documentId: (json['document_id'] as num?)?.toInt(),
      documentNumber: json['document_number'] as String?,
      variantSku: json['variant_sku'] as String,
      productName: json['product_name'] as String,
      warehouseName: json['warehouse_name'] as String,
      quantity: json['quantity'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$StockMovementImplToJson(_$StockMovementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'document_id': instance.documentId,
      'document_number': instance.documentNumber,
      'variant_sku': instance.variantSku,
      'product_name': instance.productName,
      'warehouse_name': instance.warehouseName,
      'quantity': instance.quantity,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
    };
