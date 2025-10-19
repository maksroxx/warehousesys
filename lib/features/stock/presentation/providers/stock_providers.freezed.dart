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

/// @nodoc
mixin _$DocumentListState {
  List<DocumentListItem> get documents => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  bool get isLoadingFirstPage => throw _privateConstructorUsedError;
  bool get isLoadingNextPage => throw _privateConstructorUsedError;

  /// Create a copy of DocumentListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentListStateCopyWith<DocumentListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentListStateCopyWith<$Res> {
  factory $DocumentListStateCopyWith(
    DocumentListState value,
    $Res Function(DocumentListState) then,
  ) = _$DocumentListStateCopyWithImpl<$Res, DocumentListState>;
  @useResult
  $Res call({
    List<DocumentListItem> documents,
    bool hasMore,
    Object? error,
    bool isLoadingFirstPage,
    bool isLoadingNextPage,
  });
}

/// @nodoc
class _$DocumentListStateCopyWithImpl<$Res, $Val extends DocumentListState>
    implements $DocumentListStateCopyWith<$Res> {
  _$DocumentListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documents = null,
    Object? hasMore = null,
    Object? error = freezed,
    Object? isLoadingFirstPage = null,
    Object? isLoadingNextPage = null,
  }) {
    return _then(
      _value.copyWith(
            documents: null == documents
                ? _value.documents
                : documents // ignore: cast_nullable_to_non_nullable
                      as List<DocumentListItem>,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$DocumentListStateImplCopyWith<$Res>
    implements $DocumentListStateCopyWith<$Res> {
  factory _$$DocumentListStateImplCopyWith(
    _$DocumentListStateImpl value,
    $Res Function(_$DocumentListStateImpl) then,
  ) = __$$DocumentListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<DocumentListItem> documents,
    bool hasMore,
    Object? error,
    bool isLoadingFirstPage,
    bool isLoadingNextPage,
  });
}

/// @nodoc
class __$$DocumentListStateImplCopyWithImpl<$Res>
    extends _$DocumentListStateCopyWithImpl<$Res, _$DocumentListStateImpl>
    implements _$$DocumentListStateImplCopyWith<$Res> {
  __$$DocumentListStateImplCopyWithImpl(
    _$DocumentListStateImpl _value,
    $Res Function(_$DocumentListStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocumentListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documents = null,
    Object? hasMore = null,
    Object? error = freezed,
    Object? isLoadingFirstPage = null,
    Object? isLoadingNextPage = null,
  }) {
    return _then(
      _$DocumentListStateImpl(
        documents: null == documents
            ? _value._documents
            : documents // ignore: cast_nullable_to_non_nullable
                  as List<DocumentListItem>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
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

class _$DocumentListStateImpl implements _DocumentListState {
  const _$DocumentListStateImpl({
    final List<DocumentListItem> documents = const [],
    this.hasMore = true,
    this.error,
    this.isLoadingFirstPage = false,
    this.isLoadingNextPage = false,
  }) : _documents = documents;

  final List<DocumentListItem> _documents;
  @override
  @JsonKey()
  List<DocumentListItem> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  @override
  @JsonKey()
  final bool hasMore;
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
    return 'DocumentListState(documents: $documents, hasMore: $hasMore, error: $error, isLoadingFirstPage: $isLoadingFirstPage, isLoadingNextPage: $isLoadingNextPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentListStateImpl &&
            const DeepCollectionEquality().equals(
              other._documents,
              _documents,
            ) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.isLoadingFirstPage, isLoadingFirstPage) ||
                other.isLoadingFirstPage == isLoadingFirstPage) &&
            (identical(other.isLoadingNextPage, isLoadingNextPage) ||
                other.isLoadingNextPage == isLoadingNextPage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_documents),
    hasMore,
    const DeepCollectionEquality().hash(error),
    isLoadingFirstPage,
    isLoadingNextPage,
  );

  /// Create a copy of DocumentListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentListStateImplCopyWith<_$DocumentListStateImpl> get copyWith =>
      __$$DocumentListStateImplCopyWithImpl<_$DocumentListStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DocumentListState implements DocumentListState {
  const factory _DocumentListState({
    final List<DocumentListItem> documents,
    final bool hasMore,
    final Object? error,
    final bool isLoadingFirstPage,
    final bool isLoadingNextPage,
  }) = _$DocumentListStateImpl;

  @override
  List<DocumentListItem> get documents;
  @override
  bool get hasMore;
  @override
  Object? get error;
  @override
  bool get isLoadingFirstPage;
  @override
  bool get isLoadingNextPage;

  /// Create a copy of DocumentListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentListStateImplCopyWith<_$DocumentListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
