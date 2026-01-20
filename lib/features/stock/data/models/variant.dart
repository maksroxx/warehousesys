// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'variant.freezed.dart';
part 'variant.g.dart';

@freezed
class VariantFilter with _$VariantFilter {
  const factory VariantFilter({
    String? name,
    @Default(-1) int categoryId,
    @Default(-1) int warehouseId,
    
    @Default('all') String stockStatus,
    @Default(50) int limit,
    @Default(0) int offset,
  }) = _VariantFilter;

  factory VariantFilter.fromJson(Map<String, dynamic> json) =>
      _$VariantFilterFromJson(json);
}

extension VariantFilterX on VariantFilter {
  Map<String, dynamic> toQuery() {
    final map = <String, dynamic>{
      'name': name,
      'category_id': categoryId,
      'warehouse_id': warehouseId,
      'stock_status': stockStatus,
      'limit': limit,
      'offset': offset,
    };

    map.removeWhere((key, value) {
      if (key == 'category_id' || key == 'warehouse_id') {
        return value == -1;
      }
      return value == null || (value is String && value.isEmpty);
    });

    return map;
  }
}

@freezed
class ProductImage with _$ProductImage {
  const factory ProductImage({
    required int id,
    required String url,
  }) = _ProductImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);
}

@freezed
class InventoryItem with _$InventoryItem {
  const factory InventoryItem({
    required int id,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'product_name') required String productName,

    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'category_name') required String categoryName,

    required String sku,
    @JsonKey(name: 'unit_id') required int unitId,
    @JsonKey(name: 'unit_name') required String unitName,
    
    @JsonKey(name: 'quantity_on_stock', defaultValue: "0")
        required String quantityOnStock,

    final Map<String, String>? characteristics,
    
    @Default([]) List<ProductImage> images,
  }) = _InventoryItem;

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);
}