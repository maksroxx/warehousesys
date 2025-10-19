// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.freezed.dart';
part 'document.g.dart';

@freezed
class DocumentListItem with _$DocumentListItem {
  const factory DocumentListItem({
    required int id,
    required String type,
    required String number,
    @JsonKey(name: 'warehouse_name') String? warehouseName,
    @JsonKey(name: 'counterparty_name') String? counterpartyName,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'item_count', defaultValue: 0) required int totalItems,
     
  }) = _DocumentListItem;

  factory DocumentListItem.fromJson(Map<String, dynamic> json) => _$DocumentListItemFromJson(json);
}

@freezed
class DocumentFilter with _$DocumentFilter {
  const factory DocumentFilter({
    @Default(['INCOME', 'OUTCOME']) List<String> types,
    String? status, // draft, posted, canceled
    String? search,
    DateTime? dateFrom,
    DateTime? dateTo,
    @Default(20) int limit,
    @Default(0) int offset,
  }) = _DocumentFilter;
}