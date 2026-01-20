// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_data.freezed.dart';
part 'dashboard_data.g.dart';

@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData({
    @JsonKey(name: 'total_stock') required String totalStock,
    
    @JsonKey(name: 'total_variants') required int totalVariants,
    @JsonKey(name: 'items_in_stock') required int itemsInStock,
    @JsonKey(name: 'low_stock_count') required int lowStockCount,
    
    @JsonKey(name: 'total_items_count') required int totalItemsCount,
    @JsonKey(name: 'recent_operations') required int recentOperations,
    
    @JsonKey(name: 'incoming_today') required String incomingToday,
    @JsonKey(name: 'outgoing_today') required String outgoingToday,
    
    @JsonKey(name: 'chart_data') @Default([]) List<ChartPoint> chartData,
    @JsonKey(name: 'recent_movements') @Default([]) List<MovementShort> recentMovements,
  }) = _DashboardData;

  factory DashboardData.fromJson(Map<String, dynamic> json) => _$DashboardDataFromJson(json);
}

@freezed
class ChartPoint with _$ChartPoint {
  const factory ChartPoint({
    required String date,
    required String value,
    required String type,
  }) = _ChartPoint;

  factory ChartPoint.fromJson(Map<String, dynamic> json) => _$ChartPointFromJson(json);
}

@freezed
class MovementShort with _$MovementShort {
  const factory MovementShort({
    required int id,
    required DateTime date,
    @JsonKey(name: 'item_name') required String itemName,
    required String type, // INCOME, OUTCOME
    required String quantity,
    @JsonKey(name: 'warehouse_name') required String warehouseName,
  }) = _MovementShort;
  
  factory MovementShort.fromJson(Map<String, dynamic> json) => _$MovementShortFromJson(json);
}