import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warehousesys/features/stock/data/models/counterparty.dart';
import 'package:warehousesys/features/stock/data/models/dashboard_data.dart';
import 'package:warehousesys/features/stock/data/models/document.dart';
import 'package:warehousesys/features/stock/data/models/document_details.dart';
import 'package:warehousesys/features/stock/data/models/filters.dart';
import 'package:warehousesys/features/stock/data/models/item_details.dart';
import 'package:warehousesys/features/stock/data/models/product_options.dart';
import 'package:warehousesys/features/stock/data/models/variant.dart';
import 'package:warehousesys/features/stock/data/repositories/stock_repository.dart';

part 'stock_providers.freezed.dart';

final dioProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    // baseUrl: 'http://192.168.1.149:8080/api/v1',
    baseUrl: 'http://localhost:8080/api/v1',
    listFormat: ListFormat.multi,
  );
  return Dio(options);
});

final stockRepositoryProvider = Provider<IStockRepository>(
  (ref) => StockRepository(ref.watch(dioProvider)),
);

final documentFilterProvider = StateProvider<DocumentFilter>((ref) {
  return const DocumentFilter(types: ['OUTCOME', 'INCOME']);
});

final productsProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  return ref.watch(stockRepositoryProvider).getProducts();
});

final categoriesProvider = FutureProvider.autoDispose<List<Category>>((ref) {
  return ref.watch(stockRepositoryProvider).getCategories();
});

final warehousesProvider = FutureProvider.autoDispose<List<Warehouse>>((ref) {
  return ref.watch(stockRepositoryProvider).getWarehouses();
});

final characteristicTypesProvider =
    FutureProvider.autoDispose<List<CharacteristicType>>((ref) {
      return ref.watch(stockRepositoryProvider).getCharacteristicTypes();
    });

final variantStockProvider = FutureProvider.family
    .autoDispose<List<VariantStock>, int>((ref, variantId) {
      return ref.watch(stockRepositoryProvider).getVariantStock(variantId);
    });

final detailedProductProvider = FutureProvider.family.autoDispose<Product, int>(
  (ref, productId) {
    return ref.watch(stockRepositoryProvider).getProductById(productId);
  },
);

final variantMovementsProvider = FutureProvider.family
    .autoDispose<List<StockMovement>, int>((ref, variantId) {
      return ref.watch(stockRepositoryProvider).getVariantMovements(variantId);
    });

final documentDetailsProvider = FutureProvider.family
    .autoDispose<DocumentDetailsDTO, int>((ref, documentId) {
      return ref.watch(stockRepositoryProvider).getDocumentDetails(documentId);
    });
final productOptionsProvider = FutureProvider.family
    .autoDispose<ProductOptionsDTO, int>((ref, productId) {
      return ref.watch(stockRepositoryProvider).getProductOptions(productId);
    });

final inventoryFilterProvider = StateProvider<VariantFilter>((ref) {
  return const VariantFilter(warehouseId: 1, stockStatus: 'all');
});

@freezed
class InventoryState with _$InventoryState {
  const factory InventoryState({
    @Default([]) List<InventoryItem> items,
    @Default(true) bool hasMore,
    @Default(0) int offset,
    Object? error,
    @Default(false) bool isLoadingFirstPage,
    @Default(false) bool isLoadingNextPage,
  }) = _InventoryState;
}

class InventoryNotifier extends StateNotifier<InventoryState> {
  final IStockRepository _stockRepository;
  final VariantFilter _filter;
  final int _limit;

  InventoryNotifier(this._stockRepository, this._filter)
    : _limit = _filter.limit,
      super(const InventoryState()) {
    fetchFirstPage();
  }

  Future<void> fetchFirstPage() async {
    state = const InventoryState(isLoadingFirstPage: true);
    try {
      final newItems = await _stockRepository.searchItems(
        _filter.copyWith(offset: 0),
      );
      state = InventoryState(
        items: newItems,
        offset: newItems.length,
        hasMore: newItems.length == _limit,
      );
    } catch (e) {
      state = InventoryState(error: e);
    }
  }

  Future<void> fetchNextPage() async {
    if (state.isLoadingNextPage || !state.hasMore) return;
    state = state.copyWith(isLoadingNextPage: true, error: null);

    try {
      final newItems = await _stockRepository.searchItems(
        _filter.copyWith(offset: state.offset),
      );
      state = state.copyWith(
        items: [...state.items, ...newItems],
        offset: state.offset + newItems.length,
        hasMore: newItems.length == _limit,
        isLoadingNextPage: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingNextPage: false, error: e);
    }
  }

  Future<void> refresh() async {
    return fetchFirstPage();
  }
}

final inventoryProvider =
    StateNotifierProvider.autoDispose<InventoryNotifier, InventoryState>((ref) {
      final stockRepository = ref.watch(stockRepositoryProvider);
      final filter = ref.watch(inventoryFilterProvider);

      return InventoryNotifier(stockRepository, filter);
    });

@freezed
class DocumentListState with _$DocumentListState {
  const factory DocumentListState({
    @Default([]) List<DocumentListItem> documents,
    @Default(true) bool hasMore,
    Object? error,
    @Default(false) bool isLoadingFirstPage,
    @Default(false) bool isLoadingNextPage,
  }) = _DocumentListState;
}

class DocumentListNotifier extends StateNotifier<DocumentListState> {
  final IStockRepository _repository;
  final Ref _ref;
  final StateProvider<DocumentFilter> _filterProvider;

  DocumentListNotifier(this._repository, this._ref, this._filterProvider)
    : super(const DocumentListState()) {
    fetchFirstPage();

    _ref.listen(_filterProvider, (_, __) => fetchFirstPage());
  }

  Future<void> fetchFirstPage() async {
    state = const DocumentListState(isLoadingFirstPage: true);
    final filter = _ref.read(_filterProvider);
    try {
      final newDocs = await _repository.getDocuments(
        filter.copyWith(offset: 0),
      );
      state = DocumentListState(
        documents: newDocs,
        hasMore: newDocs.length == filter.limit,
      );
    } catch (e) {
      state = DocumentListState(error: e);
    }
  }

  Future<void> fetchNextPage() async {
    if (state.isLoadingNextPage || !state.hasMore) return;
    state = state.copyWith(isLoadingNextPage: true, error: null);

    final filter = _ref.read(_filterProvider);
    final currentOffset = state.documents.length;

    try {
      final newDocs = await _repository.getDocuments(
        filter.copyWith(offset: currentOffset),
      );
      state = state.copyWith(
        documents: [...state.documents, ...newDocs],
        hasMore: newDocs.length == filter.limit,
        isLoadingNextPage: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingNextPage: false, error: e);
    }
  }
}

final documentsProvider =
    StateNotifierProvider.autoDispose<DocumentListNotifier, DocumentListState>((ref) {
      final repository = ref.watch(stockRepositoryProvider);
      return DocumentListNotifier(repository, ref, documentFilterProvider); 
    });


final counterpartyFilterProvider = StateProvider.autoDispose<CounterpartyFilter>(
  (ref) => const CounterpartyFilter(),
);

@freezed
class CounterpartyListState with _$CounterpartyListState {
  const factory CounterpartyListState({
    @Default([]) List<Counterparty> counterparties,
    @Default(true) bool hasMore,
    @Default(0) int offset,
    Object? error,
    @Default(false) bool isLoadingFirstPage,
    @Default(false) bool isLoadingNextPage,
  }) = _CounterpartyListState;
}

class CounterpartyListNotifier extends StateNotifier<CounterpartyListState> {
  final IStockRepository _repository;
  final Ref _ref;

  CounterpartyListNotifier(this._repository, this._ref)
      : super(const CounterpartyListState()) {
    fetchFirstPage();
    _ref.listen(counterpartyFilterProvider, (_, __) => fetchFirstPage());
  }

  Future<void> fetchFirstPage() async {
    state = const CounterpartyListState(isLoadingFirstPage: true);
    final filter = _ref.read(counterpartyFilterProvider);
    try {
      final newItems = await _repository.getCounterparties(
        filter.copyWith(offset: 0),
      );
      state = CounterpartyListState(
        counterparties: newItems,
        offset: newItems.length,
        hasMore: newItems.length == filter.limit,
      );
    } catch (e) {
      state = CounterpartyListState(error: e);
    }
  }

  Future<void> fetchNextPage() async {
    if (state.isLoadingNextPage || !state.hasMore) return;
    state = state.copyWith(isLoadingNextPage: true, error: null);
    
    final filter = _ref.read(counterpartyFilterProvider);
    
    try {
      final newItems = await _repository.getCounterparties(
        filter.copyWith(offset: state.offset),
      );
      state = state.copyWith(
        counterparties: [...state.counterparties, ...newItems],
        offset: state.offset + newItems.length,
        hasMore: newItems.length == filter.limit,
        isLoadingNextPage: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingNextPage: false, error: e);
    }
  }
}

final counterpartiesProvider =
    StateNotifierProvider.autoDispose<CounterpartyListNotifier, CounterpartyListState>(
        (ref) {
  final repository = ref.watch(stockRepositoryProvider);
  return CounterpartyListNotifier(repository, ref);
});

final counterpartyDetailsProvider =
    FutureProvider.family.autoDispose<Counterparty, int>((ref, counterpartyId) {
  return ref.watch(stockRepositoryProvider).getCounterpartyById(counterpartyId);
});

final selectedDashboardWarehouseProvider = StateProvider<int?>((ref) => null);

final dashboardDataProvider = FutureProvider.autoDispose<DashboardData>((ref) {
  final whId = ref.watch(selectedDashboardWarehouseProvider);
  return ref.watch(stockRepositoryProvider).getDashboardData(warehouseId: whId);
});

final unitsProvider = FutureProvider.autoDispose<List<Unit>>((ref) {
  return ref.watch(stockRepositoryProvider).getUnits();
});