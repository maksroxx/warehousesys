// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:warehousesys/features/auth/data/models/user_model.dart';
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
  Future<List<Unit>> getUnits();
  Future<String> uploadImage(File file);

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
    List<String> imageUrls = const [],
  });

  Future<void> createVariant({
    required int productId,
    required String sku,
    required int unitId,
    required Map<String, String> characteristics,
    List<String> imageUrls = const [],
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
    List<String>? imageUrls,
  });
  Future<void> updateCounterparty(Counterparty counterparty);

  Future<void> deleteVariant(int variantId);
  Future<void> deleteCounterparty(int counterpartyId);

  Future<DocumentListItem> createDocument(Map<String, dynamic> data);
  Future<void> postDocument(int documentId);
  Future<DocumentListItem> updateDocument(
    int documentId,
    Map<String, dynamic> data,
  );
  Future<void> deleteDocument(int documentId);

  Future<List<User>> getUsers();
  Future<void> createUser({
    required String name,
    required String email,
    required String password,
    required int roleId,
  });
  Future<void> deleteUser(int userId);

  Future<List<Role>> getRoles();
  Future<void> createRole({required String name, required List<String> permissions});

  Future<void> updateUser({
    required int userId,
    required String name,
    required String email,
    String? password,
    required int roleId,
  });

  Future<void> updateRole({
    required int roleId,
    required String name,
    required List<String> permissions,
  });

  Future<void> deleteRole(int roleId);
  
  Future<void> createUnit(String name);
  
  Future<void> createWarehouse(String name, String address);
  Future<void> deleteWarehouse(int id);

  Future<void> updateCategory(int id, String name);
  Future<void> deleteCategory(int id);
  Future<Uint8List> backupDatabase();
  Future<void> restoreDatabase(File file);

  Future<void> switchDatabase({
    required String driver,
    String? host,
    String? port,
    String? user,
    String? password,
    String? dbname,
  });
  Future<void> importProducts(File file);
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
    List<String> imageUrls = const [],
  }) async {
    await _dio.post(
      '/stock/products',
      data: {
        'name': productName,
        'category_id': categoryId,
        'description': description,
        'sku': sku,
        'unit_id': unitId,
        'characteristics': characteristics,
        'images': imageUrls,
      },
    );
  }
  // Future<void> createProductWithVariant({
  //   required String productName,
  //   String? description,
  //   List<String> imageUrls = const [],
  //   required int categoryId,
  //   required String sku,
  //   required int unitId,
  //   required Map<String, String> characteristics,
  // }) async {
  //   try {
  //     final productResponse = await _dio.post(
  //       '/stock/products',
  //       data: {
  //         'name': productName,
  //         'category_id': categoryId,
  //         'description': description,
  //         'images': imageUrls,
  //       },
  //     );
  //     final newProductId = productResponse.data['id'];
  //     await createVariant(
  //       productId: newProductId,
  //       sku: sku,
  //       unitId: unitId,
  //       characteristics: characteristics,
  //     );
  //   } on DioException catch (e) {
  //     print('Error creating product with variant: $e');
  //     rethrow;
  //   }
  // }

  @override
  Future<void> createVariant({
    required int productId,
    required String sku,
    required int unitId,
    required Map<String, String> characteristics,
    List<String> imageUrls = const [],
  }) async {
    try {
      await _dio.post(
        '/stock/variants',
        data: {
          'product_id': productId,
          'sku': sku,
          'unit_id': unitId,
          'characteristics': characteristics,
          'images': imageUrls,
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
    List<String>? imageUrls,
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
    List<String>? imageUrls,
  }) async {
    final data = <String, dynamic>{
      'sku': sku,
      'characteristics': characteristics,
    };
    if (imageUrls != null) {
      data['images'] = imageUrls;
    }

    await _dio.put('/stock/variants/$variantId', data: data);
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
  Future<DocumentListItem> updateDocument(
    int documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.put(
        '/stock/documents/$documentId',
        data: data,
      );
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
    final response = await _dio.get(
      '/analytics/dashboard',
      queryParameters: params,
    );
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

  @override
  Future<List<Unit>> getUnits() async {
    try {
      final response = await _dio.get('/stock/units');
      if (response.data == null) return [];
      final List<dynamic> data = response.data;
      return data.map((json) => Unit.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching units: $e');
      rethrow;
    }
  }

  @override
  Future<String> uploadImage(File file) async {
    try {
      String fileName = file.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await _dio.post('/upload', data: formData);

      return response.data['url'];
    } on DioException catch (e) {
      throw Exception('Failed to upload image: ${e.message}');
    }
  }

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('/users');
      final List<dynamic> data = response.data;
      return data.map((json) => User.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching users: $e');
      rethrow;
    }
  }

  @override
  Future<void> createUser({
    required String name,
    required String email,
    required String password,
    required int roleId,
  }) async {
    try {
      await _dio.post('/users', data: {
        'name': name,
        'email': email,
        'password': password,
        'role_id': roleId,
      });
    } on DioException catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(int userId) async {
    try {
      await _dio.delete('/users/$userId');
    } on DioException catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }

  @override
  Future<List<Role>> getRoles() async {
    try {
      final response = await _dio.get('/roles');
      final List<dynamic> data = response.data;
      return data.map((json) => Role.fromJson(json)).toList();
    } on DioException catch (e) {
      print('Error fetching roles: $e');
      rethrow;
    }
  }

  @override
  Future<void> createRole({required String name, required List<String> permissions}) async {
    try {
      await _dio.post('/roles', data: {
        'name': name,
        'permissions': permissions,
      });
    } on DioException catch (e) {
      print('Error creating role: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateUser({
    required int userId,
    required String name,
    required String email,
    String? password,
    required int roleId,
  }) async {
    try {
      final data = {
        'name': name,
        'email': email,
        'role_id': roleId,
      };
      if (password != null && password.isNotEmpty) {
        data['password'] = password;
      }
      
      await _dio.put('/users/$userId', data: data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Failed to update user');
    }
  }

  @override
  Future<void> updateRole({
    required int roleId,
    required String name,
    required List<String> permissions,
  }) async {
    try {
      await _dio.put('/roles/$roleId', data: {
        'name': name,
        'permissions': permissions,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Failed to update role');
    }
  }

  @override
  Future<void> deleteRole(int roleId) async {
    try {
      await _dio.delete('/roles/$roleId');
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Failed to delete role');
    }
  }
  
@override
  Future<void> createUnit(String name) async {
    try {
      await _dio.post('/stock/units', data: {'name': name});
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Не удалось создать единицу измерения');
    }
  }

  @override
  Future<void> createWarehouse(String name, String address) async {
    try {
      await _dio.post('/stock/warehouses', data: {
        'name': name,
        'address': address,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Не удалось создать склад');
    }
  }

  @override
  Future<void> updateCategory(int id, String name) async {
    try {
      await _dio.put('/stock/categories/$id', data: {'name': name});
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Не удалось обновить категорию');
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    try {
      await _dio.delete('/stock/categories/$id');
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Не удалось удалить категорию');
    }
  }

  @override
  Future<void> deleteWarehouse(int id) async {
    try {
      await _dio.delete('/stock/warehouses/$id');
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Не удалось удалить склад');
    }
  }

  @override
  Future<Uint8List> backupDatabase() async {
    final response = await _dio.get(
      '/system/backup',
      options: Options(responseType: ResponseType.bytes),
    );
    return response.data;
  }

  @override
  Future<void> restoreDatabase(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: 'restore.db'),
    });

    await _dio.post(
      '/system/restore',
      data: formData,
    );
  }

  @override
  Future<void> switchDatabase({
    required String driver,
    String? host,
    String? port,
    String? user,
    String? password,
    String? dbname,
  }) async {
    await _dio.post('/system/config/db', data: {
      'driver': driver,
      'host': host,
      'port': port,
      'user': user,
      'password': password,
      'dbname': dbname,
    });
  }

  @override
  Future<void> importProducts(File file) async {
    String fileName = file.path.split(Platform.pathSeparator).last;
    
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    await _dio.post('/stock/products/import', data: formData);
  }
}
