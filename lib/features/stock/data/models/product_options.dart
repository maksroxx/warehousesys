// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_options.freezed.dart';
part 'product_options.g.dart';

@freezed
class ProductOptionsDTO with _$ProductOptionsDTO {
  const factory ProductOptionsDTO({
    required ProductDetail product,
    @Default([]) List<VariantDetail> variants,
    @Default([]) List<Option> options,
  }) = _ProductOptionsDTO;

  factory ProductOptionsDTO.fromJson(Map<String, dynamic> json) => _$ProductOptionsDTOFromJson(json);
}

@freezed
class ProductDetail with _$ProductDetail {
  const factory ProductDetail({
    required int id,
    required String name,
    String? description,
    @JsonKey(name: 'category_id') required int categoryId,
  }) = _ProductDetail;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => _$ProductDetailFromJson(json);
}

@freezed
class VariantDetail with _$VariantDetail {
  const factory VariantDetail({
    required int id,
    required String sku,
    Map<String, String>? characteristics,
  }) = _VariantDetail;

  factory VariantDetail.fromJson(Map<String, dynamic> json) => _$VariantDetailFromJson(json);
}

@freezed
class Option with _$Option {
  const factory Option({
    required String type,
    @Default([]) List<String> values,
  }) = _Option;

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}