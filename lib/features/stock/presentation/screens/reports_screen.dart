import 'dart:io';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  int _selectedReportIndex = 0;

  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  int? _selectedWarehouseId;
  final TextEditingController _taxController = TextEditingController();
  
  String _selectedFormat = 'pdf'; // 'pdf', 'xlsx', 'csv'

  bool _isLoading = false;

  final List<Map<String, dynamic>> _availableReports = [
    {
      'id': 'profit',
      'icon': PhosphorIconsFill.coins,
      'color': Colors.green,
      'title': 'Валовая прибыль (FIFO)',
      'desc': 'Финансовый результат: Продажи минус Себестоимость (по партиям). Расчет налога и чистой прибыли.'
    },
    {
      'id': 'stock',
      'icon': PhosphorIconsFill.package,
      'color': Colors.blue,
      'title': 'Оценка склада',
      'desc': 'Ведомость текущих остатков на складах в количественном и денежном выражении.'
    },
    {
      'id': 'movements',
      'icon': PhosphorIconsFill.arrowsLeftRight,
      'color': Colors.orange,
      'title': 'Движения товаров',
      'desc': 'Детальный журнал всех складских операций (Приход, Расход, Перемещение) за период.'
    },
    {
      'id': 'customers',
      'icon': PhosphorIconsFill.usersThree,
      'color': Colors.purple,
      'title': 'Продажи по клиентам',
      'desc': 'Рейтинг покупателей по объему выручки и количеству сделок.'
    },
    {
      'id': 'abc',
      'icon': PhosphorIconsFill.chartLineUp,
      'color': Colors.redAccent,
      'title': 'Рейтинг продаж (ABC)',
      'desc': 'Топ товаров по выручке. Класс А - лидеры (80% выручки), В - середина, С - аутсайдеры.'
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(warehousesProvider);
    });
  }

  @override
  void dispose() {
    _taxController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: primaryColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<Uint8List?> _fetchReportBytes({String? overrideFormat}) async {
    final reportInfo = _availableReports[_selectedReportIndex];
    final reportId = reportInfo['id'] as String;

    setState(() => _isLoading = true);

    try {
      double? taxRate;
      if (_taxController.text.isNotEmpty && reportId == 'profit') {
        taxRate = double.tryParse(_taxController.text.replaceAll(',', '.'));
      }

      final bytes = await ref.read(stockRepositoryProvider).downloadReport(
        type: reportId,
        format: overrideFormat ?? _selectedFormat, 
        dateFrom: _startDate,
        dateTo: _endDate,
        warehouseId: _selectedWarehouseId,
        taxRate: taxRate,
      );
      
      return Uint8List.fromList(bytes);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ошибка загрузки: $e"), backgroundColor: Colors.red),
        );
      }
      return null;
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  ({String ext, MimeType mime}) _getFileInfo() {
    switch (_selectedFormat) {
      case 'xlsx':
      case 'excel':
        return (ext: 'xlsx', mime: MimeType.microsoftExcel);
      case 'csv':
        return (ext: 'csv', mime: MimeType.csv);
      default:
        return (ext: 'pdf', mime: MimeType.pdf);
    }
  }

  Future<void> _onPreviewTap() async {
    final bytes = await _fetchReportBytes(overrideFormat: 'pdf');
    if (bytes == null || !mounted) return;

    final reportTitle = _availableReports[_selectedReportIndex]['title'];

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900, maxHeight: 800),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Предпросмотр: $reportTitle",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: PdfPreview(
                  build: (format) => bytes,
                  useActions: false,
                  canChangeOrientation: false,
                  canChangePageFormat: false,
                  maxPageWidth: 700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSaveTap() async {
    final bytes = await _fetchReportBytes();
    if (bytes == null || !mounted) return;

    final reportId = _availableReports[_selectedReportIndex]['id'];
    final fileInfo = _getFileInfo();
    final name = "Report_${reportId}_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}";

    try {
      if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
        await FileSaver.instance.saveFile(
          name: name,
          bytes: bytes,
          ext: fileInfo.ext,
          mimeType: fileInfo.mime,
        );
      } else {
        final path = await FileSaver.instance.saveFile(
          name: name,
          bytes: bytes,
          ext: fileInfo.ext,
          mimeType: fileInfo.mime,
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Сохранено: $path"),
              backgroundColor: Colors.green,
              action: SnackBarAction(
                label: 'Открыть',
                textColor: Colors.white,
                onPressed: () => OpenFilex.open(path),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ошибка сохранения: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _onShareTap() async {
    final bytes = await _fetchReportBytes();
    if (bytes == null || !mounted) return;

    final reportId = _availableReports[_selectedReportIndex]['id'];
    final reportTitle = _availableReports[_selectedReportIndex]['title'];
    final fileInfo = _getFileInfo();
    
    try {
      final dir = await getTemporaryDirectory();
      final fileName = "Report_${reportId}_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.${fileInfo.ext}";
      final file = File("${dir.path}/$fileName");
      await file.writeAsBytes(bytes, flush: true);

      if (mounted) {
        await Share.shareXFiles(
          [XFile(file.path)],
          subject: 'Отчет: $reportTitle',
          text: 'Сформировано в FlowKeeper',
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ошибка отправки: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final warehousesAsync = ref.watch(warehousesProvider);

    final currentReport = _availableReports[_selectedReportIndex];
    final String reportId = currentReport['id'];
    final bool showDates = reportId != 'stock'; 
    final bool showTax = reportId == 'profit';
    final bool showWarehouse = reportId != 'customers';

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.reports, style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(l10n.reportsPageSubtitle, style: textTheme.bodyMedium?.copyWith(color: textGreyColor)),
            
            const SizedBox(height: 32),

            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              l10n.reportSelection,
                              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                              itemCount: _availableReports.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final report = _availableReports[index];
                                return _ReportTypeCard(
                                  title: report['title'],
                                  description: report['desc'],
                                  icon: report['icon'],
                                  iconColor: report['color'],
                                  isSelected: index == _selectedReportIndex,
                                  onTap: () => setState(() => _selectedReportIndex = index),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 32),

                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.reportParameters, 
                            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
                          ),
                          const SizedBox(height: 24),
                          
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (showDates) ...[
                                    Text("Период", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(child: _DateSelector(label: l10n.startDate, date: _startDate, onTap: () => _selectDate(context, true))),
                                        const SizedBox(width: 16),
                                        Expanded(child: _DateSelector(label: l10n.endDate, date: _endDate, onTap: () => _selectDate(context, false))),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                  
                                  if (showWarehouse) ...[
                                    Text(l10n.warehouseLabel, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 12),
                                    warehousesAsync.when(
                                      loading: () => const LinearProgressIndicator(),
                                      error: (e, s) => Text("${l10n.error}: $e"),
                                      data: (warehouses) => Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<int?>(
                                            value: _selectedWarehouseId,
                                            isExpanded: true,
                                            hint: Text(l10n.allLocations),
                                            items: [
                                              DropdownMenuItem<int?>(value: null, child: Text(l10n.allLocations)),
                                              ...warehouses.map((w) => DropdownMenuItem(value: w.id, child: Text(w.name))),
                                            ],
                                            onChanged: (val) => setState(() => _selectedWarehouseId = val),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                  ],

                                  if (showTax) ...[
                                    Text("Налоговая ставка (%)", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: _taxController,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.,]?\d*'))],
                                      decoration: InputDecoration(
                                        hintText: "Например: 15",
                                        suffixText: "%",
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: borderColor)),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: borderColor)),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Будет рассчитан налог с прибыли и чистая прибыль.",
                                      style: TextStyle(fontSize: 11, color: textGreyColor),
                                    ),
                                    const SizedBox(height: 24),
                                  ],

                                  Text("Формат файла", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 12),
                                  SegmentedButton<String>(
                                    segments: const [
                                      ButtonSegment(value: 'pdf', label: Text('PDF'), icon: Icon(PhosphorIconsRegular.filePdf)),
                                      ButtonSegment(value: 'xlsx', label: Text('Excel'), icon: Icon(PhosphorIconsRegular.fileXls)),
                                      ButtonSegment(value: 'csv', label: Text('CSV'), icon: Icon(PhosphorIconsRegular.fileCsv)),
                                    ],
                                    selected: {_selectedFormat},
                                    onSelectionChanged: (Set<String> newSelection) {
                                      setState(() {
                                        _selectedFormat = newSelection.first;
                                      });
                                    },
                                    showSelectedIcon: false,
                                    style: ButtonStyle(
                                      visualDensity: VisualDensity.compact,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: WidgetStateProperty.resolveWith((states) {
                                         if (states.contains(WidgetState.selected)) return primaryColor.withOpacity(0.1);
                                         return null;
                                      }),
                                      foregroundColor: WidgetStateProperty.resolveWith((states) {
                                         if (states.contains(WidgetState.selected)) return primaryColor;
                                         return textDarkColor;
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          if (_selectedFormat == 'pdf') ...[
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: OutlinedButton.icon(
                                onPressed: _isLoading ? null : _onPreviewTap,
                                icon: const Icon(PhosphorIconsRegular.eye),
                                label: const Text("Предпросмотр документа"),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  side: const BorderSide(color: primaryColor),
                                  foregroundColor: const Color.fromARGB(255, 75, 134, 194),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],

                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 56,
                                  child: OutlinedButton.icon(
                                    onPressed: _isLoading ? null : _onShareTap,
                                    icon: const Icon(PhosphorIconsRegular.shareNetwork),
                                    label: const Text("Поделиться"),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: borderColor),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: SizedBox(
                                  height: 56,
                                  child: FilledButton.icon(
                                    onPressed: _isLoading ? null : _onSaveTap,
                                    icon: _isLoading 
                                      ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                      : const Icon(PhosphorIconsRegular.downloadSimple),
                                    label: Text(
                                      _isLoading ? "Генерация..." : "Скачать",
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReportTypeCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: isSelected ? primaryColor : textDarkColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(color: textGreyColor, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(PhosphorIconsFill.checkCircle, color: primaryColor, size: 24),
              ),
          ],
        ),
      ),
    );
  }
}

class _DateSelector extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;

  const _DateSelector({required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: textGreyColor)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(PhosphorIconsRegular.calendarBlank, size: 18, color: textDarkColor),
                const SizedBox(width: 8),
                Text(
                  DateFormat('dd.MM.yyyy').format(date),
                  style: const TextStyle(fontWeight: FontWeight.w600, color: textDarkColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}