import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @shipments.
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get shipments;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @counterparties.
  ///
  /// In en, this message translates to:
  /// **'Counterparties'**
  String get counterparties;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @warehouseManager.
  ///
  /// In en, this message translates to:
  /// **''**
  String get warehouseManager;

  /// No description provided for @expandPanel.
  ///
  /// In en, this message translates to:
  /// **'Expand panel'**
  String get expandPanel;

  /// No description provided for @collapsePanel.
  ///
  /// In en, this message translates to:
  /// **'Collapse panel'**
  String get collapsePanel;

  /// No description provided for @searchCounterparties.
  ///
  /// In en, this message translates to:
  /// **'Search counterparties...'**
  String get searchCounterparties;

  /// No description provided for @addCounterparty.
  ///
  /// In en, this message translates to:
  /// **'Add Counterparty'**
  String get addCounterparty;

  /// No description provided for @noCounterpartiesFound.
  ///
  /// In en, this message translates to:
  /// **'No counterparties found.'**
  String get noCounterpartiesFound;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @telegram.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegram;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @editCounterparty.
  ///
  /// In en, this message translates to:
  /// **'Edit Counterparty'**
  String get editCounterparty;

  /// No description provided for @deleteCounterparty.
  ///
  /// In en, this message translates to:
  /// **'Delete Counterparty'**
  String get deleteCounterparty;

  /// No description provided for @confirmDeletion.
  ///
  /// In en, this message translates to:
  /// **'Confirm deletion'**
  String get confirmDeletion;

  /// No description provided for @deleteCounterpartyConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete counterparty \"{name}\"? This action cannot be undone.'**
  String deleteCounterpartyConfirmation(String name);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @counterpartyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Counterparty successfully deleted'**
  String get counterpartyDeleted;

  /// No description provided for @deleteError.
  ///
  /// In en, this message translates to:
  /// **'Deletion error: {error}'**
  String deleteError(Object error);

  /// No description provided for @createIncomeDocument.
  ///
  /// In en, this message translates to:
  /// **'Create Income Document'**
  String get createIncomeDocument;

  /// No description provided for @createOutcomeDocument.
  ///
  /// In en, this message translates to:
  /// **'Create Outcome Document'**
  String get createOutcomeDocument;

  /// No description provided for @loadingBaseDocument.
  ///
  /// In en, this message translates to:
  /// **'Loading data from base document...'**
  String get loadingBaseDocument;

  /// No description provided for @basedOnDocument.
  ///
  /// In en, this message translates to:
  /// **'Based on document #{number}'**
  String basedOnDocument(String number);

  /// No description provided for @errorLoadingBaseDocument.
  ///
  /// In en, this message translates to:
  /// **'Error loading base document: {error}'**
  String errorLoadingBaseDocument(Object error);

  /// No description provided for @warehouseLabel.
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get warehouseLabel;

  /// No description provided for @selectWarehouseError.
  ///
  /// In en, this message translates to:
  /// **'Please select a warehouse'**
  String get selectWarehouseError;

  /// No description provided for @errorLoadingWarehouses.
  ///
  /// In en, this message translates to:
  /// **'Error loading warehouses'**
  String get errorLoadingWarehouses;

  /// No description provided for @counterpartyLabel.
  ///
  /// In en, this message translates to:
  /// **'Counterparty'**
  String get counterpartyLabel;

  /// No description provided for @searchCounterpartyHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a counterparty...'**
  String get searchCounterpartyHint;

  /// No description provided for @selectCounterparty.
  ///
  /// In en, this message translates to:
  /// **'Select Counterparty'**
  String get selectCounterparty;

  /// No description provided for @selectCounterpartyError.
  ///
  /// In en, this message translates to:
  /// **'Please select a counterparty'**
  String get selectCounterpartyError;

  /// No description provided for @errorLoadingCounterparties.
  ///
  /// In en, this message translates to:
  /// **'Error loading counterparties'**
  String get errorLoadingCounterparties;

  /// No description provided for @commentLabel.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get commentLabel;

  /// No description provided for @commentHint.
  ///
  /// In en, this message translates to:
  /// **'Add a comment, e.g. supplier invoice number'**
  String get commentHint;

  /// No description provided for @tableItem.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get tableItem;

  /// No description provided for @tableSku.
  ///
  /// In en, this message translates to:
  /// **'Sku'**
  String get tableSku;

  /// No description provided for @tableQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get tableQuantity;

  /// No description provided for @tableUnit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get tableUnit;

  /// No description provided for @tablePrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get tablePrice;

  /// No description provided for @tableSum.
  ///
  /// In en, this message translates to:
  /// **'Sum'**
  String get tableSum;

  /// No description provided for @noItemsAdded.
  ///
  /// In en, this message translates to:
  /// **'No items added'**
  String get noItemsAdded;

  /// No description provided for @selectItems.
  ///
  /// In en, this message translates to:
  /// **'Select Items'**
  String get selectItems;

  /// No description provided for @itemsError.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one item'**
  String get itemsError;

  /// No description provided for @quantityError.
  ///
  /// In en, this message translates to:
  /// **'Quantity must be greater than zero'**
  String get quantityError;

  /// No description provided for @totalItems.
  ///
  /// In en, this message translates to:
  /// **'Total items: {count}'**
  String totalItems(int count);

  /// No description provided for @totalSum.
  ///
  /// In en, this message translates to:
  /// **'Total Sum: {sum}'**
  String totalSum(String sum);

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @postAndClose.
  ///
  /// In en, this message translates to:
  /// **'Post & Close'**
  String get postAndClose;

  /// No description provided for @documentSavedDraft.
  ///
  /// In en, this message translates to:
  /// **'Document saved successfully as a draft!'**
  String get documentSavedDraft;

  /// No description provided for @documentPostedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Document posted successfully!'**
  String get documentPostedSuccess;

  /// No description provided for @saveError.
  ///
  /// In en, this message translates to:
  /// **'Error saving document: {error}'**
  String saveError(Object error);

  /// No description provided for @postError.
  ///
  /// In en, this message translates to:
  /// **'Error posting document: {error}'**
  String postError(Object error);

  /// No description provided for @incomeDocument.
  ///
  /// In en, this message translates to:
  /// **'Income Document'**
  String get incomeDocument;

  /// No description provided for @outcomeDocument.
  ///
  /// In en, this message translates to:
  /// **'Outcome Document'**
  String get outcomeDocument;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @statusPosted.
  ///
  /// In en, this message translates to:
  /// **'Posted'**
  String get statusPosted;

  /// No description provided for @deleteDocumentTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete Document'**
  String get deleteDocumentTooltip;

  /// No description provided for @confirmDocumentDeletionContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete document #{number}? This action cannot be undone.'**
  String confirmDocumentDeletionContent(String number);

  /// No description provided for @draftUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Draft updated successfully!'**
  String get draftUpdatedSuccess;

  /// No description provided for @draftUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Error updating draft: {error}'**
  String draftUpdateError(Object error);

  /// No description provided for @documentLoadingError.
  ///
  /// In en, this message translates to:
  /// **'Error loading document:\n{error}'**
  String documentLoadingError(Object error);

  /// No description provided for @noItemsInDocument.
  ///
  /// In en, this message translates to:
  /// **'No items in document'**
  String get noItemsInDocument;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @postDocument.
  ///
  /// In en, this message translates to:
  /// **'Post Document'**
  String get postDocument;

  /// No description provided for @createShipment.
  ///
  /// In en, this message translates to:
  /// **'Create Shipment'**
  String get createShipment;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @inventoryManagement.
  ///
  /// In en, this message translates to:
  /// **'Inventory Management'**
  String get inventoryManagement;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @searchItemsHint.
  ///
  /// In en, this message translates to:
  /// **'Search for items'**
  String get searchItemsHint;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data:\n{error}'**
  String errorLoadingData(Object error);

  /// No description provided for @noItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItemsFound;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategories;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @allLocations.
  ///
  /// In en, this message translates to:
  /// **'All Locations'**
  String get allLocations;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  /// No description provided for @allStatuses.
  ///
  /// In en, this message translates to:
  /// **'All Statuses'**
  String get allStatuses;

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get inStock;

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOfStock;

  /// No description provided for @tableItemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get tableItemName;

  /// No description provided for @tableCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get tableCategory;

  /// No description provided for @tableStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get tableStatus;

  /// No description provided for @tableActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get tableActions;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @confirmVariantDeletionContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete variant \"{name}\" (SKU: {sku})? This action cannot be undone.'**
  String confirmVariantDeletionContent(String name, String sku);

  /// No description provided for @itemDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Item successfully deleted'**
  String get itemDeletedSuccess;

  /// No description provided for @backToInventory.
  ///
  /// In en, this message translates to:
  /// **'Back to Inventory'**
  String get backToInventory;

  /// No description provided for @editItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get editItem;

  /// No description provided for @deleteItem.
  ///
  /// In en, this message translates to:
  /// **'Delete Item'**
  String get deleteItem;

  /// No description provided for @detailedInformation.
  ///
  /// In en, this message translates to:
  /// **'Detailed Information'**
  String get detailedInformation;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @attributes.
  ///
  /// In en, this message translates to:
  /// **'Attributes'**
  String get attributes;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @characteristics.
  ///
  /// In en, this message translates to:
  /// **'Characteristics'**
  String get characteristics;

  /// No description provided for @realTimeData.
  ///
  /// In en, this message translates to:
  /// **'Real-time Data'**
  String get realTimeData;

  /// No description provided for @stockLevels.
  ///
  /// In en, this message translates to:
  /// **'Stock Levels'**
  String get stockLevels;

  /// No description provided for @movementHistory.
  ///
  /// In en, this message translates to:
  /// **'Movement History (Last 10)'**
  String get movementHistory;

  /// No description provided for @errorLoadingDescription.
  ///
  /// In en, this message translates to:
  /// **'Error loading description: {error}'**
  String errorLoadingDescription(Object error);

  /// No description provided for @noMovementsFound.
  ///
  /// In en, this message translates to:
  /// **'No movements found.'**
  String get noMovementsFound;

  /// No description provided for @tableWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get tableWarehouse;

  /// No description provided for @tableOnHand.
  ///
  /// In en, this message translates to:
  /// **'On Hand'**
  String get tableOnHand;

  /// No description provided for @tableReserved.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get tableReserved;

  /// No description provided for @tableAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get tableAvailable;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @tableDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get tableDate;

  /// No description provided for @tableType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get tableType;

  /// No description provided for @tableDocument.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get tableDocument;

  /// No description provided for @searchOrdersHint.
  ///
  /// In en, this message translates to:
  /// **'Search orders...'**
  String get searchOrdersHint;

  /// No description provided for @createOrder.
  ///
  /// In en, this message translates to:
  /// **'Create Order'**
  String get createOrder;

  /// No description provided for @noOrdersFound.
  ///
  /// In en, this message translates to:
  /// **'No orders found.'**
  String get noOrdersFound;

  /// No description provided for @cardCounterparty.
  ///
  /// In en, this message translates to:
  /// **'Counterparty: {name}'**
  String cardCounterparty(String name);

  /// No description provided for @cardCreated.
  ///
  /// In en, this message translates to:
  /// **'Created: {date}'**
  String cardCreated(String date);

  /// No description provided for @cardItems.
  ///
  /// In en, this message translates to:
  /// **'Items: {count}'**
  String cardItems(int count);

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details →'**
  String get viewDetails;

  /// No description provided for @statusCanceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get statusCanceled;

  /// No description provided for @searchShipmentsHint.
  ///
  /// In en, this message translates to:
  /// **'Search shipments...'**
  String get searchShipmentsHint;

  /// No description provided for @noShipmentsFound.
  ///
  /// In en, this message translates to:
  /// **'No shipments found.'**
  String get noShipmentsFound;

  /// No description provided for @createDocument.
  ///
  /// In en, this message translates to:
  /// **'Create Document'**
  String get createDocument;

  /// No description provided for @chooseDocumentType.
  ///
  /// In en, this message translates to:
  /// **'Choose document type'**
  String get chooseDocumentType;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @outcome.
  ///
  /// In en, this message translates to:
  /// **'Outcome'**
  String get outcome;

  /// No description provided for @editItemDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get editItemDialogTitle;

  /// No description provided for @addNewItemDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Item'**
  String get addNewItemDialogTitle;

  /// No description provided for @enterProductNameError.
  ///
  /// In en, this message translates to:
  /// **'Enter new product name or select existing one'**
  String get enterProductNameError;

  /// No description provided for @selectCategoryError.
  ///
  /// In en, this message translates to:
  /// **'Category is required for new product'**
  String get selectCategoryError;

  /// No description provided for @itemUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Item successfully updated!'**
  String get itemUpdatedSuccess;

  /// No description provided for @itemAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Item successfully added!'**
  String get itemAddedSuccess;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error occurred'**
  String get unknownError;

  /// No description provided for @skuExistsError.
  ///
  /// In en, this message translates to:
  /// **'This SKU already exists. Please enter a unique one.'**
  String get skuExistsError;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Internal server error.'**
  String get serverError;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error: {message}'**
  String networkError(Object message);

  /// No description provided for @generalError.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String generalError(Object message);

  /// No description provided for @categoryCreateError.
  ///
  /// In en, this message translates to:
  /// **'Error creating category: {error}'**
  String categoryCreateError(Object error);

  /// No description provided for @orSeparator.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get orSeparator;

  /// No description provided for @productSection.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get productSection;

  /// No description provided for @selectExistingProduct.
  ///
  /// In en, this message translates to:
  /// **'Select Existing Product (optional)'**
  String get selectExistingProduct;

  /// No description provided for @selectProductHint.
  ///
  /// In en, this message translates to:
  /// **'Select a product...'**
  String get selectProductHint;

  /// No description provided for @createNewProductSection.
  ///
  /// In en, this message translates to:
  /// **'Create New Product'**
  String get createNewProductSection;

  /// No description provided for @newProductName.
  ///
  /// In en, this message translates to:
  /// **'New Product Name'**
  String get newProductName;

  /// No description provided for @productNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Super Widget'**
  String get productNameHint;

  /// No description provided for @newCategoryNameHint.
  ///
  /// In en, this message translates to:
  /// **'New category name'**
  String get newCategoryNameHint;

  /// No description provided for @selectCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get selectCategoryHint;

  /// No description provided for @addNewOption.
  ///
  /// In en, this message translates to:
  /// **'Add New...'**
  String get addNewOption;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the product'**
  String get descriptionHint;

  /// No description provided for @variationSection.
  ///
  /// In en, this message translates to:
  /// **'Variation'**
  String get variationSection;

  /// No description provided for @variationDetailsSection.
  ///
  /// In en, this message translates to:
  /// **'Variation Details'**
  String get variationDetailsSection;

  /// No description provided for @skuHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., SW-BLUE-LG-01'**
  String get skuHint;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @characteristicsSection.
  ///
  /// In en, this message translates to:
  /// **'Characteristics'**
  String get characteristicsSection;

  /// No description provided for @noCharacteristicsYet.
  ///
  /// In en, this message translates to:
  /// **'This item has no set characteristics yet.'**
  String get noCharacteristicsYet;

  /// No description provided for @valueFor.
  ///
  /// In en, this message translates to:
  /// **'Value for {type}'**
  String valueFor(String type);

  /// No description provided for @addNewCharacteristic.
  ///
  /// In en, this message translates to:
  /// **'Add New Characteristic'**
  String get addNewCharacteristic;

  /// No description provided for @productDetailsSection.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetailsSection;

  /// No description provided for @propertyLabel.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get propertyLabel;

  /// No description provided for @valueLabel.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get valueLabel;

  /// No description provided for @selectItemsFromStock.
  ///
  /// In en, this message translates to:
  /// **'Select Items from Stock'**
  String get selectItemsFromStock;

  /// No description provided for @searchItemsByNameSku.
  ///
  /// In en, this message translates to:
  /// **'Search for items by name or SKU...'**
  String get searchItemsByNameSku;

  /// No description provided for @addSelected.
  ///
  /// In en, this message translates to:
  /// **'Add Selected'**
  String get addSelected;

  /// No description provided for @tableInStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get tableInStock;

  /// No description provided for @editCounterpartyTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Counterparty'**
  String get editCounterpartyTitle;

  /// No description provided for @newCounterpartyTitle.
  ///
  /// In en, this message translates to:
  /// **'New Counterparty'**
  String get newCounterpartyTitle;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Acme Corp or John Doe'**
  String get nameHint;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneLabel;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. +1 555 123 4567'**
  String get phoneHint;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'contact@example.com'**
  String get emailHint;

  /// No description provided for @telegramLabel.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegramLabel;

  /// No description provided for @telegramHint.
  ///
  /// In en, this message translates to:
  /// **'@username'**
  String get telegramHint;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'City, street, building'**
  String get addressHint;

  /// No description provided for @counterpartyUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Counterparty updated successfully!'**
  String get counterpartyUpdatedSuccess;

  /// No description provided for @counterpartyCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Counterparty created successfully!'**
  String get counterpartyCreatedSuccess;

  /// No description provided for @incomeNote.
  ///
  /// In en, this message translates to:
  /// **'Income Note'**
  String get incomeNote;

  /// No description provided for @outcomeNote.
  ///
  /// In en, this message translates to:
  /// **'Outcome Note'**
  String get outcomeNote;

  /// No description provided for @documentErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading document: {error}'**
  String documentErrorLoading(Object error);

  /// No description provided for @basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInformation;

  /// No description provided for @documentContent.
  ///
  /// In en, this message translates to:
  /// **'Document Content'**
  String get documentContent;

  /// No description provided for @goToDocument.
  ///
  /// In en, this message translates to:
  /// **'Go to Document'**
  String get goToDocument;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date:'**
  String get dateLabel;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status:'**
  String get statusLabel;

  /// No description provided for @warehouseLabelColon.
  ///
  /// In en, this message translates to:
  /// **'Warehouse:'**
  String get warehouseLabelColon;

  /// No description provided for @counterpartyLabelColon.
  ///
  /// In en, this message translates to:
  /// **'Counterparty:'**
  String get counterpartyLabelColon;

  /// No description provided for @commentLabelColon.
  ///
  /// In en, this message translates to:
  /// **'Comment:'**
  String get commentLabelColon;

  /// No description provided for @tableNumberShort.
  ///
  /// In en, this message translates to:
  /// **'#'**
  String get tableNumberShort;

  /// No description provided for @tableItemSku.
  ///
  /// In en, this message translates to:
  /// **'ITEM (SKU)'**
  String get tableItemSku;

  /// No description provided for @tableQtyShort.
  ///
  /// In en, this message translates to:
  /// **'QTY'**
  String get tableQtyShort;

  /// No description provided for @overviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Overview of your warehouse operations'**
  String get overviewSubtitle;

  /// No description provided for @totalStock.
  ///
  /// In en, this message translates to:
  /// **'Total Stock'**
  String get totalStock;

  /// No description provided for @totalStockValue.
  ///
  /// In en, this message translates to:
  /// **'12,500 items'**
  String get totalStockValue;

  /// No description provided for @recentOperations.
  ///
  /// In en, this message translates to:
  /// **'Recent Operations'**
  String get recentOperations;

  /// No description provided for @recentOperationsValue.
  ///
  /// In en, this message translates to:
  /// **'320 operations'**
  String get recentOperationsValue;

  /// No description provided for @expectedDeliveries.
  ///
  /// In en, this message translates to:
  /// **'Expected Deliveries'**
  String get expectedDeliveries;

  /// No description provided for @expectedDeliveriesValue.
  ///
  /// In en, this message translates to:
  /// **'50 deliveries'**
  String get expectedDeliveriesValue;

  /// No description provided for @last30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get last30Days;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// No description provided for @last7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days'**
  String get last7Days;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @reportsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsPageTitle;

  /// No description provided for @reportsPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate and view various reports related to warehouse operations.'**
  String get reportsPageSubtitle;

  /// No description provided for @reportSelection.
  ///
  /// In en, this message translates to:
  /// **'Report Selection'**
  String get reportSelection;

  /// No description provided for @stockLevelsReport.
  ///
  /// In en, this message translates to:
  /// **'Stock Levels'**
  String get stockLevelsReport;

  /// No description provided for @stockLevelsDesc.
  ///
  /// In en, this message translates to:
  /// **'Current stock levels for all items'**
  String get stockLevelsDesc;

  /// No description provided for @movementHistoryReport.
  ///
  /// In en, this message translates to:
  /// **'Movement History'**
  String get movementHistoryReport;

  /// No description provided for @movementHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'History of item movements in and out'**
  String get movementHistoryDesc;

  /// No description provided for @supplierPerformanceReport.
  ///
  /// In en, this message translates to:
  /// **'Supplier Performance'**
  String get supplierPerformanceReport;

  /// No description provided for @supplierPerformanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Performance metrics for each supplier'**
  String get supplierPerformanceDesc;

  /// No description provided for @orderFulfillmentReport.
  ///
  /// In en, this message translates to:
  /// **'Order Fulfillment'**
  String get orderFulfillmentReport;

  /// No description provided for @orderFulfillmentDesc.
  ///
  /// In en, this message translates to:
  /// **'Details on order fulfillment rates'**
  String get orderFulfillmentDesc;

  /// No description provided for @inventoryTurnoverReport.
  ///
  /// In en, this message translates to:
  /// **'Inventory Turnover'**
  String get inventoryTurnoverReport;

  /// No description provided for @inventoryTurnoverDesc.
  ///
  /// In en, this message translates to:
  /// **'Rate at which inventory is sold'**
  String get inventoryTurnoverDesc;

  /// No description provided for @reportParameters.
  ///
  /// In en, this message translates to:
  /// **'Report Parameters'**
  String get reportParameters;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @itemFilter.
  ///
  /// In en, this message translates to:
  /// **'Item Filter (Optional)'**
  String get itemFilter;

  /// No description provided for @itemFilterHint.
  ///
  /// In en, this message translates to:
  /// **'Enter item name or SKU'**
  String get itemFilterHint;

  /// No description provided for @generateReport.
  ///
  /// In en, this message translates to:
  /// **'Generate Report'**
  String get generateReport;

  /// No description provided for @inventoryDocs.
  ///
  /// In en, this message translates to:
  /// **'Stocktaking'**
  String get inventoryDocs;

  /// No description provided for @createInventory.
  ///
  /// In en, this message translates to:
  /// **'New Stocktaking'**
  String get createInventory;

  /// No description provided for @searchInventoryHint.
  ///
  /// In en, this message translates to:
  /// **'Search stocktaking...'**
  String get searchInventoryHint;

  /// No description provided for @noInventoryFound.
  ///
  /// In en, this message translates to:
  /// **'No stocktaking documents found.'**
  String get noInventoryFound;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
