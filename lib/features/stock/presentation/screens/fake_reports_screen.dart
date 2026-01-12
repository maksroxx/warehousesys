import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  // ID выбранного отчета (по умолчанию первый)
  int _selectedReportId = 0;
  
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _filterController = TextEditingController();

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _filterController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    
    // Данные для карточек отчетов
    final reports = [
      {'id': 0, 'title': l10n.stockLevelsReport, 'desc': l10n.stockLevelsDesc},
      {'id': 1, 'title': l10n.movementHistoryReport, 'desc': l10n.movementHistoryDesc},
      {'id': 2, 'title': l10n.supplierPerformanceReport, 'desc': l10n.supplierPerformanceDesc},
      {'id': 3, 'title': l10n.orderFulfillmentReport, 'desc': l10n.orderFulfillmentDesc},
      {'id': 4, 'title': l10n.inventoryTurnoverReport, 'desc': l10n.inventoryTurnoverDesc},
    ];

    const dashboardBg = Color(0xFFF6F7F8);
    const cardBg = Colors.white;

    return Scaffold(
      backgroundColor: dashboardBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Заголовок ---
                Text(
                  l10n.reportsPageTitle,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textDarkColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.reportsPageSubtitle,
                  style: textTheme.bodyMedium?.copyWith(color: textGreyColor),
                ),

                const SizedBox(height: 40),

                // --- Секция 1: Выбор отчета ---
                Text(
                  l10n.reportSelection,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: textDarkColor,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Сетка карточек (адаптивная)
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Если ширина позволяет, делаем 2 колонки, иначе 1
                    final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reports.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 3.5, // Соотношение сторон карточки
                        mainAxisExtent: 80, // Фиксированная высота карточки
                      ),
                      itemBuilder: (context, index) {
                        final report = reports[index];
                        final id = report['id'] as int;
                        return _ReportTypeCard(
                          title: report['title'] as String,
                          description: report['desc'] as String,
                          isSelected: _selectedReportId == id,
                          onTap: () => setState(() => _selectedReportId = id),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 40),

                // --- Секция 2: Параметры ---
                Text(
                  l10n.reportParameters,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: textDarkColor,
                  ),
                ),
                const SizedBox(height: 16),

                // Форма параметров (максимальная ширина как в HTML макете - max-w-xl)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Даты (в ряд)
                      Row(
                        children: [
                          Expanded(
                            child: _DateInput(
                              label: l10n.startDate,
                              controller: _startDateController,
                              onTap: () => _selectDate(context, _startDateController),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _DateInput(
                              label: l10n.endDate,
                              controller: _endDateController,
                              onTap: () => _selectDate(context, _endDateController),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Фильтр
                      _TextInput(
                        label: l10n.itemFilter,
                        hint: l10n.itemFilterHint,
                        controller: _filterController,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Divider(color: borderColor),
                const SizedBox(height: 24),

                // --- Кнопка генерации (Справа) ---
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: () {
                      // Логика генерации отчета
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('Generating report #${_selectedReportId}...')),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      l10n.generateReport,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Вспомогательные виджеты ---

// Карточка выбора отчета (Радио-кнопка)
class _ReportTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReportTypeCard({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            // Если выбрано - рамка синяя, иначе серая
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          // Эффект кольца (ring) при выборе, как в Tailwind
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 0,
                    spreadRadius: 4,
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            // Имитация радио-кнопки
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryColor : textGreyColor,
                  width: 2,
                ),
                color: Colors.white,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textDarkColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      color: textGreyColor,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
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

// Поле выбора даты
class _DateInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;

  const _DateInput({
    required this.label,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: textDarkColor, fontSize: 14)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: 'YYYY-MM-DD',
            hintStyle: const TextStyle(color: textGreyColor, fontSize: 14),
            suffixIcon: const Icon(PhosphorIconsRegular.calendarBlank, color: textGreyColor, size: 20),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

// Обычное текстовое поле
class _TextInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _TextInput({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: textDarkColor, fontSize: 14)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: textGreyColor, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}