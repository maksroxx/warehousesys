// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$InventoryState {
  List<InventoryItem> get items => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  bool get isLoadingFirstPage => throw _privateConstructorUsedError;
  bool get isLoadingNextPage => throw _privateConstructorUsedError;

  /// Create a copy of InventoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryStateCopyWith<InventoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryStateCopyWith<$Res> {
  factory $InventoryStateCopyWith(
    InventoryState value,
    $Res Function(InventoryState) then,
  ) = _$InventoryStateCopyWithImpl<$Res, InventoryState>;
  @useResult
  $Res call({
    List<InventoryItem> items,
    bool hasMore,
    int offset,
    Object? error,
    bool isLoadingFirstPage,
    bool isLoadingNextPage,
  });
}

/// @nodoc
class _$InventoryStateCopyWithImpl<$Res, $Val extends InventoryState>
    implements $InventoryStateCopyWith<$Res> {
  _$InventoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
    Object? offset = null,
    Object? error = freezed,
    Object? isLoadingFirstPage = null,
    Object? isLoadingNextPage = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<InventoryItem>,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as int,
            error: freezed == error ? _value.error : error,
            isLoadingFirstPage: null == isLoadingFirstPage
                ? _value.isLoadingFirstPage
                : isLoadingFirstPage // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingNextPage: null == isLoadingNextPage
                ? _value.isLoadingNextPage
                : isLoadingNextPage // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryStateImplCopyWith<$Res>
    implements $InventoryStateCopyWith<$Res> {
  factory _$$InventoryStateImplCopyWith(
    _$InventoryStateImpl value,
    $Res Function(_$InventoryStateImpl) then,
  ) = __$$InventoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<InventoryItem> items,
    bool hasMore,
    int offset,
    Object? error,
    bool isLoadingFirstPage,
    bool isLoadingNextPage,
  });
}

/// @nodoc
class __$$InventoryStateImplCopyWithImpl<$Res>
    extends _$InventoryStateCopyWithImpl<$Res, _$InventoryStateImpl>
    implements _$$InventoryStateImplCopyWith<$Res> {
  __$$InventoryStateImplCopyWithImpl(
    _$InventoryStateImpl _value,
    $Res Function(_$InventoryStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
    Object? offset = null,
    Object? error = freezed,
    Object? isLoadingFirstPage = null,
    Object? isLoadingNextPage = null,
  }) {
    return _then(
      _$InventoryStateImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<InventoryItem>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
        error: freezed == error ? _value.error : error,
        isLoadingFirstPage: null == isLoadingFirstPage
            ? _value.isLoadingFirstPage
            : isLoadingFirstPage // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingNextPage: null == isLoadingNextPage
            ? _value.isLoadingNextPage
            : isLoadingNextPage // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$InventoryStateImpl implements _InventoryState {
  const _$InventoryStateImpl({
    final List<InventoryItem> items = const [],
    this.hasMore = true,
    this.offset = 0,
    this.error,
    this.isLoadingFirstPage = false,
    this.isLoadingNextPage = false,
  }) : _items = items;

  final List<InventoryItem> _items;
  @override
  @JsonKey()
  List<InventoryItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final int offset;
  @override
  final Object? error;
  @override
  @JsonKey()
  final bool isLoadingFirstPage;
  @override
  @JsonKey()
  final bool isLoadingNextPage;

  @override
  String toString() {
    return 'InventoryState(items: $items, hasMore: $hasMore, offset: $offset, error: $error, isLoadingFirstPage: $isLoadingFirstPage, isLoadingNextPage: $isLoadingNextPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.isLoadingFirstPage, isLoadingFirstPage) ||
                other.isLoadingFirstPage == isLoadingFirstPage) &&
            (identical(other.isLoadingNextPage, isLoadingNextPage) ||
                other.isLoadingNextPage == isLoadingNextPage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    hasMore,
    offset,
    const DeepCollectionEquality().hash(error),
    isLoadingFirstPage,
    isLoadingNextPage,
  );

  /// Create a copy of InventoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryStateImplCopyWith<_$InventoryStateImpl> get copyWith =>
      __$$InventoryStateImplCopyWithImpl<_$InventoryStateImpl>(
        this,
        _$identity,
      );
}

abstract class _InventoryState implements InventoryState {
  const factory _InventoryState({
    final List<InventoryItem> items,
    final bool hasMore,
    final int offset,
    final Object? error,
    final bool isLoadingFirstPage,
    final bool isLoadingNextPage,
  }) = _$InventoryStateImpl;

  @override
  List<InventoryItem> get items;
  @override
  bool get hasMore;
  @override
  int get offset;
  @override
  Object? get error;
  @override
  bool get isLoadingFirstPage;
  @override
  bool get isLoadingNextPage;

  /// Create a copy of InventoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryStateImplCopyWith<_$InventoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
