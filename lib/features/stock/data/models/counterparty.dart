import 'package:freezed_annotation/freezed_annotation.dart';

part 'counterparty.freezed.dart';
part 'counterparty.g.dart';

@freezed
class Counterparty with _$Counterparty {
  const factory Counterparty({
    required int id,
    required String name,
    String? phone,
    String? telegram,
    String? email,
    String? address,
  }) = _Counterparty;

  factory Counterparty.fromJson(Map<String, dynamic> json) =>
      _$CounterpartyFromJson(json);
}

@freezed
class CounterpartyFilter with _$CounterpartyFilter {
  const factory CounterpartyFilter({
    String? search,
    @Default(20) int limit,
    @Default(0) int offset,
  }) = _CounterpartyFilter;
}
