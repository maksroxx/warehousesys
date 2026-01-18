// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get dashboard => 'Dashboard';

  @override
  String get inventory => 'Inventory';

  @override
  String get orders => 'Orders';

  @override
  String get shipments => 'Shipments';

  @override
  String get reports => 'Reports';

  @override
  String get counterparties => 'Counterparties';

  @override
  String get settings => 'Settings';

  @override
  String get warehouseManager => '';

  @override
  String get expandPanel => 'Expand panel';

  @override
  String get collapsePanel => 'Collapse panel';

  @override
  String get searchCounterparties => 'Search counterparties...';

  @override
  String get addCounterparty => 'Add Counterparty';

  @override
  String get noCounterpartiesFound => 'No counterparties found.';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone';

  @override
  String get email => 'Email';

  @override
  String get telegram => 'Telegram';

  @override
  String get address => 'Address';

  @override
  String get editCounterparty => 'Edit Counterparty';

  @override
  String get deleteCounterparty => 'Delete Counterparty';

  @override
  String get confirmDeletion => 'Confirm deletion';

  @override
  String deleteCounterpartyConfirmation(String name) {
    return 'Are you sure you want to delete counterparty \"$name\"? This action cannot be undone.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get counterpartyDeleted => 'Counterparty successfully deleted';

  @override
  String deleteError(Object error) {
    return 'Deletion error: $error';
  }

  @override
  String get createIncomeDocument => 'Create Income Document';

  @override
  String get createOutcomeDocument => 'Create Outcome Document';

  @override
  String get loadingBaseDocument => 'Loading data from base document...';

  @override
  String basedOnDocument(String number) {
    return 'Based on document #$number';
  }

  @override
  String errorLoadingBaseDocument(Object error) {
    return 'Error loading base document: $error';
  }

  @override
  String get warehouseLabel => 'Warehouse';

  @override
  String get selectWarehouseError => 'Please select a warehouse';

  @override
  String get errorLoadingWarehouses => 'Error loading warehouses';

  @override
  String get counterpartyLabel => 'Counterparty';

  @override
  String get searchCounterpartyHint => 'Search for a counterparty...';

  @override
  String get selectCounterparty => 'Select Counterparty';

  @override
  String get selectCounterpartyError => 'Please select a counterparty';

  @override
  String get errorLoadingCounterparties => 'Error loading counterparties';

  @override
  String get commentLabel => 'Comment';

  @override
  String get commentHint => 'Add a comment, e.g. supplier invoice number';

  @override
  String get tableItem => 'Item';

  @override
  String get tableSku => 'Sku';

  @override
  String get tableQuantity => 'Quantity';

  @override
  String get tableUnit => 'Unit';

  @override
  String get tablePrice => 'Price';

  @override
  String get tableSum => 'Sum';

  @override
  String get noItemsAdded => 'No items added';

  @override
  String get selectItems => 'Select Items';

  @override
  String get itemsError => 'Please add at least one item';

  @override
  String get quantityError => 'Quantity must be greater than zero';

  @override
  String totalItems(int count) {
    return 'Total items: $count';
  }

  @override
  String totalSum(String sum) {
    return 'Total Sum: $sum';
  }

  @override
  String get save => 'Save';

  @override
  String get postAndClose => 'Post & Close';

  @override
  String get documentSavedDraft => 'Document saved successfully as a draft!';

  @override
  String get documentPostedSuccess => 'Document posted successfully!';

  @override
  String saveError(Object error) {
    return 'Error saving document: $error';
  }

  @override
  String postError(Object error) {
    return 'Error posting document: $error';
  }

  @override
  String get incomeDocument => 'Income Document';

  @override
  String get outcomeDocument => 'Outcome Document';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusPosted => 'Posted';

  @override
  String get deleteDocumentTooltip => 'Delete Document';

  @override
  String confirmDocumentDeletionContent(String number) {
    return 'Are you sure you want to delete document #$number? This action cannot be undone.';
  }

  @override
  String get draftUpdatedSuccess => 'Draft updated successfully!';

  @override
  String draftUpdateError(Object error) {
    return 'Error updating draft: $error';
  }

  @override
  String documentLoadingError(Object error) {
    return 'Error loading document:\n$error';
  }

  @override
  String get noItemsInDocument => 'No items in document';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get processing => 'Processing...';

  @override
  String get postDocument => 'Post Document';

  @override
  String get createShipment => 'Create Shipment';

  @override
  String get close => 'Close';

  @override
  String get inventoryManagement => 'Inventory Management';

  @override
  String get addItem => 'Add Item';

  @override
  String get searchItemsHint => 'Search for items';

  @override
  String errorLoadingData(Object error) {
    return 'Error loading data:\n$error';
  }

  @override
  String get noItemsFound => 'No items found';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get allCategories => 'All Categories';

  @override
  String get categoryLabel => 'Category';

  @override
  String get allLocations => 'All Locations';

  @override
  String get locationLabel => 'Location';

  @override
  String get allStatuses => 'All Statuses';

  @override
  String get inStock => 'In Stock';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get tableItemName => 'Item Name';

  @override
  String get tableCategory => 'Category';

  @override
  String get tableStatus => 'Status';

  @override
  String get tableActions => 'Actions';

  @override
  String get view => 'View';

  @override
  String confirmVariantDeletionContent(String name, String sku) {
    return 'Are you sure you want to delete variant \"$name\" (SKU: $sku)? This action cannot be undone.';
  }

  @override
  String get itemDeletedSuccess => 'Item successfully deleted';

  @override
  String get backToInventory => 'Back to Inventory';

  @override
  String get editItem => 'Edit Item';

  @override
  String get deleteItem => 'Delete Item';

  @override
  String get detailedInformation => 'Detailed Information';

  @override
  String get description => 'Description';

  @override
  String get attributes => 'Attributes';

  @override
  String get category => 'Category';

  @override
  String get unit => 'Unit';

  @override
  String get characteristics => 'Characteristics';

  @override
  String get realTimeData => 'Real-time Data';

  @override
  String get stockLevels => 'Stock Levels';

  @override
  String get movementHistory => 'Movement History (Last 10)';

  @override
  String errorLoadingDescription(Object error) {
    return 'Error loading description: $error';
  }

  @override
  String get noMovementsFound => 'No movements found.';

  @override
  String get tableWarehouse => 'Warehouse';

  @override
  String get tableOnHand => 'On Hand';

  @override
  String get tableReserved => 'Reserved';

  @override
  String get tableAvailable => 'Available';

  @override
  String get total => 'Total';

  @override
  String get tableDate => 'Date';

  @override
  String get tableType => 'Type';

  @override
  String get tableDocument => 'Document';

  @override
  String get searchOrdersHint => 'Search orders...';

  @override
  String get createOrder => 'Create Order';

  @override
  String get noOrdersFound => 'No orders found.';

  @override
  String cardCounterparty(String name) {
    return 'Counterparty: $name';
  }

  @override
  String cardCreated(String date) {
    return 'Created: $date';
  }

  @override
  String cardItems(int count) {
    return 'Items: $count';
  }

  @override
  String get viewDetails => 'View Details →';

  @override
  String get statusCanceled => 'Canceled';

  @override
  String get searchShipmentsHint => 'Search shipments...';

  @override
  String get noShipmentsFound => 'No shipments found.';

  @override
  String get createDocument => 'Create Document';

  @override
  String get chooseDocumentType => 'Choose document type';

  @override
  String get income => 'Income';

  @override
  String get outcome => 'Outcome';

  @override
  String get editItemDialogTitle => 'Edit Item';

  @override
  String get addNewItemDialogTitle => 'Add New Item';

  @override
  String get enterProductNameError =>
      'Enter new product name or select existing one';

  @override
  String get selectCategoryError => 'Category is required for new product';

  @override
  String get itemUpdatedSuccess => 'Item successfully updated!';

  @override
  String get itemAddedSuccess => 'Item successfully added!';

  @override
  String get unknownError => 'Unknown error occurred';

  @override
  String get skuExistsError =>
      'This SKU already exists. Please enter a unique one.';

  @override
  String get serverError => 'Internal server error.';

  @override
  String networkError(Object message) {
    return 'Network error: $message';
  }

  @override
  String generalError(Object message) {
    return 'Error: $message';
  }

  @override
  String categoryCreateError(Object error) {
    return 'Error creating category: $error';
  }

  @override
  String get orSeparator => 'Or';

  @override
  String get productSection => 'Product';

  @override
  String get selectExistingProduct => 'Select Existing Product (optional)';

  @override
  String get selectProductHint => 'Select a product...';

  @override
  String get createNewProductSection => 'Create New Product';

  @override
  String get newProductName => 'New Product Name';

  @override
  String get productNameHint => 'e.g., Super Widget';

  @override
  String get newCategoryNameHint => 'New category name';

  @override
  String get selectCategoryHint => 'Select a category';

  @override
  String get addNewOption => 'Add New...';

  @override
  String get descriptionHint => 'Describe the product';

  @override
  String get variationSection => 'Variation';

  @override
  String get variationDetailsSection => 'Variation Details';

  @override
  String get skuHint => 'e.g., SW-BLUE-LG-01';

  @override
  String get requiredField => 'Required';

  @override
  String get characteristicsSection => 'Characteristics';

  @override
  String get noCharacteristicsYet =>
      'This item has no set characteristics yet.';

  @override
  String valueFor(String type) {
    return 'Value for $type';
  }

  @override
  String get addNewCharacteristic => 'Add New Characteristic';

  @override
  String get productDetailsSection => 'Product Details';

  @override
  String get propertyLabel => 'Property';

  @override
  String get valueLabel => 'Value';

  @override
  String get selectItemsFromStock => 'Select Items from Stock';

  @override
  String get searchItemsByNameSku => 'Search for items by name or SKU...';

  @override
  String get addSelected => 'Add Selected';

  @override
  String get tableInStock => 'In Stock';

  @override
  String get editCounterpartyTitle => 'Edit Counterparty';

  @override
  String get newCounterpartyTitle => 'New Counterparty';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameHint => 'e.g. Acme Corp or John Doe';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get phoneHint => 'e.g. +1 555 123 4567';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'contact@example.com';

  @override
  String get telegramLabel => 'Telegram';

  @override
  String get telegramHint => '@username';

  @override
  String get addressLabel => 'Address';

  @override
  String get addressHint => 'City, street, building';

  @override
  String get counterpartyUpdatedSuccess => 'Counterparty updated successfully!';

  @override
  String get counterpartyCreatedSuccess => 'Counterparty created successfully!';

  @override
  String get incomeNote => 'Income Note';

  @override
  String get outcomeNote => 'Outcome Note';

  @override
  String documentErrorLoading(Object error) {
    return 'Error loading document: $error';
  }

  @override
  String get basicInformation => 'Basic Information';

  @override
  String get documentContent => 'Document Content';

  @override
  String get goToDocument => 'Go to Document';

  @override
  String get dateLabel => 'Date:';

  @override
  String get statusLabel => 'Status:';

  @override
  String get warehouseLabelColon => 'Warehouse:';

  @override
  String get counterpartyLabelColon => 'Counterparty:';

  @override
  String get commentLabelColon => 'Comment:';

  @override
  String get tableNumberShort => '#';

  @override
  String get tableItemSku => 'ITEM (SKU)';

  @override
  String get tableQtyShort => 'QTY';

  @override
  String get overviewSubtitle => 'Overview of your warehouse operations';

  @override
  String get totalStock => 'Total Stock';

  @override
  String get totalStockValue => '12,500 items';

  @override
  String get recentOperations => 'Recent Operations';

  @override
  String get recentOperationsValue => '320 operations';

  @override
  String get expectedDeliveries => 'Expected Deliveries';

  @override
  String get expectedDeliveriesValue => '50 deliveries';

  @override
  String get last30Days => 'Last 30 Days';

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get last7Days => 'Last 7 Days';

  @override
  String get mon => 'Mon';

  @override
  String get tue => 'Tue';

  @override
  String get wed => 'Wed';

  @override
  String get thu => 'Thu';

  @override
  String get fri => 'Fri';

  @override
  String get sat => 'Sat';

  @override
  String get sun => 'Sun';

  @override
  String get reportsPageTitle => 'Reports';

  @override
  String get reportsPageSubtitle =>
      'Generate and view various reports related to warehouse operations.';

  @override
  String get reportSelection => 'Report Selection';

  @override
  String get stockLevelsReport => 'Stock Levels';

  @override
  String get stockLevelsDesc => 'Current stock levels for all items';

  @override
  String get movementHistoryReport => 'Movement History';

  @override
  String get movementHistoryDesc => 'History of item movements in and out';

  @override
  String get supplierPerformanceReport => 'Supplier Performance';

  @override
  String get supplierPerformanceDesc => 'Performance metrics for each supplier';

  @override
  String get orderFulfillmentReport => 'Order Fulfillment';

  @override
  String get orderFulfillmentDesc => 'Details on order fulfillment rates';

  @override
  String get inventoryTurnoverReport => 'Inventory Turnover';

  @override
  String get inventoryTurnoverDesc => 'Rate at which inventory is sold';

  @override
  String get reportParameters => 'Report Parameters';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String get itemFilter => 'Item Filter (Optional)';

  @override
  String get itemFilterHint => 'Enter item name or SKU';

  @override
  String get generateReport => 'Generate Report';

  @override
  String get inventoryDocs => 'Stocktaking';

  @override
  String get createInventory => 'New Stocktaking';

  @override
  String get searchInventoryHint => 'Search stocktaking...';

  @override
  String get noInventoryFound => 'No stocktaking documents found.';
}
