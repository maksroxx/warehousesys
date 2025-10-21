// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counterparty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CounterpartyImpl _$$CounterpartyImplFromJson(Map<String, dynamic> json) =>
    _$CounterpartyImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String?,
      telegram: json['telegram'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$CounterpartyImplToJson(_$CounterpartyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'telegram': instance.telegram,
      'email': instance.email,
      'address': instance.address,
    };
