// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'counterparty.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Counterparty _$CounterpartyFromJson(Map<String, dynamic> json) {
  return _Counterparty.fromJson(json);
}

/// @nodoc
mixin _$Counterparty {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get telegram => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  /// Serializes this Counterparty to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Counterparty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CounterpartyCopyWith<Counterparty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterpartyCopyWith<$Res> {
  factory $CounterpartyCopyWith(
    Counterparty value,
    $Res Function(Counterparty) then,
  ) = _$CounterpartyCopyWithImpl<$Res, Counterparty>;
  @useResult
  $Res call({
    int id,
    String name,
    String? phone,
    String? telegram,
    String? email,
    String? address,
  });
}

/// @nodoc
class _$CounterpartyCopyWithImpl<$Res, $Val extends Counterparty>
    implements $CounterpartyCopyWith<$Res> {
  _$CounterpartyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Counterparty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? telegram = freezed,
    Object? email = freezed,
    Object? address = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            telegram: freezed == telegram
                ? _value.telegram
                : telegram // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CounterpartyImplCopyWith<$Res>
    implements $CounterpartyCopyWith<$Res> {
  factory _$$CounterpartyImplCopyWith(
    _$CounterpartyImpl value,
    $Res Function(_$CounterpartyImpl) then,
  ) = __$$CounterpartyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? phone,
    String? telegram,
    String? email,
    String? address,
  });
}

/// @nodoc
class __$$CounterpartyImplCopyWithImpl<$Res>
    extends _$CounterpartyCopyWithImpl<$Res, _$CounterpartyImpl>
    implements _$$CounterpartyImplCopyWith<$Res> {
  __$$CounterpartyImplCopyWithImpl(
    _$CounterpartyImpl _value,
    $Res Function(_$CounterpartyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Counterparty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? telegram = freezed,
    Object? email = freezed,
    Object? address = freezed,
  }) {
    return _then(
      _$CounterpartyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        telegram: freezed == telegram
            ? _value.telegram
            : telegram // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CounterpartyImpl implements _Counterparty {
  const _$CounterpartyImpl({
    required this.id,
    required this.name,
    this.phone,
    this.telegram,
    this.email,
    this.address,
  });

  factory _$CounterpartyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CounterpartyImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? phone;
  @override
  final String? telegram;
  @override
  final String? email;
  @override
  final String? address;

  @override
  String toString() {
    return 'Counterparty(id: $id, name: $name, phone: $phone, telegram: $telegram, email: $email, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CounterpartyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.telegram, telegram) ||
                other.telegram == telegram) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, phone, telegram, email, address);

  /// Create a copy of Counterparty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CounterpartyImplCopyWith<_$CounterpartyImpl> get copyWith =>
      __$$CounterpartyImplCopyWithImpl<_$CounterpartyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CounterpartyImplToJson(this);
  }
}

abstract class _Counterparty implements Counterparty {
  const factory _Counterparty({
    required final int id,
    required final String name,
    final String? phone,
    final String? telegram,
    final String? email,
    final String? address,
  }) = _$CounterpartyImpl;

  factory _Counterparty.fromJson(Map<String, dynamic> json) =
      _$CounterpartyImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get phone;
  @override
  String? get telegram;
  @override
  String? get email;
  @override
  String? get address;

  /// Create a copy of Counterparty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CounterpartyImplCopyWith<_$CounterpartyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CounterpartyFilter {
  String? get search => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;

  /// Create a copy of CounterpartyFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CounterpartyFilterCopyWith<CounterpartyFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterpartyFilterCopyWith<$Res> {
  factory $CounterpartyFilterCopyWith(
    CounterpartyFilter value,
    $Res Function(CounterpartyFilter) then,
  ) = _$CounterpartyFilterCopyWithImpl<$Res, CounterpartyFilter>;
  @useResult
  $Res call({String? search, int limit, int offset});
}

/// @nodoc
class _$CounterpartyFilterCopyWithImpl<$Res, $Val extends CounterpartyFilter>
    implements $CounterpartyFilterCopyWith<$Res> {
  _$CounterpartyFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CounterpartyFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? search = freezed,
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(
      _value.copyWith(
            search: freezed == search
                ? _value.search
                : search // ignore: cast_nullable_to_non_nullable
                      as String?,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CounterpartyFilterImplCopyWith<$Res>
    implements $CounterpartyFilterCopyWith<$Res> {
  factory _$$CounterpartyFilterImplCopyWith(
    _$CounterpartyFilterImpl value,
    $Res Function(_$CounterpartyFilterImpl) then,
  ) = __$$CounterpartyFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? search, int limit, int offset});
}

/// @nodoc
class __$$CounterpartyFilterImplCopyWithImpl<$Res>
    extends _$CounterpartyFilterCopyWithImpl<$Res, _$CounterpartyFilterImpl>
    implements _$$CounterpartyFilterImplCopyWith<$Res> {
  __$$CounterpartyFilterImplCopyWithImpl(
    _$CounterpartyFilterImpl _value,
    $Res Function(_$CounterpartyFilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CounterpartyFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? search = freezed,
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(
      _$CounterpartyFilterImpl(
        search: freezed == search
            ? _value.search
            : search // ignore: cast_nullable_to_non_nullable
                  as String?,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$CounterpartyFilterImpl implements _CounterpartyFilter {
  const _$CounterpartyFilterImpl({
    this.search,
    this.limit = 20,
    this.offset = 0,
  });

  @override
  final String? search;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int offset;

  @override
  String toString() {
    return 'CounterpartyFilter(search: $search, limit: $limit, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CounterpartyFilterImpl &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(runtimeType, search, limit, offset);

  /// Create a copy of CounterpartyFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CounterpartyFilterImplCopyWith<_$CounterpartyFilterImpl> get copyWith =>
      __$$CounterpartyFilterImplCopyWithImpl<_$CounterpartyFilterImpl>(
        this,
        _$identity,
      );
}

abstract class _CounterpartyFilter implements CounterpartyFilter {
  const factory _CounterpartyFilter({
    final String? search,
    final int limit,
    final int offset,
  }) = _$CounterpartyFilterImpl;

  @override
  String? get search;
  @override
  int get limit;
  @override
  int get offset;

  /// Create a copy of CounterpartyFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CounterpartyFilterImplCopyWith<_$CounterpartyFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
