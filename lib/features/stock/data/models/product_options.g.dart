// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOptionsDTOImpl _$$ProductOptionsDTOImplFromJson(
  Map<String, dynamic> json,
) => _$ProductOptionsDTOImpl(
  product: ProductDetail.fromJson(json['product'] as Map<String, dynamic>),
  variants:
      (json['variants'] as List<dynamic>?)
          ?.map((e) => VariantDetail.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  options:
      (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$ProductOptionsDTOImplToJson(
  _$ProductOptionsDTOImpl instance,
) => <String, dynamic>{
  'product': instance.product,
  'variants': instance.variants,
  'options': instance.options,
};

_$ProductDetailImpl _$$ProductDetailImplFromJson(Map<String, dynamic> json) =>
    _$ProductDetailImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      categoryId: (json['category_id'] as num).toInt(),
    );

Map<String, dynamic> _$$ProductDetailImplToJson(_$ProductDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category_id': instance.categoryId,
    };

_$VariantDetailImpl _$$VariantDetailImplFromJson(Map<String, dynamic> json) =>
    _$VariantDetailImpl(
      id: (json['id'] as num).toInt(),
      sku: json['sku'] as String,
      characteristics: (json['characteristics'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$VariantDetailImplToJson(_$VariantDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'characteristics': instance.characteristics,
    };

_$OptionImpl _$$OptionImplFromJson(Map<String, dynamic> json) => _$OptionImpl(
  type: json['type'] as String,
  values:
      (json['values'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$OptionImplToJson(_$OptionImpl instance) =>
    <String, dynamic>{'type': instance.type, 'values': instance.values};
