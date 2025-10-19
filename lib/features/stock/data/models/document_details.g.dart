// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentDetailsDTOImpl _$$DocumentDetailsDTOImplFromJson(
  Map<String, dynamic> json,
) => _$DocumentDetailsDTOImpl(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
  number: json['number'] as String,
  warehouseId: (json['warehouse_id'] as num?)?.toInt(),
  warehouseName: json['warehouse_name'] as String?,
  comment: json['comment'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => DocumentItemDTO.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  status: json['status'] as String,
  postedAt: json['posted_at'] == null
      ? null
      : DateTime.parse(json['posted_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  counterpartyName: json['counterparty_name'] as String?,
);

Map<String, dynamic> _$$DocumentDetailsDTOImplToJson(
  _$DocumentDetailsDTOImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'number': instance.number,
  'warehouse_id': instance.warehouseId,
  'warehouse_name': instance.warehouseName,
  'comment': instance.comment,
  'items': instance.items,
  'status': instance.status,
  'posted_at': instance.postedAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'counterparty_name': instance.counterpartyName,
};

_$DocumentItemDTOImpl _$$DocumentItemDTOImplFromJson(
  Map<String, dynamic> json,
) => _$DocumentItemDTOImpl(
  id: (json['id'] as num).toInt(),
  variantId: (json['variant_id'] as num).toInt(),
  variantSku: json['variant_sku'] as String,
  productName: json['product_name'] as String,
  quantity: json['quantity'] as String,
  price: json['price'] as String?,
);

Map<String, dynamic> _$$DocumentItemDTOImplToJson(
  _$DocumentItemDTOImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'variant_id': instance.variantId,
  'variant_sku': instance.variantSku,
  'product_name': instance.productName,
  'quantity': instance.quantity,
  'price': instance.price,
};
