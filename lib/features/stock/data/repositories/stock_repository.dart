import 'package:dio/dio.dart';
import 'package:warehousesys/features/stock/data/models/counterparty.dart';
import 'package:warehousesys/features/stock/data/models/dashboard_data.dart';
import 'package:warehousesys/features/stock/data/models/document.dart';
import 'package:warehousesys/features/stock/data/models/document_details.dart';
import 'package:warehousesys/features/stock/data/models/filters.dart';
import 'package:warehousesys/features/stock/data/models/product_options.dart';
import 'package:warehousesys/features/stock/data/models/item_details.dart';
import 'package:warehousesys/features/stock/data/models/variant.dart';

abstract class IStockRepository {
  Future<List<InventoryItem>> searchItems(VariantFilter filter);
  Future<List<Category>> getCategories();
  Future<List<Warehouse>> getWarehouses();
  Future<List<Product>> getProducts();
  Future<List<CharacteristicType>> getCharacteristicTypes();
  Future<Product> getProductById(int productId);
  Future<ProductOptionsDTO> getProductOptions(int productId);
  Future<List<VariantStock>> getVariantStock(int variantId);
  Future<List<StockMovement>> getVariantMovements(int variantId);
  Future<DocumentDetailsDTO> getDocumentDetails(int documentId);
  Future<List<DocumentListItem>> getDocuments(DocumentFilter filter);
  Future<List<Counterparty>> getCounterparties(CounterpartyFilter filter);
  Future<Counterparty> getCounterpartyById(int counterpartyId);
  Future<DashboardData> getDashboardData({int? warehouseId});

  Future<List<int>> downloadReport({
    required String type,
    String format = 'pdf',
    required DateTime dateFrom,
    required DateTime dateTo,
    int? warehouseId,
    double? taxRate,
  });

  Future<void> createProductWithVariant({
    required String productName,
    String? description,
    required int categoryId,
    required String sku,
    required int unitId,
    required Map<String, String> characteristics,
  });

  Future<void> createVariant({
    required int productId,
    required String sku,
    required int unitId,
    required Map<String, String> characteristics,
  });

  Future<Category> createCategory(String name);
  Future<Counterparty> createCounterparty(Counterparty counterparty);

  Future<void> updateProduct({
    required int productId,
    String? name,
    String? description,
    int? categoryId,
  });
  Future<void> updateVariant({
    required int variantId,
    required String sku,
    required Map<String, String> characteristics,
  });
  Future<void> updateCounterparty(Counterparty counterparty);

  Future<void> deleteVariant(int variantId);
  Future<void> deleteCounterparty(int counterpartyId);

  Future<DocumentListItem> createDocument(Map<String, dynamic> data);
  Future<void> postDocument(int documentId);
  Future<DocumentListItem> updateDocument(int documentId, Map<String, dynamic> data);
  Future<void> deleteDocument(int documentId);
}

class StockRepository implements IStockRepository {
  final Dio _dio;
  StockRepository(this._dio);

  @override
  Future<List<InventoryItem>> searchItems(VariantFilter filter) async {
    try {
      final queryParameters = <String, dynamic>{
        'limit': filter.limit,
        'offset': filter.offset,
        'stock_status': filter.stockStatus,
        if (filter.name != null && filter.name!.isNotEmpty) 'name': filter.name,
        if (filter.categoryId != -1) 'category_id': filter.categoryId,
        if (filter.warehouseId != -1) 'warehouse_id': filter.warehouseId,
      };
      final response = await _dio.get(
        '/stock/variants',
        queryParameters: queryParameters,
      );
      if (response.data == null) return [];
      final List<dynamic> data = response.data;
      return data.map((json) => InventoryItem.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error searching items: $e');
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get('/stock/categories');
      if (response.data == null) return [];
      final List<dynamic> data = response.data;
      return data.map((json) => Category.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching categories: $e');
      rethrow;
    }
  }

  @override
  Future<List<Warehouse>> getWarehouses() async {
    try {
      final response = await _dio.get('/stock/warehouses');
      if (response.data == null) return [];
      final List<dynamic> data = response.data;
      return data.map((json) => Warehouse.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching warehouses: $e');
      rethrow;
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/stock/products');
      if (response.data == null) return [];
      final List<dynamic> data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }

  @override
  Future<void> createProductWithVariant({
    required String productName,
    String? description,
    required int categoryId,
    required String sku,
    required int unitId,
    required Map<String, String> characteristics,
  }) async {
    try {
      final productResponse = await _dio.post(
        '/stock/products',
        data: {
          'name': productName,
          'category_id': categoryId,
          'description': description,
        },
      );
      final newProductId = productResponse.data['id'];
      await createVariant(
        productId: newProductId,
        sku: sku,
        unitId: unitId,
        characteristics: characteristics,
      );
    } on DioException catch (e) {
      print('Error creating product with variant: $e');
      rethrow;
    }
  }

  @override
  Future<void> createVariant({
    required int productId,
    required String sku,
    required int unitId,
    required Map<String, String> characteristics,
  }) async {
    try {
      await _dio.post(
        '/stock/variants',
        data: {
          'product_id': productId,
          'sku': sku,
          'unit_id': unitId,
          'characteristics': characteristics,
        },
      );
    } on DioException catch (e) {
      print('Error creating variant: $e');
      rethrow;
    }
  }

  @override
  Future<Category> createCategory(String name) async {
    try {
      final response = await _dio.post(
        '/stock/categories',
        data: {'name': name},
      );
      return Category.fromJson(response.data);
    } on DioException catch (e) {
      print('Error creating category: $e');
      rethrow;
    }
  }

  @override
  Future<List<CharacteristicType>> getCharacteristicTypes() async {
    try {
      final response = await _dio.get('/stock/characteristics/types');
      if (response.data == null) return [];
      final List<dynamic> data = response.data;
      return data.map((json) => CharacteristicType.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching characteristic types: $e');
      rethrow;
    }
  }

  @override
  Future<Product> getProductById(int productId) async {
    try {
      final response = await _dio.get('/stock/products/$productId');
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      print('Error fetching product by id: $e');
      rethrow;
    }
  }

  @override
  Future<ProductOptionsDTO> getProductOptions(int productId) async {
    try {
      final response = await _dio.get('/stock/products/$productId/options');
      return ProductOptionsDTO.fromJson(response.data);
    } on DioException catch (e) {
      print('Error fetching product options: $e');
      rethrow;
    }
  }

  @override
  Future<List<VariantStock>> getVariantStock(int variantId) async {
    try {
      final response = await _dio.get('/stock/variants/$variantId/stock');
      if (response.data == null) return [];
      final List<dynamic> data = response.data;
      return data.map((json) => VariantStock.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching variant stock: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockMovement>> getVariantMovements(int variantId) async {
    try {
      final response = await _dio.get(
        '/stock/movements',
        queryParameters: {'variant_id': variantId, 'limit': 10},
      );
      if (response.data == null) return [];
      final List<dynamic> data = response.data;
      return data.map((json) => StockMovement.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching variant movements: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteVariant(int variantId) async {
    try {
      await _dio.delete('/stock/variants/$variantId');
    } on DioException catch (e) {
      print('Error deleting variant: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateProduct({
    required int productId,
    String? name,
    String? description,
    int? categoryId,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (description != null) data['description'] = description;
      if (categoryId != null) data['category_id'] = categoryId;
      if (data.isEmpty) return;

      await _dio.put('/stock/products/$productId', data: data);
    } on DioException catch (e) {
      print('Error updating product: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateVariant({
    required int variantId,
    required String sku,
    required Map<String, String> characteristics,
  }) async {
    try {
      await _dio.put(
        '/stock/variants/$variantId',
        data: {'sku': sku, 'characteristics': characteristics},
      );
    } on DioException catch (e) {
      print('Error updating variant: $e');
      rethrow;
    }
  }

  @override
  Future<DocumentDetailsDTO> getDocumentDetails(int documentId) async {
    try {
      final response = await _dio.get('/stock/documents/$documentId');
      return DocumentDetailsDTO.fromJson(response.data);
    } on DioException catch (e) {
      print('Error fetching document details: $e');
      rethrow;
    }
  }

  @override
  @override
  Future<List<DocumentListItem>> getDocuments(DocumentFilter filter) async {
    try {
      final queryParameters = <String, dynamic>{
        'limit': filter.limit,
        'offset': filter.offset,
        if (filter.status != null) 'status': filter.status,
        if (filter.search != null) 'search': filter.search,
        'types': filter.types,
        if (filter.dateFrom != null)
          'date_from': filter.dateFrom!.toUtc().toIso8601String(),
        if (filter.dateTo != null)
          'date_to': filter.dateTo!.toUtc().toIso8601String(),
      };

      final response = await _dio.get(
        '/stock/documents',
        queryParameters: queryParameters,
      );

      if (response.data == null) return [];
      final List<dynamic> data = response.data;
      return data.map((json) => DocumentListItem.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching documents: $e');
      rethrow;
    }
  }

  @override
  Future<List<Counterparty>> getCounterparties(
    CounterpartyFilter filter,
  ) async {
    try {
      final queryParameters = <String, dynamic>{
        'limit': filter.limit,
        'offset': filter.offset,
        if (filter.search != null && filter.search!.isNotEmpty)
          'search': filter.search,
      };
      final response = await _dio.get(
        '/stock/counterparties',
        queryParameters: queryParameters,
      );
      if (response.data == null) return [];
      final List<dynamic> data = response.data;
      return data.map((json) => Counterparty.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching counterparties: $e');
      rethrow;
    }
  }

  @override
  Future<Counterparty> getCounterpartyById(int counterpartyId) async {
    try {
      final response = await _dio.get('/stock/counterparties/$counterpartyId');
      return Counterparty.fromJson(response.data);
    } on DioException catch (e) {
      print('Error fetching counterparty by id: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateCounterparty(Counterparty counterparty) async {
    try {
      final data = counterparty.toJson();
      await _dio.put('/stock/counterparties/${counterparty.id}', data: data);
    } on DioException catch (e) {
      print('Error updating counterparty: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteCounterparty(int counterpartyId) async {
    try {
      await _dio.delete('/stock/counterparties/$counterpartyId');
    } on DioException catch (e) {
      print('Error deleting counterparty: $e');
      rethrow;
    }
  }

  @override
  Future<Counterparty> createCounterparty(Counterparty counterparty) async {
    try {
      final response = await _dio.post(
        '/stock/counterparties',
        data: counterparty.toJson(),
      );
      return Counterparty.fromJson(response.data);
    } on DioException catch (e) {
      print('Error creating counterparty: $e');
      rethrow;
    }
  }

  @override
  Future<DocumentListItem> createDocument(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/stock/documents', data: data);
      return DocumentListItem.fromJson(response.data);
    } on DioException catch (e) {
      print('Error creating document: $e');
      rethrow;
    }
  }

  @override
  Future<void> postDocument(int documentId) async {
    try {
      await _dio.post('/stock/documents/$documentId/post');
    } on DioException catch (e) {
      print('Error posting document: $e');
      rethrow;
    }
  }

  @override
  Future<DocumentListItem> updateDocument(int documentId, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/stock/documents/$documentId', data: data);
      return DocumentListItem.fromJson(response.data);
    } on DioException catch (e) {
      print('Error updating document: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteDocument(int documentId) async {
    try {
      await _dio.delete('/stock/documents/$documentId');
    } on DioException catch (e) {
      print('Error deleting document: $e');
      rethrow;
    }
  }

  @override
  Future<DashboardData> getDashboardData({int? warehouseId}) async {
    final params = <String, dynamic>{};
    if (warehouseId != null) params['warehouse_id'] = warehouseId;    
    final response = await _dio.get('/analytics/dashboard', queryParameters: params);
    return DashboardData.fromJson(response.data);
  }

  @override
  Future<List<int>> downloadReport({
    required String type,
    String format = 'pdf',
    required DateTime dateFrom,
    required DateTime dateTo,
    int? warehouseId,
    double? taxRate,
  }) async {
    final response = await _dio.get(
      '/reports/download',
      queryParameters: {
        'type': type,
        'format': format,
        'date_from': dateFrom.toUtc().toIso8601String(),
        'date_to': dateTo.toUtc().toIso8601String(),
        if (warehouseId != null) 'warehouse_id': warehouseId,
        if (taxRate != null) 'tax_rate': taxRate,
      },
      options: Options(responseType: ResponseType.bytes),
    );
    return response.data;
  }
}
