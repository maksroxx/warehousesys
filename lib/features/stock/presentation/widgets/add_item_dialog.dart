import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/filters.dart';
import 'package:warehousesys/features/stock/data/models/variant.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';

class CharacteristicField {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  void dispose() {
    keyController.dispose();
    valueController.dispose();
  }
}

class AddItemDialog extends ConsumerStatefulWidget {
  final InventoryItem? itemToEdit;
  const AddItemDialog({super.key, this.itemToEdit});
  @override
  ConsumerState<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends ConsumerState<AddItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _newCategoryController = TextEditingController();
  final List<CharacteristicField> _customCharacteristicFields = [];
  final _scrollController = ScrollController();

  Product? _selectedProduct;
  int? _selectedCategoryId;
  bool _isLoading = false;
  bool _isAddingCategory = false;
  Map<String, String> _suggestedCharacteristicsValues = {};

  @override
  void initState() {
    super.initState();
    if (widget.itemToEdit != null) {
      final item = widget.itemToEdit!;
      _nameController.text = item.productName;
      _skuController.text = item.sku;
      _selectedCategoryId = item.categoryId;

      ref.read(detailedProductProvider(item.productId).future).then((product) {
        if (mounted) {
          setState(() {
            _descriptionController.text = product.description ?? '';
          });
        }
      });

      if (item.characteristics != null) {
        _suggestedCharacteristicsValues = Map.from(item.characteristics!);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _skuController.dispose();
    _descriptionController.dispose();
    _newCategoryController.dispose();
    for (var field in _customCharacteristicFields) {
      field.dispose();
    }
    super.dispose();
  }

  void _addCustomCharacteristicField() {
    setState(() => _customCharacteristicFields.add(CharacteristicField()));
    Timer(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _removeCustomCharacteristicField(int index) {
    setState(() {
      _customCharacteristicFields[index].dispose();
      _customCharacteristicFields.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() != true) return;
    final isEditMode = widget.itemToEdit != null;
    if (!isEditMode &&
        _selectedProduct == null &&
        _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Введите название нового продукта или выберите существующий',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (!isEditMode &&
        _selectedProduct == null &&
        _selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Для нового продукта необходимо выбрать категорию'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final characteristics = {..._suggestedCharacteristicsValues};
      for (var field in _customCharacteristicFields) {
        if (field.keyController.text.isNotEmpty &&
            field.valueController.text.isNotEmpty) {
          characteristics[field.keyController.text] =
              field.valueController.text;
        }
      }

      if (isEditMode) {
        await Future.wait([
          ref
              .read(stockRepositoryProvider)
              .updateProduct(
                productId: widget.itemToEdit!.productId,
                name: _nameController.text,
                description: _descriptionController.text,
                categoryId: _selectedCategoryId,
              ),
          ref
              .read(stockRepositoryProvider)
              .updateVariant(
                variantId: widget.itemToEdit!.id,
                sku: _skuController.text,
                characteristics: characteristics,
              ),
        ]);
      } else {
        if (_selectedProduct != null) {
          await ref
              .read(stockRepositoryProvider)
              .createVariant(
                productId: _selectedProduct!.id,
                sku: _skuController.text,
                unitId: 1,
                characteristics: characteristics,
              );
        } else {
          await ref
              .read(stockRepositoryProvider)
              .createProductWithVariant(
                productName: _nameController.text,
                categoryId: _selectedCategoryId!,
                description: _descriptionController.text,
                sku: _skuController.text,
                unitId: 1,
                characteristics: characteristics,
              );
        }
      }

      if (!mounted) return;

      if (isEditMode) {
        final item = widget.itemToEdit!;
        ref.invalidate(detailedProductProvider(item.productId));
        ref.invalidate(variantStockProvider(item.id));
        ref.invalidate(variantMovementsProvider(item.id));

        ref.read(inventoryFilterProvider.notifier).state =
            const VariantFilter();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Товар успешно ${isEditMode ? "обновлен" : "добавлен"}!',
          ),
          backgroundColor: Colors.green,
        ),
      );
      ref.invalidate(inventoryProvider);
      ref.invalidate(productsProvider);

      Navigator.of(context).pop();
    } on DioException catch (e) {
      String errorMessage = 'Произошла неизвестная ошибка';
      if (e.response?.statusCode == 500) {
        final responseData = e.response?.data;
        if (responseData is Map && responseData['error'] is String) {
          if (responseData['error'].contains(
            'duplicate key value violates unique constraint "idx_variants_sku"',
          )) {
            errorMessage =
                'Этот Артикул (SKU) уже существует. Пожалуйста, введите уникальный.';
          } else {
            errorMessage = responseData['error'];
          }
        } else {
          errorMessage = 'Внутренняя ошибка сервера.';
        }
      } else {
        errorMessage = 'Ошибка сети: ${e.message}';
      }
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Произошла ошибка: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleAddNewCategory() async {
    final name = _newCategoryController.text;
    if (name.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final newCategory = await ref
          .read(stockRepositoryProvider)
          .createCategory(name);
      ref.invalidate(categoriesProvider);
      setState(() {
        _selectedCategoryId = newCategory.id;
        _isAddingCategory = false;
        _newCategoryController.clear();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка создания категории: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Or',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: textGreyColor),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = widget.itemToEdit != null;
    final baseInputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
    );

    return Dialog(
      backgroundColor: cardBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isEditMode ? 550 : 1152,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEditMode ? 'Edit Item' : 'Add New Item',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 24),
                        if (isEditMode)
                          _buildEditColumn(context, baseInputDecoration)
                        else
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildProductColumn(
                                  context,
                                  baseInputDecoration,
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: _buildVariationColumn(
                                  context,
                                  baseInputDecoration,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _buildActionsBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProductColumn(
    BuildContext context,
    InputDecoration baseInputDecoration,
  ) {
    final productsAsync = ref.watch(productsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final isNewProduct = _selectedProduct == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader("Product"),
        _FormEntry(
          label: 'Select Existing Product (optional)',
          child: productsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Text('Error: $e'),
            data: (products) => DropdownButtonFormField<Product>(
              value: _selectedProduct,
              hint: const Text('Select a product...'),
              isExpanded: true,
              decoration: baseInputDecoration.copyWith(
                suffixIcon: _selectedProduct != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() {
                          _selectedProduct = null;
                          _nameController.clear();
                          _descriptionController.clear();
                          _selectedCategoryId = null;
                          _suggestedCharacteristicsValues.clear();
                          _skuController.clear();
                        }),
                      )
                    : null,
              ),
              onChanged: (product) {
                if (product == null) return;
                ref.read(detailedProductProvider(product.id).future).then((
                  detailedProduct,
                ) {
                  if (!mounted) return;
                  setState(() {
                    _selectedProduct = detailedProduct;
                    _nameController.text = detailedProduct.name;
                    _descriptionController.text =
                        detailedProduct.description ?? '';
                    _selectedCategoryId = detailedProduct.categoryId;
                    _suggestedCharacteristicsValues.clear();
                    _skuController.clear();
                  });
                });
              },
              items: products
                  .map(
                    (p) => DropdownMenuItem<Product>(
                      value: p,
                      child: Text(p.name, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        _buildSeparator(),
        AbsorbPointer(
          absorbing: !isNewProduct,
          child: Opacity(
            opacity: isNewProduct ? 1.0 : 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader("Create New Product", isSubHeader: true),
                _FormEntry(
                  label: 'New Product Name',
                  child: TextFormField(
                    controller: _nameController,
                    decoration: baseInputDecoration.copyWith(
                      hintText: 'e.g., Super Widget',
                    ),
                  ),
                ),
                _FormEntry(
                  label: 'Category',
                  child: _isAddingCategory
                      ? Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _newCategoryController,
                                decoration: baseInputDecoration.copyWith(
                                  hintText: 'New category name',
                                ),
                                autofocus: true,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.check),
                              color: Colors.green,
                              onPressed: _handleAddNewCategory,
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              color: Colors.red,
                              onPressed: () =>
                                  setState(() => _isAddingCategory = false),
                            ),
                          ],
                        )
                      : categoriesAsync.when(
                          loading: () => const SizedBox.shrink(),
                          error: (e, s) => const Text('Error'),
                          data: (categories) => DropdownButtonFormField<int>(
                            value: _selectedCategoryId,
                            hint: const Text('Select a category'),
                            decoration: baseInputDecoration,
                            onChanged: (value) {
                              if (value == -1) {
                                setState(() {
                                  _isAddingCategory = true;
                                  _selectedCategoryId = null;
                                });
                              } else {
                                setState(() => _selectedCategoryId = value);
                              }
                            },
                            items: [
                              ...categories.map(
                                (c) => DropdownMenuItem<int>(
                                  value: c.id,
                                  child: Text(c.name),
                                ),
                              ),
                              const DropdownMenuItem<int>(
                                value: -1,
                                child: Row(
                                  children: [
                                    Icon(Icons.add, size: 16),
                                    SizedBox(width: 8),
                                    Text("Add New..."),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                _FormEntry(
                  label: 'Description',
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: baseInputDecoration.copyWith(
                      hintText: 'Describe the product',
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVariationColumn(
    BuildContext context,
    InputDecoration baseInputDecoration,
  ) {
    final tempProduct = _selectedProduct;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader("Variation"),
        _FormEntry(
          label: 'SKU',
          isRequired: true,
          child: TextFormField(
            controller: _skuController,
            decoration: baseInputDecoration.copyWith(
              hintText: 'e.g., SW-BLUE-LG-01',
            ),
            validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
          ),
        ),
        const SizedBox(height: 24),
        _SectionHeader("Characteristics", isSubHeader: true),
        if (tempProduct != null)
          Consumer(
            builder: (context, ref, child) {
              final optionsAsync = ref.watch(
                productOptionsProvider(tempProduct.id),
              );
              return optionsAsync.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (e, s) => Text('Error: $e'),
                data: (data) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    if (_descriptionController.text.isEmpty) {
                      _descriptionController.text =
                          data.product.description ?? '';
                    }
                    if (data.variants.isNotEmpty &&
                        _skuController.text.length <=
                            tempProduct.name.length + 1) {
                      _skuController.text = data.variants.first.sku;
                    } // ?? '${tempProduct.name}-'; }
                  });
                  if (data.options.isEmpty &&
                      _customCharacteristicFields.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'У этого товара еще нет заданных характеристик.',
                        style: TextStyle(color: textGreyColor),
                      ),
                    );
                  }
                  return Column(
                    children: data.options
                        .map(
                          (option) => _FormEntry(
                            label: option.type,
                            child: TextFormField(
                              decoration: baseInputDecoration.copyWith(
                                hintText: 'Value for ${option.type}',
                              ),
                              onChanged: (value) => setState(
                                () =>
                                    _suggestedCharacteristicsValues[option
                                            .type] =
                                        value,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              );
            },
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _customCharacteristicFields.length,
          itemBuilder: (context, index) => _CharacteristicRow(
            field: _customCharacteristicFields[index],
            onRemove: () => _removeCustomCharacteristicField(index),
            baseInputDecoration: baseInputDecoration,
            canBeRemoved: true,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: const BorderSide(
                color: borderColor,
                style: BorderStyle.solid,
                width: 2,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            icon: Icon(PhosphorIconsRegular.plus, size: 16),
            label: const Text('Add New Characteristic'),
            onPressed: _addCustomCharacteristicField,
          ),
        ),
      ],
    );
  }

  Widget _buildEditColumn(
    BuildContext context,
    InputDecoration baseInputDecoration,
  ) {
    final itemToEdit = widget.itemToEdit!;
    final tempProduct = Product(
      id: itemToEdit.productId,
      name: itemToEdit.productName,
    );
    final categoriesAsync = ref.watch(categoriesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader("Product Details"),
        _FormEntry(
          label: 'Product Name',
          child: TextFormField(
            controller: _nameController,
            decoration: baseInputDecoration,
          ),
        ),
        _FormEntry(
          label: 'Category',
          child: _isAddingCategory
              ? Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _newCategoryController,
                        decoration: baseInputDecoration.copyWith(
                          hintText: 'New category name',
                        ),
                        autofocus: true,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check),
                      color: Colors.green,
                      onPressed: _handleAddNewCategory,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.red,
                      onPressed: () =>
                          setState(() => _isAddingCategory = false),
                    ),
                  ],
                )
              : categoriesAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (e, s) => const Text('Error'),
                  data: (categories) => DropdownButtonFormField<int>(
                    value: _selectedCategoryId,
                    hint: const Text('Select a category'),
                    decoration: baseInputDecoration,
                    onChanged: (value) {
                      if (value == -1) {
                        setState(() {
                          _isAddingCategory = true;
                          _selectedCategoryId = null;
                        });
                      } else {
                        setState(() => _selectedCategoryId = value);
                      }
                    },
                    items: [
                      ...categories.map(
                        (c) => DropdownMenuItem<int>(
                          value: c.id,
                          child: Text(c.name),
                        ),
                      ),
                      const DropdownMenuItem<int>(
                        value: -1,
                        child: Row(
                          children: [
                            Icon(Icons.add, size: 16),
                            SizedBox(width: 8),
                            Text("Add New..."),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        _FormEntry(
          label: 'Description',
          child: TextFormField(
            controller: _descriptionController,
            decoration: baseInputDecoration,
            maxLines: 3,
          ),
        ),
        const Divider(height: 32),
        _SectionHeader("Variation Details"),
        _FormEntry(
          label: 'SKU',
          isRequired: true,
          child: TextFormField(
            controller: _skuController,
            decoration: baseInputDecoration.copyWith(
              hintText: 'e.g., SW-BLUE-LG-01',
            ),
            validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
          ),
        ),
        const SizedBox(height: 24),
        _SectionHeader("Characteristics", isSubHeader: true),
        Consumer(
          builder: (context, ref, child) {
            final optionsAsync = ref.watch(
              productOptionsProvider(tempProduct.id),
            );
            return optionsAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, s) => Text('Error: $e'),
              data: (data) {
                if (data.options.isEmpty &&
                    _customCharacteristicFields.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'У этого товара еще нет заданных характеристик.',
                      style: TextStyle(color: textGreyColor),
                    ),
                  );
                }
                return Column(
                  children: data.options
                      .map(
                        (option) => _FormEntry(
                          label: option.type,
                          child: TextFormField(
                            initialValue:
                                _suggestedCharacteristicsValues[option.type],
                            decoration: baseInputDecoration.copyWith(
                              hintText: 'Value for ${option.type}',
                            ),
                            onChanged: (value) => setState(
                              () =>
                                  _suggestedCharacteristicsValues[option.type] =
                                      value,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            );
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _customCharacteristicFields.length,
          itemBuilder: (context, index) => _CharacteristicRow(
            field: _customCharacteristicFields[index],
            canBeRemoved: true,
            onRemove: () => _removeCustomCharacteristicField(index),
            baseInputDecoration: baseInputDecoration,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: const BorderSide(
                color: borderColor,
                style: BorderStyle.solid,
                width: 2,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            icon: Icon(PhosphorIconsRegular.plus, size: 16),
            label: const Text('Add New Characteristic'),
            onPressed: _addCustomCharacteristicField,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: const BoxDecoration(
        color: tableHeaderColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 16),
          if (_isLoading)
            FilledButton.icon(
              onPressed: null,
              icon: const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              label: const Text('Save'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
            )
          else
            FilledButton(
              onPressed: _submitForm,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
              child: const Text('Save'),
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool isSubHeader;
  const _SectionHeader(this.title, {this.isSubHeader = false});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = isSubHeader
        ? theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)
        : theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600);
    return Padding(
      padding: EdgeInsets.only(
        bottom: isSubHeader ? 12 : 8,
        top: isSubHeader ? 16 : 0,
      ),
      child: Container(
        width: double.infinity,
        padding: isSubHeader ? null : const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: isSubHeader
              ? null
              : const Border(bottom: BorderSide(color: borderColor)),
        ),
        child: Text(title, style: textStyle),
      ),
    );
  }
}

class _FormEntry extends StatelessWidget {
  final String label;
  final Widget child;
  final bool isRequired;
  const _FormEntry({
    required this.label,
    required this.child,
    this.isRequired = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
              if (isRequired)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}

class _CharacteristicRow extends ConsumerWidget {
  final CharacteristicField field;
  final bool canBeRemoved;
  final VoidCallback onRemove;
  final InputDecoration baseInputDecoration;
  const _CharacteristicRow({
    required this.field,
    required this.canBeRemoved,
    required this.onRemove,
    required this.baseInputDecoration,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charTypesAsync = ref.watch(characteristicTypesProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: charTypesAsync.when(
              data: (allTypes) => Autocomplete<String>(
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text.isEmpty)
                    return const Iterable.empty();
                  return allTypes
                      .where(
                        (type) => type.name.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        ),
                      )
                      .map((e) => e.name);
                },
                onSelected: (option) => field.keyController.text = option,
                fieldViewBuilder:
                    (context, controller, focusNode, onSubmitted) {
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: baseInputDecoration.copyWith(
                          hintText: 'Property',
                        ),
                        onChanged: (v) => field.keyController.text = v,
                      );
                    },
              ),
              loading: () => TextFormField(
                controller: field.keyController,
                decoration: baseInputDecoration.copyWith(hintText: 'Property'),
              ),
              error: (e, s) => TextFormField(
                controller: field.keyController,
                decoration: baseInputDecoration.copyWith(hintText: 'Error'),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: field.valueController,
              decoration: baseInputDecoration.copyWith(hintText: 'Value'),
            ),
          ),
          if (canBeRemoved)
            IconButton(
              icon: Icon(
                PhosphorIconsRegular.trash,
                color: Colors.grey.shade400,
              ),
              hoverColor: Colors.red.withAlpha(20),
              highlightColor: Colors.red.withAlpha(40),
              onPressed: onRemove,
              tooltip: 'Remove characteristic',
            )
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }
}
