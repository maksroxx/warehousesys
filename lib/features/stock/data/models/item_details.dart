// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_details.freezed.dart';
part 'item_details.g.dart';

// GET /variants/:id/stock
@freezed
class VariantStock with _$VariantStock {
  const factory VariantStock({
    @JsonKey(name: 'warehouse_id') required int warehouseId,
    @JsonKey(name: 'warehouse_name') required String warehouseName,
    @JsonKey(name: 'on_hand') required String onHand,
    required String reserved,
    required String available,
  }) = _VariantStock;

  factory VariantStock.fromJson(Map<String, dynamic> json) => _$VariantStockFromJson(json);
}

// GET /movements
@freezed
class StockMovement with _$StockMovement {
  const factory StockMovement({
    required int id,
    @JsonKey(name: 'document_id') int? documentId,
    @JsonKey(name: 'document_number') String? documentNumber,
    @JsonKey(name: 'variant_sku') required String variantSku,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'warehouse_name') required String warehouseName,
    required String quantity,
    required String type, // "INCOME", "OUTCOME"
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _StockMovement;

  factory StockMovement.fromJson(Map<String, dynamic> json) => _$StockMovementFromJson(json);
}