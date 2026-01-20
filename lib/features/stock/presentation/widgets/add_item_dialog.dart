import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/filters.dart';
import 'package:warehousesys/features/stock/data/models/variant.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

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
  int? _selectedUnitId;
  
  bool _isLoading = false;
  bool _isAddingCategory = false;
  
  Map<String, String> _suggestedCharacteristicsValues = {};

  final ImagePicker _picker = ImagePicker();
  List<String> _serverImageUrls = []; 
  List<File> _newImageFiles = [];     
  
  final String _baseUrl = 'http://localhost:8080';

  @override
  void initState() {
    super.initState();
    if (widget.itemToEdit != null) {
      final item = widget.itemToEdit!;
      _nameController.text = item.productName;
      _skuController.text = item.sku;
      _selectedCategoryId = item.categoryId;
      _selectedUnitId = item.unitId;
      _serverImageUrls = item.images.map((img) => img.url).toList();

      ref.read(detailedProductProvider(item.productId).future).then((product) {
        if (mounted) {
          setState(() {
            _descriptionController.text = product.description ?? '';
          });
        }
      });

      ref.read(productOptionsProvider(item.productId).future).then((optionsDto) {
        if (!mounted) return;

        final standardKeys = optionsDto.options.map((o) => o.type).toSet();
        
        setState(() {
          for (var f in _customCharacteristicFields) {
            f.dispose();
          }
          _customCharacteristicFields.clear();
          _suggestedCharacteristicsValues.clear();

          if (item.characteristics != null) {
            item.characteristics!.forEach((key, value) {
              if (standardKeys.contains(key)) {
                _suggestedCharacteristicsValues[key] = value;
              } else {
                final field = CharacteristicField();
                field.keyController.text = key;
                field.valueController.text = value;
                _customCharacteristicFields.add(field);
              }
            });
          }
        });
      });
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

  Future<void> _pickImages() async {
    try {
      final List<XFile> photos = await _picker.pickMultiImage();
      if (photos.isNotEmpty) {
        setState(() {
          _newImageFiles.addAll(photos.map((p) => File(p.path)));
        });
      }
    } catch (e) {
      debugPrint("Error picking images: $e");
    }
  }

  void _removeServerImage(int index) => setState(() => _serverImageUrls.removeAt(index));
  void _removeNewImage(int index) => setState(() => _newImageFiles.removeAt(index));

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
    final l10n = AppLocalizations.of(context)!;
    if (_formKey.currentState?.validate() != true) return;
    final isEditMode = widget.itemToEdit != null;

    if (!isEditMode && _selectedProduct == null && _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.enterProductNameError), backgroundColor: Colors.red));
      return;
    }
    if (!isEditMode && _selectedProduct == null && _selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.selectCategoryError), backgroundColor: Colors.red));
      return;
    }
    if (_selectedUnitId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Выберите единицу измерения"), backgroundColor: Colors.red));
      return;
    }

    setState(() => _isLoading = true);

    try {
      List<String> uploadedUrls = [];
      for (var file in _newImageFiles) {
        final url = await ref.read(stockRepositoryProvider).uploadImage(file);
        uploadedUrls.add(url);
      }
      final allImages = [..._serverImageUrls, ...uploadedUrls];

      final characteristics = {..._suggestedCharacteristicsValues};
      for (var field in _customCharacteristicFields) {
        if (field.keyController.text.isNotEmpty && field.valueController.text.isNotEmpty) {
          characteristics[field.keyController.text] = field.valueController.text;
        }
      }

      if (isEditMode) {
        await Future.wait([
          ref.read(stockRepositoryProvider).updateProduct(
                productId: widget.itemToEdit!.productId,
                name: _nameController.text,
                description: _descriptionController.text,
                categoryId: _selectedCategoryId,
              ),
          ref.read(stockRepositoryProvider).updateVariant(
                variantId: widget.itemToEdit!.id,
                sku: _skuController.text,
                characteristics: characteristics,
                imageUrls: allImages,
              ),
        ]);
      } else {
        if (_selectedProduct != null) {
          await ref.read(stockRepositoryProvider).createVariant(
                productId: _selectedProduct!.id,
                sku: _skuController.text,
                unitId: _selectedUnitId!,
                characteristics: characteristics,
                imageUrls: allImages,
              );
        } else {
          await ref.read(stockRepositoryProvider).createProductWithVariant(
                productName: _nameController.text,
                categoryId: _selectedCategoryId!,
                description: _descriptionController.text,
                sku: _skuController.text,
                unitId: _selectedUnitId!,
                characteristics: characteristics,
                imageUrls: allImages,
              );
        }
      }

      if (!mounted) return;
      
      if (isEditMode) {
        ref.invalidate(detailedProductProvider(widget.itemToEdit!.productId));
        ref.invalidate(variantStockProvider(widget.itemToEdit!.id));
        ref.invalidate(variantMovementsProvider(widget.itemToEdit!.id));
      }
      ref.invalidate(inventoryProvider);
      ref.invalidate(productsProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditMode ? l10n.itemUpdatedSuccess : l10n.itemAddedSuccess),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();

    } on DioException catch (e) {
      String errorMessage = l10n.unknownError;
      if (e.response?.statusCode == 500 && e.response?.data is Map) {
        final errText = e.response!.data['error'] as String?;
        if (errText != null && errText.contains('duplicate key')) {
           errorMessage = l10n.skuExistsError;
        } else {
           errorMessage = errText ?? l10n.serverError;
        }
      } else {
        errorMessage = l10n.networkError(e.message ?? '');
      }
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.generalError(e.toString())), backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleAddNewCategory() async {
    final name = _newCategoryController.text;
    final l10n = AppLocalizations.of(context)!;
    if (name.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final newCategory = await ref.read(stockRepositoryProvider).createCategory(name);
      ref.invalidate(categoriesProvider);
      setState(() {
        _selectedCategoryId = newCategory.id;
        _isAddingCategory = false;
        _newCategoryController.clear();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.categoryCreateError(e)), backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = widget.itemToEdit != null;
    final l10n = AppLocalizations.of(context)!;
    final baseInputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
    );

    return Dialog(
      backgroundColor: cardBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isEditMode ? 550 : 1152,
          maxHeight: MediaQuery.of(context).size.height * 0.90,
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
                          isEditMode ? l10n.editItemDialogTitle : l10n.addNewItemDialogTitle,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 24),
                        
                        _buildImagesSection(), 
                        const SizedBox(height: 24),

                        if (isEditMode)
                          _buildEditColumn(context, baseInputDecoration, l10n)
                        else
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildProductColumn(context, baseInputDecoration, l10n)),
                              const SizedBox(width: 32),
                              Expanded(child: _buildVariationColumn(context, baseInputDecoration, l10n)),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _buildActionsBar(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildImagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Фотографии", style: TextStyle(fontWeight: FontWeight.w600, color: textHeaderColor)),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              InkWell(
                onTap: _pickImages,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, spreadRadius: 0, offset: Offset.zero)
                    ]
                  ),
                  child: const Center(child: Icon(PhosphorIconsRegular.cameraPlus, size: 32, color: textGreyColor)),
                ),
              ),
              
              ..._serverImageUrls.asMap().entries.map((entry) {
                return _ImageThumb(
                  imageProvider: NetworkImage('$_baseUrl${entry.value}'),
                  onRemove: () => _removeServerImage(entry.key),
                );
              }),

              ..._newImageFiles.asMap().entries.map((entry) {
                return _ImageThumb(
                  imageProvider: FileImage(entry.value),
                  onRemove: () => _removeNewImage(entry.key),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductColumn(BuildContext context, InputDecoration baseInputDecoration, AppLocalizations l10n) {
    final productsAsync = ref.watch(productsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final isNewProduct = _selectedProduct == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(l10n.productSection),
        _FormEntry(
          label: l10n.selectExistingProduct,
          child: productsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Text('${l10n.error}: $e'),
            data: (products) => DropdownButtonFormField<Product>(
              value: _selectedProduct,
              hint: Text(l10n.selectProductHint),
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
                          _customCharacteristicFields.clear();
                          _skuController.clear();
                          _serverImageUrls.clear(); 
                        }),
                      )
                    : null,
              ),
              onChanged: (product) {
                if (product == null) return;
                ref.read(detailedProductProvider(product.id).future).then((detailedProduct) {
                  if (!mounted) return;
                  
                  ref.read(productOptionsProvider(product.id).future).then((options) {
                       setState(() {
                         _selectedProduct = detailedProduct;
                         _nameController.text = detailedProduct.name;
                         _descriptionController.text = detailedProduct.description ?? '';
                         _selectedCategoryId = detailedProduct.categoryId;
                         _serverImageUrls = [];
                         
                         _suggestedCharacteristicsValues.clear();
                         _customCharacteristicFields.clear();
                         _skuController.clear();
                       });
                  });
                });
              },
              items: products.map((p) => DropdownMenuItem<Product>(value: p, child: Text(p.name, overflow: TextOverflow.ellipsis))).toList(),
            ),
          ),
        ),
        _buildSeparator(l10n),
        AbsorbPointer(
          absorbing: !isNewProduct,
          child: Opacity(
            opacity: isNewProduct ? 1.0 : 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader(l10n.createNewProductSection, isSubHeader: true),
                _FormEntry(
                  label: l10n.newProductName,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: baseInputDecoration.copyWith(hintText: l10n.productNameHint),
                  ),
                ),
                _FormEntry(
                  label: l10n.categoryLabel,
                  child: _isAddingCategory
                      ? Row(
                          children: [
                            Expanded(child: TextFormField(controller: _newCategoryController, decoration: baseInputDecoration.copyWith(hintText: l10n.newCategoryNameHint), autofocus: true)),
                            IconButton(icon: const Icon(Icons.check), color: Colors.green, onPressed: _handleAddNewCategory),
                            IconButton(icon: const Icon(Icons.close), color: Colors.red, onPressed: () => setState(() => _isAddingCategory = false)),
                          ],
                        )
                      : categoriesAsync.when(
                          loading: () => const SizedBox.shrink(),
                          error: (e, s) => Text(l10n.error),
                          data: (categories) => DropdownButtonFormField<int>(
                            value: _selectedCategoryId,
                            hint: Text(l10n.selectCategoryHint),
                            decoration: baseInputDecoration,
                            onChanged: (value) {
                              if (value == -1) {
                                setState(() { _isAddingCategory = true; _selectedCategoryId = null; });
                              } else {
                                setState(() => _selectedCategoryId = value);
                              }
                            },
                            items: [
                              ...categories.map((c) => DropdownMenuItem<int>(value: c.id, child: Text(c.name))),
                              DropdownMenuItem<int>(value: -1, child: Row(children: [const Icon(Icons.add, size: 16), const SizedBox(width: 8), Text(l10n.addNewOption)])),
                            ],
                          ),
                        ),
                ),
                _FormEntry(
                  label: l10n.description,
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: baseInputDecoration.copyWith(hintText: l10n.descriptionHint),
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

  Widget _buildVariationColumn(BuildContext context, InputDecoration baseInputDecoration, AppLocalizations l10n) {
    final tempProduct = _selectedProduct;
    final unitsAsync = ref.watch(unitsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(l10n.variationSection),
        _FormEntry(
          label: l10n.tableSku,
          isRequired: true,
          child: TextFormField(
            controller: _skuController,
            decoration: baseInputDecoration.copyWith(hintText: l10n.skuHint),
            validator: (v) => (v?.isEmpty ?? true) ? l10n.requiredField : null,
          ),
        ),
        
        _FormEntry(
          label: l10n.unit, 
          isRequired: true,
          child: unitsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e,s) => Text("${l10n.error}: $e"),
            data: (units) => DropdownButtonFormField<int>(
              initialValue: _selectedUnitId,
              hint: const Text("Выберите ед. изм."),
              decoration: baseInputDecoration,
              items: units.map((u) => DropdownMenuItem(value: u.id, child: Text(u.name))).toList(),
              onChanged: (val) => setState(() => _selectedUnitId = val),
              validator: (v) => v == null ? l10n.requiredField : null,
            ),
          ),
        ),

        const SizedBox(height: 24),
        _SectionHeader(l10n.characteristicsSection, isSubHeader: true),
        if (tempProduct != null)
          Consumer(
            builder: (context, ref, child) {
              final optionsAsync = ref.watch(productOptionsProvider(tempProduct.id));
              return optionsAsync.when(
                loading: () => const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator())),
                error: (e, s) => Text('${l10n.error}: $e'),
                data: (data) {
                  if (data.options.isEmpty && _customCharacteristicFields.isEmpty) {
                    return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Text(l10n.noCharacteristicsYet, style: const TextStyle(color: textGreyColor)));
                  }
                  return Column(
                    children: data.options.map((option) => _FormEntry(
                            label: option.type,
                            child: TextFormField(
                              initialValue: _suggestedCharacteristicsValues[option.type],
                              decoration: baseInputDecoration.copyWith(hintText: l10n.valueFor(option.type)),
                              onChanged: (value) => setState(() => _suggestedCharacteristicsValues[option.type] = value),
                            ),
                          )).toList(),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              side: const BorderSide(color: borderColor, style: BorderStyle.solid, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            icon: Icon(PhosphorIconsRegular.plus, size: 16),
            label: Text(l10n.addNewCharacteristic),
            onPressed: _addCustomCharacteristicField,
          ),
        ),
      ],
    );
  }

  Widget _buildEditColumn(BuildContext context, InputDecoration baseInputDecoration, AppLocalizations l10n) {
    final unitsAsync = ref.watch(unitsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final tempProduct = Product(id: widget.itemToEdit!.productId, name: widget.itemToEdit!.productName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(l10n.productDetailsSection),
        _FormEntry(
          label: l10n.tableItemName,
          child: TextFormField(
            controller: _nameController,
            decoration: baseInputDecoration,
          ),
        ),
        _FormEntry(
          label: l10n.categoryLabel,
          child: _isAddingCategory
              ? Row(
                  children: [
                    Expanded(child: TextFormField(controller: _newCategoryController, decoration: baseInputDecoration.copyWith(hintText: l10n.newCategoryNameHint), autofocus: true)),
                    IconButton(icon: const Icon(Icons.check), color: Colors.green, onPressed: _handleAddNewCategory),
                    IconButton(icon: const Icon(Icons.close), color: Colors.red, onPressed: () => setState(() => _isAddingCategory = false)),
                  ],
                )
              : categoriesAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (e, s) => Text(l10n.error),
                  data: (categories) => DropdownButtonFormField<int>(
                    initialValue: _selectedCategoryId,
                    hint: Text(l10n.selectCategoryHint),
                    decoration: baseInputDecoration,
                    onChanged: (value) {
                      if (value == -1) {
                        setState(() { _isAddingCategory = true; _selectedCategoryId = null; });
                      } else {
                        setState(() => _selectedCategoryId = value);
                      }
                    },
                    items: [
                      ...categories.map((c) => DropdownMenuItem<int>(value: c.id, child: Text(c.name))),
                      DropdownMenuItem<int>(value: -1, child: Row(children: [const Icon(Icons.add, size: 16), const SizedBox(width: 8), Text(l10n.addNewOption)])),
                    ],
                  ),
                ),
        ),
        _FormEntry(
          label: l10n.description,
          child: TextFormField(
            controller: _descriptionController,
            decoration: baseInputDecoration,
            maxLines: 3,
          ),
        ),
        const Divider(height: 32),
        _SectionHeader(l10n.variationDetailsSection),
        _FormEntry(
          label: l10n.tableSku,
          isRequired: true,
          child: TextFormField(
            controller: _skuController,
            decoration: baseInputDecoration.copyWith(hintText: l10n.skuHint),
            validator: (v) => (v?.isEmpty ?? true) ? l10n.requiredField : null,
          ),
        ),
        
        _FormEntry(
          label: l10n.unit, 
          isRequired: true,
          child: unitsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e,s) => Text("${l10n.error}: $e"),
            data: (units) => DropdownButtonFormField<int>(
              initialValue: _selectedUnitId,
              hint: const Text("Выберите ед. изм."),
              decoration: baseInputDecoration,
              items: units.map((u) => DropdownMenuItem(value: u.id, child: Text(u.name))).toList(),
              onChanged: (val) => setState(() => _selectedUnitId = val),
            ),
          ),
        ),

        const SizedBox(height: 24),
        _SectionHeader(l10n.characteristicsSection, isSubHeader: true),
        Consumer(
          builder: (context, ref, child) {
            final optionsAsync = ref.watch(productOptionsProvider(tempProduct.id));
            return optionsAsync.when(
              loading: () => const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator())),
              error: (e, s) => Text('${l10n.error}: $e'),
              data: (data) {
                if (data.options.isEmpty && _customCharacteristicFields.isEmpty) {
                  return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Text(l10n.noCharacteristicsYet, style: const TextStyle(color: textGreyColor)));
                }
                return Column(
                  children: data.options.map((option) => _FormEntry(
                          label: option.type,
                          child: TextFormField(
                            initialValue: _suggestedCharacteristicsValues[option.type],
                            decoration: baseInputDecoration.copyWith(hintText: l10n.valueFor(option.type)),
                            onChanged: (value) => setState(() => _suggestedCharacteristicsValues[option.type] = value),
                          ),
                        )).toList(),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              side: const BorderSide(color: borderColor, style: BorderStyle.solid, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            icon: Icon(PhosphorIconsRegular.plus, size: 16),
            label: Text(l10n.addNewCharacteristic),
            onPressed: _addCustomCharacteristicField,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsBar(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: const BoxDecoration(
        color: tableHeaderColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.cancel)),
          const SizedBox(width: 16),
          _isLoading
              ? FilledButton.icon(
                  onPressed: null,
                  icon: const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
                  label: Text(l10n.save),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                )
              : FilledButton(
                  onPressed: _submitForm,
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                  child: Text(l10n.save),
                ),
        ],
      ),
    );
  }
  
  Widget _buildSeparator(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(l10n.orSeparator, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textGreyColor)),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

class _ImageThumb extends StatelessWidget {
  final ImageProvider imageProvider;
  final VoidCallback onRemove;
  const _ImageThumb({required this.imageProvider, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            border: Border.all(color: borderColor),
          ),
        ),
        Positioned(
          top: 4,
          right: 16,
          child: InkWell(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
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
       padding: EdgeInsets.only(bottom: isSubHeader ? 12 : 8, top: isSubHeader ? 16 : 0),
       child: Container(
         width: double.infinity,
         padding: isSubHeader ? null : const EdgeInsets.only(bottom: 8),
         decoration: BoxDecoration(border: isSubHeader ? null : const Border(bottom: BorderSide(color: borderColor))),
         child: Text(title, style: textStyle),
       ),
     );
  }
}

class _FormEntry extends StatelessWidget {
  final String label;
  final Widget child;
  final bool isRequired;
  const _FormEntry({required this.label, required this.child, this.isRequired = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Text(label, style: Theme.of(context).textTheme.bodyMedium), if (isRequired) const Text(' *', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))]),
          const SizedBox(height: 8),
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
  const _CharacteristicRow({required this.field, required this.canBeRemoved, required this.onRemove, required this.baseInputDecoration});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charTypesAsync = ref.watch(characteristicTypesProvider);
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: charTypesAsync.when(
              data: (allTypes) => Autocomplete<String>(
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text.isEmpty) return const Iterable.empty();
                  return allTypes.where((type) => type.name.toLowerCase().contains(textEditingValue.text.toLowerCase())).map((e) => e.name);
                },
                onSelected: (option) => field.keyController.text = option,
                fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
                  return TextFormField(controller: controller, focusNode: focusNode, decoration: baseInputDecoration.copyWith(hintText: l10n.propertyLabel), onChanged: (v) => field.keyController.text = v);
                },
              ),
              loading: () => TextFormField(controller: field.keyController, decoration: baseInputDecoration.copyWith(hintText: l10n.propertyLabel)),
              error: (e, s) => TextFormField(controller: field.keyController, decoration: baseInputDecoration.copyWith(hintText: l10n.error)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: TextFormField(controller: field.valueController, decoration: baseInputDecoration.copyWith(hintText: l10n.valueLabel))),
          if (canBeRemoved) IconButton(icon: Icon(PhosphorIconsRegular.trash, color: Colors.grey.shade400), onPressed: onRemove) else const SizedBox(width: 48),
        ],
      ),
    );
  }
}