// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) {
  return _DashboardData.fromJson(json);
}

/// @nodoc
mixin _$DashboardData {
  @JsonKey(name: 'total_stock')
  String get totalStock => throw _privateConstructorUsedError; // Новые метрики здоровья склада
  @JsonKey(name: 'total_variants')
  int get totalVariants => throw _privateConstructorUsedError;
  @JsonKey(name: 'items_in_stock')
  int get itemsInStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'low_stock_count')
  int get lowStockCount => throw _privateConstructorUsedError; // Общая активность
  @JsonKey(name: 'total_items_count')
  int get totalItemsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_operations')
  int get recentOperations => throw _privateConstructorUsedError; // Движения за сегодня
  @JsonKey(name: 'incoming_today')
  String get incomingToday => throw _privateConstructorUsedError;
  @JsonKey(name: 'outgoing_today')
  String get outgoingToday => throw _privateConstructorUsedError; // График и список
  @JsonKey(name: 'chart_data')
  List<ChartPoint> get chartData => throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_movements')
  List<MovementShort> get recentMovements => throw _privateConstructorUsedError;

  /// Serializes this DashboardData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardDataCopyWith<DashboardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardDataCopyWith<$Res> {
  factory $DashboardDataCopyWith(
    DashboardData value,
    $Res Function(DashboardData) then,
  ) = _$DashboardDataCopyWithImpl<$Res, DashboardData>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_stock') String totalStock,
    @JsonKey(name: 'total_variants') int totalVariants,
    @JsonKey(name: 'items_in_stock') int itemsInStock,
    @JsonKey(name: 'low_stock_count') int lowStockCount,
    @JsonKey(name: 'total_items_count') int totalItemsCount,
    @JsonKey(name: 'recent_operations') int recentOperations,
    @JsonKey(name: 'incoming_today') String incomingToday,
    @JsonKey(name: 'outgoing_today') String outgoingToday,
    @JsonKey(name: 'chart_data') List<ChartPoint> chartData,
    @JsonKey(name: 'recent_movements') List<MovementShort> recentMovements,
  });
}

/// @nodoc
class _$DashboardDataCopyWithImpl<$Res, $Val extends DashboardData>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalStock = null,
    Object? totalVariants = null,
    Object? itemsInStock = null,
    Object? lowStockCount = null,
    Object? totalItemsCount = null,
    Object? recentOperations = null,
    Object? incomingToday = null,
    Object? outgoingToday = null,
    Object? chartData = null,
    Object? recentMovements = null,
  }) {
    return _then(
      _value.copyWith(
            totalStock: null == totalStock
                ? _value.totalStock
                : totalStock // ignore: cast_nullable_to_non_nullable
                      as String,
            totalVariants: null == totalVariants
                ? _value.totalVariants
                : totalVariants // ignore: cast_nullable_to_non_nullable
                      as int,
            itemsInStock: null == itemsInStock
                ? _value.itemsInStock
                : itemsInStock // ignore: cast_nullable_to_non_nullable
                      as int,
            lowStockCount: null == lowStockCount
                ? _value.lowStockCount
                : lowStockCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalItemsCount: null == totalItemsCount
                ? _value.totalItemsCount
                : totalItemsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            recentOperations: null == recentOperations
                ? _value.recentOperations
                : recentOperations // ignore: cast_nullable_to_non_nullable
                      as int,
            incomingToday: null == incomingToday
                ? _value.incomingToday
                : incomingToday // ignore: cast_nullable_to_non_nullable
                      as String,
            outgoingToday: null == outgoingToday
                ? _value.outgoingToday
                : outgoingToday // ignore: cast_nullable_to_non_nullable
                      as String,
            chartData: null == chartData
                ? _value.chartData
                : chartData // ignore: cast_nullable_to_non_nullable
                      as List<ChartPoint>,
            recentMovements: null == recentMovements
                ? _value.recentMovements
                : recentMovements // ignore: cast_nullable_to_non_nullable
                      as List<MovementShort>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardDataImplCopyWith<$Res>
    implements $DashboardDataCopyWith<$Res> {
  factory _$$DashboardDataImplCopyWith(
    _$DashboardDataImpl value,
    $Res Function(_$DashboardDataImpl) then,
  ) = __$$DashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_stock') String totalStock,
    @JsonKey(name: 'total_variants') int totalVariants,
    @JsonKey(name: 'items_in_stock') int itemsInStock,
    @JsonKey(name: 'low_stock_count') int lowStockCount,
    @JsonKey(name: 'total_items_count') int totalItemsCount,
    @JsonKey(name: 'recent_operations') int recentOperations,
    @JsonKey(name: 'incoming_today') String incomingToday,
    @JsonKey(name: 'outgoing_today') String outgoingToday,
    @JsonKey(name: 'chart_data') List<ChartPoint> chartData,
    @JsonKey(name: 'recent_movements') List<MovementShort> recentMovements,
  });
}

/// @nodoc
class __$$DashboardDataImplCopyWithImpl<$Res>
    extends _$DashboardDataCopyWithImpl<$Res, _$DashboardDataImpl>
    implements _$$DashboardDataImplCopyWith<$Res> {
  __$$DashboardDataImplCopyWithImpl(
    _$DashboardDataImpl _value,
    $Res Function(_$DashboardDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalStock = null,
    Object? totalVariants = null,
    Object? itemsInStock = null,
    Object? lowStockCount = null,
    Object? totalItemsCount = null,
    Object? recentOperations = null,
    Object? incomingToday = null,
    Object? outgoingToday = null,
    Object? chartData = null,
    Object? recentMovements = null,
  }) {
    return _then(
      _$DashboardDataImpl(
        totalStock: null == totalStock
            ? _value.totalStock
            : totalStock // ignore: cast_nullable_to_non_nullable
                  as String,
        totalVariants: null == totalVariants
            ? _value.totalVariants
            : totalVariants // ignore: cast_nullable_to_non_nullable
                  as int,
        itemsInStock: null == itemsInStock
            ? _value.itemsInStock
            : itemsInStock // ignore: cast_nullable_to_non_nullable
                  as int,
        lowStockCount: null == lowStockCount
            ? _value.lowStockCount
            : lowStockCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalItemsCount: null == totalItemsCount
            ? _value.totalItemsCount
            : totalItemsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        recentOperations: null == recentOperations
            ? _value.recentOperations
            : recentOperations // ignore: cast_nullable_to_non_nullable
                  as int,
        incomingToday: null == incomingToday
            ? _value.incomingToday
            : incomingToday // ignore: cast_nullable_to_non_nullable
                  as String,
        outgoingToday: null == outgoingToday
            ? _value.outgoingToday
            : outgoingToday // ignore: cast_nullable_to_non_nullable
                  as String,
        chartData: null == chartData
            ? _value._chartData
            : chartData // ignore: cast_nullable_to_non_nullable
                  as List<ChartPoint>,
        recentMovements: null == recentMovements
            ? _value._recentMovements
            : recentMovements // ignore: cast_nullable_to_non_nullable
                  as List<MovementShort>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardDataImpl implements _DashboardData {
  const _$DashboardDataImpl({
    @JsonKey(name: 'total_stock') required this.totalStock,
    @JsonKey(name: 'total_variants') required this.totalVariants,
    @JsonKey(name: 'items_in_stock') required this.itemsInStock,
    @JsonKey(name: 'low_stock_count') required this.lowStockCount,
    @JsonKey(name: 'total_items_count') required this.totalItemsCount,
    @JsonKey(name: 'recent_operations') required this.recentOperations,
    @JsonKey(name: 'incoming_today') required this.incomingToday,
    @JsonKey(name: 'outgoing_today') required this.outgoingToday,
    @JsonKey(name: 'chart_data') final List<ChartPoint> chartData = const [],
    @JsonKey(name: 'recent_movements')
    final List<MovementShort> recentMovements = const [],
  }) : _chartData = chartData,
       _recentMovements = recentMovements;

  factory _$DashboardDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardDataImplFromJson(json);

  @override
  @JsonKey(name: 'total_stock')
  final String totalStock;
  // Новые метрики здоровья склада
  @override
  @JsonKey(name: 'total_variants')
  final int totalVariants;
  @override
  @JsonKey(name: 'items_in_stock')
  final int itemsInStock;
  @override
  @JsonKey(name: 'low_stock_count')
  final int lowStockCount;
  // Общая активность
  @override
  @JsonKey(name: 'total_items_count')
  final int totalItemsCount;
  @override
  @JsonKey(name: 'recent_operations')
  final int recentOperations;
  // Движения за сегодня
  @override
  @JsonKey(name: 'incoming_today')
  final String incomingToday;
  @override
  @JsonKey(name: 'outgoing_today')
  final String outgoingToday;
  // График и список
  final List<ChartPoint> _chartData;
  // График и список
  @override
  @JsonKey(name: 'chart_data')
  List<ChartPoint> get chartData {
    if (_chartData is EqualUnmodifiableListView) return _chartData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chartData);
  }

  final List<MovementShort> _recentMovements;
  @override
  @JsonKey(name: 'recent_movements')
  List<MovementShort> get recentMovements {
    if (_recentMovements is EqualUnmodifiableListView) return _recentMovements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentMovements);
  }

  @override
  String toString() {
    return 'DashboardData(totalStock: $totalStock, totalVariants: $totalVariants, itemsInStock: $itemsInStock, lowStockCount: $lowStockCount, totalItemsCount: $totalItemsCount, recentOperations: $recentOperations, incomingToday: $incomingToday, outgoingToday: $outgoingToday, chartData: $chartData, recentMovements: $recentMovements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardDataImpl &&
            (identical(other.totalStock, totalStock) ||
                other.totalStock == totalStock) &&
            (identical(other.totalVariants, totalVariants) ||
                other.totalVariants == totalVariants) &&
            (identical(other.itemsInStock, itemsInStock) ||
                other.itemsInStock == itemsInStock) &&
            (identical(other.lowStockCount, lowStockCount) ||
                other.lowStockCount == lowStockCount) &&
            (identical(other.totalItemsCount, totalItemsCount) ||
                other.totalItemsCount == totalItemsCount) &&
            (identical(other.recentOperations, recentOperations) ||
                other.recentOperations == recentOperations) &&
            (identical(other.incomingToday, incomingToday) ||
                other.incomingToday == incomingToday) &&
            (identical(other.outgoingToday, outgoingToday) ||
                other.outgoingToday == outgoingToday) &&
            const DeepCollectionEquality().equals(
              other._chartData,
              _chartData,
            ) &&
            const DeepCollectionEquality().equals(
              other._recentMovements,
              _recentMovements,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalStock,
    totalVariants,
    itemsInStock,
    lowStockCount,
    totalItemsCount,
    recentOperations,
    incomingToday,
    outgoingToday,
    const DeepCollectionEquality().hash(_chartData),
    const DeepCollectionEquality().hash(_recentMovements),
  );

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardDataImplCopyWith<_$DashboardDataImpl> get copyWith =>
      __$$DashboardDataImplCopyWithImpl<_$DashboardDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardDataImplToJson(this);
  }
}

abstract class _DashboardData implements DashboardData {
  const factory _DashboardData({
    @JsonKey(name: 'total_stock') required final String totalStock,
    @JsonKey(name: 'total_variants') required final int totalVariants,
    @JsonKey(name: 'items_in_stock') required final int itemsInStock,
    @JsonKey(name: 'low_stock_count') required final int lowStockCount,
    @JsonKey(name: 'total_items_count') required final int totalItemsCount,
    @JsonKey(name: 'recent_operations') required final int recentOperations,
    @JsonKey(name: 'incoming_today') required final String incomingToday,
    @JsonKey(name: 'outgoing_today') required final String outgoingToday,
    @JsonKey(name: 'chart_data') final List<ChartPoint> chartData,
    @JsonKey(name: 'recent_movements')
    final List<MovementShort> recentMovements,
  }) = _$DashboardDataImpl;

  factory _DashboardData.fromJson(Map<String, dynamic> json) =
      _$DashboardDataImpl.fromJson;

  @override
  @JsonKey(name: 'total_stock')
  String get totalStock; // Новые метрики здоровья склада
  @override
  @JsonKey(name: 'total_variants')
  int get totalVariants;
  @override
  @JsonKey(name: 'items_in_stock')
  int get itemsInStock;
  @override
  @JsonKey(name: 'low_stock_count')
  int get lowStockCount; // Общая активность
  @override
  @JsonKey(name: 'total_items_count')
  int get totalItemsCount;
  @override
  @JsonKey(name: 'recent_operations')
  int get recentOperations; // Движения за сегодня
  @override
  @JsonKey(name: 'incoming_today')
  String get incomingToday;
  @override
  @JsonKey(name: 'outgoing_today')
  String get outgoingToday; // График и список
  @override
  @JsonKey(name: 'chart_data')
  List<ChartPoint> get chartData;
  @override
  @JsonKey(name: 'recent_movements')
  List<MovementShort> get recentMovements;

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardDataImplCopyWith<_$DashboardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChartPoint _$ChartPointFromJson(Map<String, dynamic> json) {
  return _ChartPoint.fromJson(json);
}

/// @nodoc
mixin _$ChartPoint {
  String get date => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this ChartPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartPointCopyWith<ChartPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartPointCopyWith<$Res> {
  factory $ChartPointCopyWith(
    ChartPoint value,
    $Res Function(ChartPoint) then,
  ) = _$ChartPointCopyWithImpl<$Res, ChartPoint>;
  @useResult
  $Res call({String date, String value, String type});
}

/// @nodoc
class _$ChartPointCopyWithImpl<$Res, $Val extends ChartPoint>
    implements $ChartPointCopyWith<$Res> {
  _$ChartPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? value = null, Object? type = null}) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChartPointImplCopyWith<$Res>
    implements $ChartPointCopyWith<$Res> {
  factory _$$ChartPointImplCopyWith(
    _$ChartPointImpl value,
    $Res Function(_$ChartPointImpl) then,
  ) = __$$ChartPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, String value, String type});
}

/// @nodoc
class __$$ChartPointImplCopyWithImpl<$Res>
    extends _$ChartPointCopyWithImpl<$Res, _$ChartPointImpl>
    implements _$$ChartPointImplCopyWith<$Res> {
  __$$ChartPointImplCopyWithImpl(
    _$ChartPointImpl _value,
    $Res Function(_$ChartPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? value = null, Object? type = null}) {
    return _then(
      _$ChartPointImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChartPointImpl implements _ChartPoint {
  const _$ChartPointImpl({
    required this.date,
    required this.value,
    required this.type,
  });

  factory _$ChartPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChartPointImplFromJson(json);

  @override
  final String date;
  @override
  final String value;
  @override
  final String type;

  @override
  String toString() {
    return 'ChartPoint(date: $date, value: $value, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartPointImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, value, type);

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartPointImplCopyWith<_$ChartPointImpl> get copyWith =>
      __$$ChartPointImplCopyWithImpl<_$ChartPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChartPointImplToJson(this);
  }
}

abstract class _ChartPoint implements ChartPoint {
  const factory _ChartPoint({
    required final String date,
    required final String value,
    required final String type,
  }) = _$ChartPointImpl;

  factory _ChartPoint.fromJson(Map<String, dynamic> json) =
      _$ChartPointImpl.fromJson;

  @override
  String get date;
  @override
  String get value;
  @override
  String get type;

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartPointImplCopyWith<_$ChartPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MovementShort _$MovementShortFromJson(Map<String, dynamic> json) {
  return _MovementShort.fromJson(json);
}

/// @nodoc
mixin _$MovementShort {
  int get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_name')
  String get itemName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError; // INCOME, OUTCOME
  String get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_name')
  String get warehouseName => throw _privateConstructorUsedError;

  /// Serializes this MovementShort to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovementShort
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovementShortCopyWith<MovementShort> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovementShortCopyWith<$Res> {
  factory $MovementShortCopyWith(
    MovementShort value,
    $Res Function(MovementShort) then,
  ) = _$MovementShortCopyWithImpl<$Res, MovementShort>;
  @useResult
  $Res call({
    int id,
    DateTime date,
    @JsonKey(name: 'item_name') String itemName,
    String type,
    String quantity,
    @JsonKey(name: 'warehouse_name') String warehouseName,
  });
}

/// @nodoc
class _$MovementShortCopyWithImpl<$Res, $Val extends MovementShort>
    implements $MovementShortCopyWith<$Res> {
  _$MovementShortCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovementShort
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? itemName = null,
    Object? type = null,
    Object? quantity = null,
    Object? warehouseName = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            itemName: null == itemName
                ? _value.itemName
                : itemName // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as String,
            warehouseName: null == warehouseName
                ? _value.warehouseName
                : warehouseName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MovementShortImplCopyWith<$Res>
    implements $MovementShortCopyWith<$Res> {
  factory _$$MovementShortImplCopyWith(
    _$MovementShortImpl value,
    $Res Function(_$MovementShortImpl) then,
  ) = __$$MovementShortImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    DateTime date,
    @JsonKey(name: 'item_name') String itemName,
    String type,
    String quantity,
    @JsonKey(name: 'warehouse_name') String warehouseName,
  });
}

/// @nodoc
class __$$MovementShortImplCopyWithImpl<$Res>
    extends _$MovementShortCopyWithImpl<$Res, _$MovementShortImpl>
    implements _$$MovementShortImplCopyWith<$Res> {
  __$$MovementShortImplCopyWithImpl(
    _$MovementShortImpl _value,
    $Res Function(_$MovementShortImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovementShort
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? itemName = null,
    Object? type = null,
    Object? quantity = null,
    Object? warehouseName = null,
  }) {
    return _then(
      _$MovementShortImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        itemName: null == itemName
            ? _value.itemName
            : itemName // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as String,
        warehouseName: null == warehouseName
            ? _value.warehouseName
            : warehouseName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MovementShortImpl implements _MovementShort {
  const _$MovementShortImpl({
    required this.id,
    required this.date,
    @JsonKey(name: 'item_name') required this.itemName,
    required this.type,
    required this.quantity,
    @JsonKey(name: 'warehouse_name') required this.warehouseName,
  });

  factory _$MovementShortImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovementShortImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime date;
  @override
  @JsonKey(name: 'item_name')
  final String itemName;
  @override
  final String type;
  // INCOME, OUTCOME
  @override
  final String quantity;
  @override
  @JsonKey(name: 'warehouse_name')
  final String warehouseName;

  @override
  String toString() {
    return 'MovementShort(id: $id, date: $date, itemName: $itemName, type: $type, quantity: $quantity, warehouseName: $warehouseName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovementShortImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.warehouseName, warehouseName) ||
                other.warehouseName == warehouseName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    itemName,
    type,
    quantity,
    warehouseName,
  );

  /// Create a copy of MovementShort
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovementShortImplCopyWith<_$MovementShortImpl> get copyWith =>
      __$$MovementShortImplCopyWithImpl<_$MovementShortImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovementShortImplToJson(this);
  }
}

abstract class _MovementShort implements MovementShort {
  const factory _MovementShort({
    required final int id,
    required final DateTime date,
    @JsonKey(name: 'item_name') required final String itemName,
    required final String type,
    required final String quantity,
    @JsonKey(name: 'warehouse_name') required final String warehouseName,
  }) = _$MovementShortImpl;

  factory _MovementShort.fromJson(Map<String, dynamic> json) =
      _$MovementShortImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get date;
  @override
  @JsonKey(name: 'item_name')
  String get itemName;
  @override
  String get type; // INCOME, OUTCOME
  @override
  String get quantity;
  @override
  @JsonKey(name: 'warehouse_name')
  String get warehouseName;

  /// Create a copy of MovementShort
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovementShortImplCopyWith<_$MovementShortImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
