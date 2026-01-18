// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'filters.freezed.dart';
part 'filters.g.dart';

// GET /categories
@freezed
class Category with _$Category {
  const factory Category({
    required int id,
    required String name,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}

// GET /warehouses
@freezed
class Warehouse with _$Warehouse {
  const factory Warehouse({
    required int id,
    required String name,
  }) = _Warehouse;

  factory Warehouse.fromJson(Map<String, dynamic> json) => _$WarehouseFromJson(json);
}

// GET /products
@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    String? description,
    @JsonKey(name: 'category_id') int? categoryId,
    @Default([]) List<ProductImage> images, 
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
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
class CharacteristicType with _$CharacteristicType {
  const factory CharacteristicType({
    required int id,
    required String name,
  }) = _CharacteristicType;
  factory CharacteristicType.fromJson(Map<String, dynamic> json) => _$CharacteristicTypeFromJson(json);
}

enum StockStatus {
  all(displayName: 'Все', value: 'all'),
  inStock(displayName: 'В наличии', value: 'in_stock'),
  outOfStock(displayName: 'Не в наличии', value: 'out_of_stock');

  const StockStatus({required this.displayName, required this.value});
  final String displayName;
  final String value;
}

@freezed
class Unit with _$Unit {
  const factory Unit({
    required int id,
    required String name,
  }) = _Unit;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
}