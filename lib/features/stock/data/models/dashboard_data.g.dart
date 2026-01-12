// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardDataImpl _$$DashboardDataImplFromJson(Map<String, dynamic> json) =>
    _$DashboardDataImpl(
      totalStock: json['total_stock'] as String,
      totalVariants: (json['total_variants'] as num).toInt(),
      itemsInStock: (json['items_in_stock'] as num).toInt(),
      lowStockCount: (json['low_stock_count'] as num).toInt(),
      totalItemsCount: (json['total_items_count'] as num).toInt(),
      recentOperations: (json['recent_operations'] as num).toInt(),
      incomingToday: json['incoming_today'] as String,
      outgoingToday: json['outgoing_today'] as String,
      chartData:
          (json['chart_data'] as List<dynamic>?)
              ?.map((e) => ChartPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recentMovements:
          (json['recent_movements'] as List<dynamic>?)
              ?.map((e) => MovementShort.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DashboardDataImplToJson(_$DashboardDataImpl instance) =>
    <String, dynamic>{
      'total_stock': instance.totalStock,
      'total_variants': instance.totalVariants,
      'items_in_stock': instance.itemsInStock,
      'low_stock_count': instance.lowStockCount,
      'total_items_count': instance.totalItemsCount,
      'recent_operations': instance.recentOperations,
      'incoming_today': instance.incomingToday,
      'outgoing_today': instance.outgoingToday,
      'chart_data': instance.chartData,
      'recent_movements': instance.recentMovements,
    };

_$ChartPointImpl _$$ChartPointImplFromJson(Map<String, dynamic> json) =>
    _$ChartPointImpl(
      date: json['date'] as String,
      value: json['value'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$ChartPointImplToJson(_$ChartPointImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'value': instance.value,
      'type': instance.type,
    };

_$MovementShortImpl _$$MovementShortImplFromJson(Map<String, dynamic> json) =>
    _$MovementShortImpl(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      itemName: json['item_name'] as String,
      type: json['type'] as String,
      quantity: json['quantity'] as String,
      warehouseName: json['warehouse_name'] as String,
    );

Map<String, dynamic> _$$MovementShortImplToJson(_$MovementShortImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'item_name': instance.itemName,
      'type': instance.type,
      'quantity': instance.quantity,
      'warehouse_name': instance.warehouseName,
    };
