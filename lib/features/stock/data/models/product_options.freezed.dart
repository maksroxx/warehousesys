// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductOptionsDTO _$ProductOptionsDTOFromJson(Map<String, dynamic> json) {
  return _ProductOptionsDTO.fromJson(json);
}

/// @nodoc
mixin _$ProductOptionsDTO {
  ProductDetail get product => throw _privateConstructorUsedError;
  List<VariantDetail> get variants => throw _privateConstructorUsedError;
  List<Option> get options => throw _privateConstructorUsedError;

  /// Serializes this ProductOptionsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductOptionsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductOptionsDTOCopyWith<ProductOptionsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOptionsDTOCopyWith<$Res> {
  factory $ProductOptionsDTOCopyWith(
    ProductOptionsDTO value,
    $Res Function(ProductOptionsDTO) then,
  ) = _$ProductOptionsDTOCopyWithImpl<$Res, ProductOptionsDTO>;
  @useResult
  $Res call({
    ProductDetail product,
    List<VariantDetail> variants,
    List<Option> options,
  });

  $ProductDetailCopyWith<$Res> get product;
}

/// @nodoc
class _$ProductOptionsDTOCopyWithImpl<$Res, $Val extends ProductOptionsDTO>
    implements $ProductOptionsDTOCopyWith<$Res> {
  _$ProductOptionsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductOptionsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? variants = null,
    Object? options = null,
  }) {
    return _then(
      _value.copyWith(
            product: null == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as ProductDetail,
            variants: null == variants
                ? _value.variants
                : variants // ignore: cast_nullable_to_non_nullable
                      as List<VariantDetail>,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<Option>,
          )
          as $Val,
    );
  }

  /// Create a copy of ProductOptionsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductDetailCopyWith<$Res> get product {
    return $ProductDetailCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductOptionsDTOImplCopyWith<$Res>
    implements $ProductOptionsDTOCopyWith<$Res> {
  factory _$$ProductOptionsDTOImplCopyWith(
    _$ProductOptionsDTOImpl value,
    $Res Function(_$ProductOptionsDTOImpl) then,
  ) = __$$ProductOptionsDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ProductDetail product,
    List<VariantDetail> variants,
    List<Option> options,
  });

  @override
  $ProductDetailCopyWith<$Res> get product;
}

/// @nodoc
class __$$ProductOptionsDTOImplCopyWithImpl<$Res>
    extends _$ProductOptionsDTOCopyWithImpl<$Res, _$ProductOptionsDTOImpl>
    implements _$$ProductOptionsDTOImplCopyWith<$Res> {
  __$$ProductOptionsDTOImplCopyWithImpl(
    _$ProductOptionsDTOImpl _value,
    $Res Function(_$ProductOptionsDTOImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductOptionsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? variants = null,
    Object? options = null,
  }) {
    return _then(
      _$ProductOptionsDTOImpl(
        product: null == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as ProductDetail,
        variants: null == variants
            ? _value._variants
            : variants // ignore: cast_nullable_to_non_nullable
                  as List<VariantDetail>,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<Option>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOptionsDTOImpl implements _ProductOptionsDTO {
  const _$ProductOptionsDTOImpl({
    required this.product,
    final List<VariantDetail> variants = const [],
    final List<Option> options = const [],
  }) : _variants = variants,
       _options = options;

  factory _$ProductOptionsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductOptionsDTOImplFromJson(json);

  @override
  final ProductDetail product;
  final List<VariantDetail> _variants;
  @override
  @JsonKey()
  List<VariantDetail> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  final List<Option> _options;
  @override
  @JsonKey()
  List<Option> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'ProductOptionsDTO(product: $product, variants: $variants, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductOptionsDTOImpl &&
            (identical(other.product, product) || other.product == product) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    product,
    const DeepCollectionEquality().hash(_variants),
    const DeepCollectionEquality().hash(_options),
  );

  /// Create a copy of ProductOptionsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOptionsDTOImplCopyWith<_$ProductOptionsDTOImpl> get copyWith =>
      __$$ProductOptionsDTOImplCopyWithImpl<_$ProductOptionsDTOImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOptionsDTOImplToJson(this);
  }
}

abstract class _ProductOptionsDTO implements ProductOptionsDTO {
  const factory _ProductOptionsDTO({
    required final ProductDetail product,
    final List<VariantDetail> variants,
    final List<Option> options,
  }) = _$ProductOptionsDTOImpl;

  factory _ProductOptionsDTO.fromJson(Map<String, dynamic> json) =
      _$ProductOptionsDTOImpl.fromJson;

  @override
  ProductDetail get product;
  @override
  List<VariantDetail> get variants;
  @override
  List<Option> get options;

  /// Create a copy of ProductOptionsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductOptionsDTOImplCopyWith<_$ProductOptionsDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) {
  return _ProductDetail.fromJson(json);
}

/// @nodoc
mixin _$ProductDetail {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;

  /// Serializes this ProductDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductDetailCopyWith<ProductDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDetailCopyWith<$Res> {
  factory $ProductDetailCopyWith(
    ProductDetail value,
    $Res Function(ProductDetail) then,
  ) = _$ProductDetailCopyWithImpl<$Res, ProductDetail>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    @JsonKey(name: 'category_id') int categoryId,
  });
}

/// @nodoc
class _$ProductDetailCopyWithImpl<$Res, $Val extends ProductDetail>
    implements $ProductDetailCopyWith<$Res> {
  _$ProductDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? categoryId = null,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductDetailImplCopyWith<$Res>
    implements $ProductDetailCopyWith<$Res> {
  factory _$$ProductDetailImplCopyWith(
    _$ProductDetailImpl value,
    $Res Function(_$ProductDetailImpl) then,
  ) = __$$ProductDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    @JsonKey(name: 'category_id') int categoryId,
  });
}

/// @nodoc
class __$$ProductDetailImplCopyWithImpl<$Res>
    extends _$ProductDetailCopyWithImpl<$Res, _$ProductDetailImpl>
    implements _$$ProductDetailImplCopyWith<$Res> {
  __$$ProductDetailImplCopyWithImpl(
    _$ProductDetailImpl _value,
    $Res Function(_$ProductDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? categoryId = null,
  }) {
    return _then(
      _$ProductDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductDetailImpl implements _ProductDetail {
  const _$ProductDetailImpl({
    required this.id,
    required this.name,
    this.description,
    @JsonKey(name: 'category_id') required this.categoryId,
  });

  factory _$ProductDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'category_id')
  final int categoryId;

  @override
  String toString() {
    return 'ProductDetail(id: $id, name: $name, description: $description, categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, categoryId);

  /// Create a copy of ProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDetailImplCopyWith<_$ProductDetailImpl> get copyWith =>
      __$$ProductDetailImplCopyWithImpl<_$ProductDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductDetailImplToJson(this);
  }
}

abstract class _ProductDetail implements ProductDetail {
  const factory _ProductDetail({
    required final int id,
    required final String name,
    final String? description,
    @JsonKey(name: 'category_id') required final int categoryId,
  }) = _$ProductDetailImpl;

  factory _ProductDetail.fromJson(Map<String, dynamic> json) =
      _$ProductDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'category_id')
  int get categoryId;

  /// Create a copy of ProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductDetailImplCopyWith<_$ProductDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VariantDetail _$VariantDetailFromJson(Map<String, dynamic> json) {
  return _VariantDetail.fromJson(json);
}

/// @nodoc
mixin _$VariantDetail {
  int get id => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  Map<String, String>? get characteristics =>
      throw _privateConstructorUsedError;

  /// Serializes this VariantDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VariantDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VariantDetailCopyWith<VariantDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariantDetailCopyWith<$Res> {
  factory $VariantDetailCopyWith(
    VariantDetail value,
    $Res Function(VariantDetail) then,
  ) = _$VariantDetailCopyWithImpl<$Res, VariantDetail>;
  @useResult
  $Res call({int id, String sku, Map<String, String>? characteristics});
}

/// @nodoc
class _$VariantDetailCopyWithImpl<$Res, $Val extends VariantDetail>
    implements $VariantDetailCopyWith<$Res> {
  _$VariantDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VariantDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sku = null,
    Object? characteristics = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            sku: null == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                      as String,
            characteristics: freezed == characteristics
                ? _value.characteristics
                : characteristics // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VariantDetailImplCopyWith<$Res>
    implements $VariantDetailCopyWith<$Res> {
  factory _$$VariantDetailImplCopyWith(
    _$VariantDetailImpl value,
    $Res Function(_$VariantDetailImpl) then,
  ) = __$$VariantDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String sku, Map<String, String>? characteristics});
}

/// @nodoc
class __$$VariantDetailImplCopyWithImpl<$Res>
    extends _$VariantDetailCopyWithImpl<$Res, _$VariantDetailImpl>
    implements _$$VariantDetailImplCopyWith<$Res> {
  __$$VariantDetailImplCopyWithImpl(
    _$VariantDetailImpl _value,
    $Res Function(_$VariantDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VariantDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sku = null,
    Object? characteristics = freezed,
  }) {
    return _then(
      _$VariantDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        sku: null == sku
            ? _value.sku
            : sku // ignore: cast_nullable_to_non_nullable
                  as String,
        characteristics: freezed == characteristics
            ? _value._characteristics
            : characteristics // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VariantDetailImpl implements _VariantDetail {
  const _$VariantDetailImpl({
    required this.id,
    required this.sku,
    final Map<String, String>? characteristics,
  }) : _characteristics = characteristics;

  factory _$VariantDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariantDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String sku;
  final Map<String, String>? _characteristics;
  @override
  Map<String, String>? get characteristics {
    final value = _characteristics;
    if (value == null) return null;
    if (_characteristics is EqualUnmodifiableMapView) return _characteristics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'VariantDetail(id: $id, sku: $sku, characteristics: $characteristics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariantDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            const DeepCollectionEquality().equals(
              other._characteristics,
              _characteristics,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sku,
    const DeepCollectionEquality().hash(_characteristics),
  );

  /// Create a copy of VariantDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VariantDetailImplCopyWith<_$VariantDetailImpl> get copyWith =>
      __$$VariantDetailImplCopyWithImpl<_$VariantDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VariantDetailImplToJson(this);
  }
}

abstract class _VariantDetail implements VariantDetail {
  const factory _VariantDetail({
    required final int id,
    required final String sku,
    final Map<String, String>? characteristics,
  }) = _$VariantDetailImpl;

  factory _VariantDetail.fromJson(Map<String, dynamic> json) =
      _$VariantDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get sku;
  @override
  Map<String, String>? get characteristics;

  /// Create a copy of VariantDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VariantDetailImplCopyWith<_$VariantDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Option _$OptionFromJson(Map<String, dynamic> json) {
  return _Option.fromJson(json);
}

/// @nodoc
mixin _$Option {
  String get type => throw _privateConstructorUsedError;
  List<String> get values => throw _privateConstructorUsedError;

  /// Serializes this Option to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OptionCopyWith<Option> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionCopyWith<$Res> {
  factory $OptionCopyWith(Option value, $Res Function(Option) then) =
      _$OptionCopyWithImpl<$Res, Option>;
  @useResult
  $Res call({String type, List<String> values});
}

/// @nodoc
class _$OptionCopyWithImpl<$Res, $Val extends Option>
    implements $OptionCopyWith<$Res> {
  _$OptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? values = null}) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            values: null == values
                ? _value.values
                : values // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OptionImplCopyWith<$Res> implements $OptionCopyWith<$Res> {
  factory _$$OptionImplCopyWith(
    _$OptionImpl value,
    $Res Function(_$OptionImpl) then,
  ) = __$$OptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, List<String> values});
}

/// @nodoc
class __$$OptionImplCopyWithImpl<$Res>
    extends _$OptionCopyWithImpl<$Res, _$OptionImpl>
    implements _$$OptionImplCopyWith<$Res> {
  __$$OptionImplCopyWithImpl(
    _$OptionImpl _value,
    $Res Function(_$OptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? values = null}) {
    return _then(
      _$OptionImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        values: null == values
            ? _value._values
            : values // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OptionImpl implements _Option {
  const _$OptionImpl({required this.type, final List<String> values = const []})
    : _values = values;

  factory _$OptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$OptionImplFromJson(json);

  @override
  final String type;
  final List<String> _values;
  @override
  @JsonKey()
  List<String> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'Option(type: $type, values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    const DeepCollectionEquality().hash(_values),
  );

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionImplCopyWith<_$OptionImpl> get copyWith =>
      __$$OptionImplCopyWithImpl<_$OptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OptionImplToJson(this);
  }
}

abstract class _Option implements Option {
  const factory _Option({
    required final String type,
    final List<String> values,
  }) = _$OptionImpl;

  factory _Option.fromJson(Map<String, dynamic> json) = _$OptionImpl.fromJson;

  @override
  String get type;
  @override
  List<String> get values;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OptionImplCopyWith<_$OptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
