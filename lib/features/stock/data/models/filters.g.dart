// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$WarehouseImpl _$$WarehouseImplFromJson(Map<String, dynamic> json) =>
    _$WarehouseImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$WarehouseImplToJson(_$WarehouseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
    };

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category_id': instance.categoryId,
      'images': instance.images,
    };

_$ProductImageImpl _$$ProductImageImplFromJson(Map<String, dynamic> json) =>
    _$ProductImageImpl(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$$ProductImageImplToJson(_$ProductImageImpl instance) =>
    <String, dynamic>{'id': instance.id, 'url': instance.url};

_$CharacteristicTypeImpl _$$CharacteristicTypeImplFromJson(
  Map<String, dynamic> json,
) => _$CharacteristicTypeImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$$CharacteristicTypeImplToJson(
  _$CharacteristicTypeImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$UnitImpl _$$UnitImplFromJson(Map<String, dynamic> json) =>
    _$UnitImpl(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$$UnitImplToJson(_$UnitImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
