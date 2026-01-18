// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get dashboard => 'Обзор';

  @override
  String get inventory => 'Склад';

  @override
  String get orders => 'Заказы';

  @override
  String get shipments => 'Отгрузки';

  @override
  String get reports => 'Отчеты';

  @override
  String get counterparties => 'Контрагенты';

  @override
  String get settings => 'Настройки';

  @override
  String get warehouseManager => '';

  @override
  String get expandPanel => 'Развернуть панель';

  @override
  String get collapsePanel => 'Свернуть панель';

  @override
  String get searchCounterparties => 'Поиск контрагентов...';

  @override
  String get addCounterparty => 'Добавить контрагента';

  @override
  String get noCounterpartiesFound => 'Контрагенты не найдены.';

  @override
  String get name => 'Имя';

  @override
  String get phone => 'Телефон';

  @override
  String get email => 'Email';

  @override
  String get telegram => 'Telegram';

  @override
  String get address => 'Адрес';

  @override
  String get editCounterparty => 'Редактировать';

  @override
  String get deleteCounterparty => 'Удалить';

  @override
  String get confirmDeletion => 'Подтвердите удаление';

  @override
  String deleteCounterpartyConfirmation(String name) {
    return 'Вы уверены, что хотите удалить контрагента \"$name\"? Это действие нельзя будет отменить.';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get counterpartyDeleted => 'Контрагент успешно удален';

  @override
  String deleteError(Object error) {
    return 'Ошибка удаления: $error';
  }

  @override
  String get createIncomeDocument => 'Создание прихода';

  @override
  String get createOutcomeDocument => 'Создание расхода';

  @override
  String get loadingBaseDocument => 'Загрузка данных из документа-основания...';

  @override
  String basedOnDocument(String number) {
    return 'На основании документа №$number';
  }

  @override
  String errorLoadingBaseDocument(Object error) {
    return 'Ошибка загрузки основания: $error';
  }

  @override
  String get warehouseLabel => 'Склад';

  @override
  String get selectWarehouseError => 'Выберите склад';

  @override
  String get errorLoadingWarehouses => 'Ошибка загрузки складов';

  @override
  String get counterpartyLabel => 'Контрагент';

  @override
  String get searchCounterpartyHint => 'Поиск контрагента...';

  @override
  String get selectCounterparty => 'Выбор контрагента';

  @override
  String get selectCounterpartyError => 'Выберите контрагента';

  @override
  String get errorLoadingCounterparties => 'Ошибка загрузки контрагентов';

  @override
  String get commentLabel => 'Комментарий';

  @override
  String get commentHint => 'Добавьте комментарий (напр. номер накладной)';

  @override
  String get tableItem => 'Товар';

  @override
  String get tableSku => 'Артикул';

  @override
  String get tableQuantity => 'Кол-во';

  @override
  String get tableUnit => 'Ед.';

  @override
  String get tablePrice => 'Цена';

  @override
  String get tableSum => 'Сумма';

  @override
  String get noItemsAdded => 'Нет добавленных позиций';

  @override
  String get selectItems => 'Выбрать товары';

  @override
  String get itemsError => 'Добавьте хотя бы одну позицию';

  @override
  String get quantityError => 'Количество должно быть больше нуля';

  @override
  String totalItems(int count) {
    return 'Позиций: $count';
  }

  @override
  String totalSum(String sum) {
    return 'Сумма: $sum';
  }

  @override
  String get save => 'Сохранить';

  @override
  String get postAndClose => 'Провести и закрыть';

  @override
  String get documentSavedDraft => 'Документ сохранен как черновик!';

  @override
  String get documentPostedSuccess => 'Документ успешно проведен!';

  @override
  String saveError(Object error) {
    return 'Ошибка сохранения: $error';
  }

  @override
  String postError(Object error) {
    return 'Ошибка проведения: $error';
  }

  @override
  String get incomeDocument => 'Приход';

  @override
  String get outcomeDocument => 'Расход';

  @override
  String get statusDraft => 'Черновик';

  @override
  String get statusPosted => 'Проведен';

  @override
  String get deleteDocumentTooltip => 'Удалить документ';

  @override
  String confirmDocumentDeletionContent(String number) {
    return 'Вы уверены, что хотите удалить документ №$number? Это действие нельзя отменить.';
  }

  @override
  String get draftUpdatedSuccess => 'Черновик успешно обновлен!';

  @override
  String draftUpdateError(Object error) {
    return 'Ошибка обновления черновика: $error';
  }

  @override
  String documentLoadingError(Object error) {
    return 'Ошибка загрузки документа:\n$error';
  }

  @override
  String get noItemsInDocument => 'В документе нет товаров';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get processing => 'Обработка...';

  @override
  String get postDocument => 'Провести документ';

  @override
  String get createShipment => 'Создать отгрузку';

  @override
  String get close => 'Закрыть';

  @override
  String get inventoryManagement => 'Управление запасами';

  @override
  String get addItem => 'Добавить товар';

  @override
  String get searchItemsHint => 'Поиск товаров';

  @override
  String errorLoadingData(Object error) {
    return 'Ошибка загрузки данных:\n$error';
  }

  @override
  String get noItemsFound => 'Товары не найдены';

  @override
  String get loading => 'Загрузка...';

  @override
  String get error => 'Ошибка';

  @override
  String get allCategories => 'Все категории';

  @override
  String get categoryLabel => 'Категория';

  @override
  String get allLocations => 'Все локации';

  @override
  String get locationLabel => 'Локация';

  @override
  String get allStatuses => 'Все статусы';

  @override
  String get inStock => 'В наличии';

  @override
  String get outOfStock => 'Нет в наличии';

  @override
  String get tableItemName => 'Наименование';

  @override
  String get tableCategory => 'Категория';

  @override
  String get tableStatus => 'Статус';

  @override
  String get tableActions => 'Действия';

  @override
  String get view => 'Просмотр';

  @override
  String confirmVariantDeletionContent(String name, String sku) {
    return 'Вы уверены, что хотите удалить вариант \"$name\" (SKU: $sku)? Это действие нельзя отменить.';
  }

  @override
  String get itemDeletedSuccess => 'Товар успешно удален';

  @override
  String get backToInventory => 'Назад к списку';

  @override
  String get editItem => 'Редактировать товар';

  @override
  String get deleteItem => 'Удалить товар';

  @override
  String get detailedInformation => 'Детальная информация';

  @override
  String get description => 'Описание';

  @override
  String get attributes => 'Атрибуты';

  @override
  String get category => 'Категория';

  @override
  String get unit => 'Ед. измерения';

  @override
  String get characteristics => 'Характеристики';

  @override
  String get realTimeData => 'Данные в реальном времени';

  @override
  String get stockLevels => 'Уровень запасов';

  @override
  String get movementHistory => 'История движений (последние 10)';

  @override
  String errorLoadingDescription(Object error) {
    return 'Ошибка загрузки описания: $error';
  }

  @override
  String get noMovementsFound => 'Движений не найдено.';

  @override
  String get tableWarehouse => 'Склад';

  @override
  String get tableOnHand => 'В наличии';

  @override
  String get tableReserved => 'Резерв';

  @override
  String get tableAvailable => 'Доступно';

  @override
  String get total => 'Итого';

  @override
  String get tableDate => 'Дата';

  @override
  String get tableType => 'Тип';

  @override
  String get tableDocument => 'Документ';

  @override
  String get searchOrdersHint => 'Поиск заказов...';

  @override
  String get createOrder => 'Создать заказ';

  @override
  String get noOrdersFound => 'Заказы не найдены.';

  @override
  String cardCounterparty(String name) {
    return 'Контрагент: $name';
  }

  @override
  String cardCreated(String date) {
    return 'Создано: $date';
  }

  @override
  String cardItems(int count) {
    return 'Позиций: $count';
  }

  @override
  String get viewDetails => 'Подробнее →';

  @override
  String get statusCanceled => 'Отменен';

  @override
  String get searchShipmentsHint => 'Поиск документов...';

  @override
  String get noShipmentsFound => 'Документы не найдены.';

  @override
  String get createDocument => 'Создать документ';

  @override
  String get chooseDocumentType => 'Выберите тип документа';

  @override
  String get income => 'Приход';

  @override
  String get outcome => 'Расход';

  @override
  String get editItemDialogTitle => 'Редактировать товар';

  @override
  String get addNewItemDialogTitle => 'Добавить новый товар';

  @override
  String get enterProductNameError =>
      'Введите название нового продукта или выберите существующий';

  @override
  String get selectCategoryError =>
      'Для нового продукта необходимо выбрать категорию';

  @override
  String get itemUpdatedSuccess => 'Товар успешно обновлен!';

  @override
  String get itemAddedSuccess => 'Товар успешно добавлен!';

  @override
  String get unknownError => 'Произошла неизвестная ошибка';

  @override
  String get skuExistsError =>
      'Этот Артикул (SKU) уже существует. Пожалуйста, введите уникальный.';

  @override
  String get serverError => 'Внутренняя ошибка сервера.';

  @override
  String networkError(Object message) {
    return 'Ошибка сети: $message';
  }

  @override
  String generalError(Object message) {
    return 'Ошибка: $message';
  }

  @override
  String categoryCreateError(Object error) {
    return 'Ошибка создания категории: $error';
  }

  @override
  String get orSeparator => 'Или';

  @override
  String get productSection => 'Продукт';

  @override
  String get selectExistingProduct => 'Выбрать существующий (опционально)';

  @override
  String get selectProductHint => 'Выберите продукт...';

  @override
  String get createNewProductSection => 'Создать новый продукт';

  @override
  String get newProductName => 'Название нового продукта';

  @override
  String get productNameHint => 'напр., Супер Виджет';

  @override
  String get newCategoryNameHint => 'Название новой категории';

  @override
  String get selectCategoryHint => 'Выберите категорию';

  @override
  String get addNewOption => 'Добавить новую...';

  @override
  String get descriptionHint => 'Опишите продукт';

  @override
  String get variationSection => 'Вариант';

  @override
  String get variationDetailsSection => 'Детали варианта';

  @override
  String get skuHint => 'напр., SW-BLUE-LG-01';

  @override
  String get requiredField => 'Обязательно';

  @override
  String get characteristicsSection => 'Характеристики';

  @override
  String get noCharacteristicsYet =>
      'У этого товара еще нет заданных характеристик.';

  @override
  String valueFor(String type) {
    return 'Значение для $type';
  }

  @override
  String get addNewCharacteristic => 'Добавить характеристику';

  @override
  String get productDetailsSection => 'Детали продукта';

  @override
  String get propertyLabel => 'Свойство';

  @override
  String get valueLabel => 'Значение';

  @override
  String get selectItemsFromStock => 'Выберите товары со склада';

  @override
  String get searchItemsByNameSku => 'Поиск по названию или артикулу...';

  @override
  String get addSelected => 'Добавить выбранные';

  @override
  String get tableInStock => 'В наличии';

  @override
  String get editCounterpartyTitle => 'Редактировать контрагента';

  @override
  String get newCounterpartyTitle => 'Новый контрагент';

  @override
  String get nameLabel => 'Наименование';

  @override
  String get nameHint => 'ООО \"Ромашка\" или Иван Иванов';

  @override
  String get phoneLabel => 'Телефон';

  @override
  String get phoneHint => '+7 (999) 123-45-67';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'contact@example.com';

  @override
  String get telegramLabel => 'Telegram';

  @override
  String get telegramHint => '@username';

  @override
  String get addressLabel => 'Адрес';

  @override
  String get addressHint => 'Город, улица, дом';

  @override
  String get counterpartyUpdatedSuccess => 'Контрагент успешно обновлен!';

  @override
  String get counterpartyCreatedSuccess => 'Контрагент успешно создан!';

  @override
  String get incomeNote => 'Приходная накладная';

  @override
  String get outcomeNote => 'Расходная накладная';

  @override
  String documentErrorLoading(Object error) {
    return 'Ошибка загрузки документа: $error';
  }

  @override
  String get basicInformation => 'Основная информация';

  @override
  String get documentContent => 'Содержимое документа';

  @override
  String get goToDocument => 'Перейти к документу';

  @override
  String get dateLabel => 'Дата:';

  @override
  String get statusLabel => 'Статус:';

  @override
  String get warehouseLabelColon => 'Склад:';

  @override
  String get counterpartyLabelColon => 'Контрагент:';

  @override
  String get commentLabelColon => 'Комментарий:';

  @override
  String get tableNumberShort => '#';

  @override
  String get tableItemSku => 'ТОВАР (SKU)';

  @override
  String get tableQtyShort => 'КОЛ-ВО';

  @override
  String get overviewSubtitle => 'Обзор операций вашего склада';

  @override
  String get totalStock => 'Всего товаров';

  @override
  String get totalStockValue => '12,500 шт.';

  @override
  String get recentOperations => 'Недавние операции';

  @override
  String get recentOperationsValue => '320 операций';

  @override
  String get expectedDeliveries => 'Ожидаемые поставки';

  @override
  String get expectedDeliveriesValue => '50 поставок';

  @override
  String get last30Days => 'За 30 дней';

  @override
  String get recentActivity => 'Недавняя активность';

  @override
  String get last7Days => 'За 7 дней';

  @override
  String get mon => 'Пн';

  @override
  String get tue => 'Вт';

  @override
  String get wed => 'Ср';

  @override
  String get thu => 'Чт';

  @override
  String get fri => 'Пт';

  @override
  String get sat => 'Сб';

  @override
  String get sun => 'Вс';

  @override
  String get reportsPageTitle => 'Отчеты';

  @override
  String get reportsPageSubtitle =>
      'Генерация и просмотр отчетов по складским операциям.';

  @override
  String get reportSelection => 'Выбор отчета';

  @override
  String get stockLevelsReport => 'Уровни запасов';

  @override
  String get stockLevelsDesc => 'Текущие остатки по всем товарам';

  @override
  String get movementHistoryReport => 'История движений';

  @override
  String get movementHistoryDesc => 'История приходов и расходов товаров';

  @override
  String get supplierPerformanceReport => 'Эффективность поставщиков';

  @override
  String get supplierPerformanceDesc =>
      'Метрики производительности по поставщикам';

  @override
  String get orderFulfillmentReport => 'Исполнение заказов';

  @override
  String get orderFulfillmentDesc => 'Детали по уровню выполнения заказов';

  @override
  String get inventoryTurnoverReport => 'Обороты запасов';

  @override
  String get inventoryTurnoverDesc => 'Скорость продажи товарных запасов';

  @override
  String get reportParameters => 'Параметры отчета';

  @override
  String get startDate => 'Дата начала';

  @override
  String get endDate => 'Дата окончания';

  @override
  String get itemFilter => 'Фильтр по товару (необязательно)';

  @override
  String get itemFilterHint => 'Введите название или артикул';

  @override
  String get generateReport => 'Сформировать отчет';

  @override
  String get inventoryDocs => 'Инвентаризация';

  @override
  String get createInventory => 'Создать инвентаризацию';

  @override
  String get searchInventoryHint => 'Поиск инвентаризаций...';

  @override
  String get noInventoryFound => 'Инвентаризации не найдены.';
}
