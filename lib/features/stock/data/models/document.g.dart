// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentListItemImpl _$$DocumentListItemImplFromJson(
  Map<String, dynamic> json,
) => _$DocumentListItemImpl(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
  number: json['number'] as String,
  warehouseName: json['warehouse_name'] as String?,
  counterpartyName: json['counterparty_name'] as String?,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  totalItems: (json['item_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DocumentListItemImplToJson(
  _$DocumentListItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'number': instance.number,
  'warehouse_name': instance.warehouseName,
  'counterparty_name': instance.counterpartyName,
  'status': instance.status,
  'created_at': instance.createdAt.toIso8601String(),
  'item_count': instance.totalItems,
};
