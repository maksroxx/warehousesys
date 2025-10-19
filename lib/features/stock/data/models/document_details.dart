// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_details.freezed.dart';
part 'document_details.g.dart';

@freezed
class DocumentDetailsDTO with _$DocumentDetailsDTO {
  const factory DocumentDetailsDTO({
    required int id,
    required String type,
    required String number,
    @JsonKey(name: 'warehouse_id') int? warehouseId,
    @JsonKey(name: 'warehouse_name') String? warehouseName,
    String? comment,
    @Default([]) List<DocumentItemDTO> items,
    required String status,
    @JsonKey(name: 'posted_at') DateTime? postedAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'counterparty_name') String? counterpartyName,
  }) = _DocumentDetailsDTO;

  factory DocumentDetailsDTO.fromJson(Map<String, dynamic> json) => _$DocumentDetailsDTOFromJson(json);
}

@freezed
class DocumentItemDTO with _$DocumentItemDTO {
  const factory DocumentItemDTO({
    required int id,
    @JsonKey(name: 'variant_id') required int variantId,
    @JsonKey(name: 'variant_sku') required String variantSku,
    @JsonKey(name: 'product_name') required String productName,
    required String quantity,
    String? price,
  }) = _DocumentItemDTO;

  factory DocumentItemDTO.fromJson(Map<String, dynamic> json) => _$DocumentItemDTOFromJson(json);
}