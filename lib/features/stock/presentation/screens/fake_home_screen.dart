import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/dashboard_data.dart';
import 'package:warehousesys/features/stock/data/models/filters.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:warehousesys/features/stock/presentation/screens/create_document_screen.dart';
import 'package:warehousesys/features/stock/presentation/widgets/add_item_dialog.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    
    final dashboardAsync = ref.watch(dashboardDataProvider);
    final warehousesAsync = ref.watch(warehousesProvider);
    final selectedWh = ref.watch(selectedDashboardWarehouseProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(dashboardDataProvider),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, ref, l10n, warehousesAsync, selectedWh),
              
              const SizedBox(height: 32),

              dashboardAsync.when(
                loading: () => const SizedBox(height: 400, child: Center(child: CircularProgressIndicator())),
                error: (err, stack) => Center(child: Text('${l10n.error}: $err', style: const TextStyle(color: Colors.red))),
                data: (data) => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _StatCard(
                          title: "Всего товаров",
                          value: double.parse(data.totalStock).toStringAsFixed(0),
                          icon: PhosphorIconsFill.package,
                          color: Colors.blue,
                          subtitle: "На ${data.itemsInStock} активных позициях",
                        )),
                        const SizedBox(width: 24),
                        Expanded(child: _StatCard(
                          title: "Заканчиваются",
                          value: data.lowStockCount.toString(),
                          icon: PhosphorIconsFill.warning,
                          color: Colors.orange,
                          subtitle: "Остаток < 10 шт.",
                        )),
                        const SizedBox(width: 24),
                        Expanded(child: _StatCard(
                          title: "Движение сегодня",
                          value: "+${double.parse(data.incomingToday).toStringAsFixed(0)}",
                          secondaryValue: "-${double.parse(data.outgoingToday).toStringAsFixed(0)}",
                          icon: PhosphorIconsFill.arrowsLeftRight,
                          color: Colors.green,
                          subtitle: "Приход / Расход",
                        )),
                      ],
                    ),
                    
                    const SizedBox(height: 32),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: _DynamicsSection(data: data),
                        ),
                        
                        const SizedBox(width: 32),
                        
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _RecentActivityCard(movements: data.recentMovements),
                              const SizedBox(height: 24),
                              _QuickActionsCard(context: context, l10n: l10n),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, AppLocalizations l10n, AsyncValue<List<Warehouse>> warehousesAsync, int? selectedWh) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.dashboard, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(l10n.overviewSubtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textGreyColor)),
          ],
        ),
        warehousesAsync.when(
          data: (warehouses) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int?>(
                value: selectedWh,
                hint: Row(children: [Icon(PhosphorIconsRegular.buildings, size: 18, color: textGreyColor), const SizedBox(width: 8), Text(l10n.allLocations)]),
                icon: const Icon(PhosphorIconsRegular.caretDown, size: 16),
                items: [
                  DropdownMenuItem<int?>(value: null, child: Text(l10n.allLocations)),
                  ...warehouses.map((w) => DropdownMenuItem<int?>(value: w.id, child: Text(w.name))),
                ],
                onChanged: (val) => ref.read(selectedDashboardWarehouseProvider.notifier).state = val,
              ),
            ),
          ),
          loading: () => const SizedBox(),
          error: (_,__) => const SizedBox(),
        ),
      ],
    );
  }
}


class _DynamicsSection extends StatefulWidget {
  final DashboardData data;
  const _DynamicsSection({required this.data});

  @override
  State<_DynamicsSection> createState() => _DynamicsSectionState();
}

class _DynamicsSectionState extends State<_DynamicsSection> {
  int _selectedIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок и переключатель
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Динамика запасов", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDarkColor)),
              Container(
                decoration: BoxDecoration(
                  color: backgroundLightColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    _TabButton(
                      label: "Неделя",
                      isActive: _selectedIndex == 0,
                      onTap: () => setState(() => _selectedIndex = 0),
                    ),
                    Container(width: 1, height: 20, color: borderColor),
                    _TabButton(
                      label: "Месяц",
                      isActive: _selectedIndex == 1,
                      onTap: () => setState(() => _selectedIndex = 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Контент
          // ИСПРАВЛЕНО: Убрали жесткую высоту для календаря.
          _selectedIndex == 0
              ? SizedBox(
                  height: 300, // Графику нужна высота
                  width: double.infinity,
                  child: _WeeklyBarChart(fullData: widget.data.chartData),
                )
              : _MonthlyCalendarHeatmap(fullData: widget.data.chartData), // Календарь растянется сам
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
          boxShadow: isActive ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2)] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive ? textDarkColor : textGreyColor,
          ),
        ),
      ),
    );
  }
}

class _WeeklyBarChart extends StatelessWidget {
  final List<ChartPoint> fullData;
  const _WeeklyBarChart({required this.fullData});

  @override
  Widget build(BuildContext context) {
    if (fullData.isEmpty) return const Center(child: Text("Нет данных"));
    final sortedData = List<ChartPoint>.from(fullData)
      ..sort((a, b) => a.date.compareTo(b.date));
    
    final now = DateTime.now();
    final last7Days = List.generate(7, (i) => 
      DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 6 - i)))
    );

    // Группируем данные
    final Map<String, double> incomeMap = {};
    final Map<String, double> outcomeMap = {};
    double maxValue = 0;

    for (var p in sortedData) {
      double val = double.tryParse(p.value) ?? 0;
      if (p.type == 'INCOME') {
        incomeMap[p.date] = (incomeMap[p.date] ?? 0) + val;
      } else {
        outcomeMap[p.date] = (outcomeMap[p.date] ?? 0) + val;
      }
    }

    for (var date in last7Days) {
      if ((incomeMap[date] ?? 0) > maxValue) maxValue = incomeMap[date]!;
      if ((outcomeMap[date] ?? 0) > maxValue) maxValue = outcomeMap[date]!;
    }
    if (maxValue == 0) maxValue = 10;

    return Column(
      children: [
        // Легенда
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LegendItem(color: primaryColor, label: "Приход"),
            const SizedBox(width: 16),
            _LegendItem(color: Colors.red.shade400, label: "Расход"),
          ],
        ),
        const Spacer(),
        // Столбцы
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: last7Days.map((date) {
            final income = incomeMap[date] ?? 0;
            final outcome = outcomeMap[date] ?? 0;
            final dateLabel = DateFormat('E', 'ru').format(DateTime.parse(date)); // Пн, Вт...

            final hFactorIn = income / maxValue;
            final hFactorOut = outcome / maxValue;

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _AnimatedBar(heightFactor: hFactorIn, color: primaryColor, value: income),
                    const SizedBox(width: 4),
                    _AnimatedBar(heightFactor: hFactorOut, color: Colors.red.shade400, value: outcome),
                  ],
                ),
                const SizedBox(height: 12),
                Text(dateLabel, style: const TextStyle(fontSize: 12, color: textGreyColor)),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _AnimatedBar extends StatelessWidget {
  final double heightFactor;
  final Color color;
  final double value;

  const _AnimatedBar({required this.heightFactor, required this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: value.toStringAsFixed(0),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        tween: Tween(begin: 0, end: heightFactor),
        builder: (context, val, _) {
          return Container(
            width: 16,
            height: (val * 200).clamp(4.0, 200.0),
            decoration: BoxDecoration(
              color: value == 0 ? color.withOpacity(0.1) : color,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        },
      ),
    );
  }
}

class _MonthlyCalendarHeatmap extends StatelessWidget {
  final List<ChartPoint> fullData;
  const _MonthlyCalendarHeatmap({required this.fullData});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> activityMap = {};
    double maxActivity = 0;

    for (var p in fullData) {
      double val = double.tryParse(p.value) ?? 0;
      activityMap[p.date] = (activityMap[p.date] ?? 0) + val;
    }
    
    if (activityMap.isNotEmpty) {
      maxActivity = activityMap.values.reduce((a, b) => a > b ? a : b);
    }
    if (maxActivity == 0) maxActivity = 1;

    final now = DateTime.now();
    final daysCount = 35; 
    final startDate = now.subtract(Duration(days: daysCount - 1));

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Меньше", style: TextStyle(fontSize: 10, color: textGreyColor)),
            const SizedBox(width: 8),
            _HeatmapBox(opacity: 0.1),
            const SizedBox(width: 4),
            _HeatmapBox(opacity: 0.4),
            const SizedBox(width: 4),
            _HeatmapBox(opacity: 0.7),
            const SizedBox(width: 4),
            _HeatmapBox(opacity: 1.0),
            const SizedBox(width: 8),
            const Text("Больше", style: TextStyle(fontSize: 10, color: textGreyColor)),
          ],
        ),
        const SizedBox(height: 16),
        
        GridView.builder(
          // Важно: отключаем скролл и используем shrinkWrap
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true, 
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, 
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.3, // Оптимальное соотношение для ячеек
          ),
          itemCount: daysCount,
          itemBuilder: (context, index) {
            final day = startDate.add(Duration(days: index));
            final dateKey = DateFormat('yyyy-MM-dd').format(day);
            final activity = activityMap[dateKey] ?? 0;
            final dayNum = day.day.toString();
            
            Color bgColor;
            Color textColor;
            
            if (activity == 0) {
              bgColor = Colors.grey.shade100;
              textColor = textGreyColor;
            } else {
              final opacity = (activity / maxActivity).clamp(0.2, 1.0);
              bgColor = primaryColor.withOpacity(opacity);
              textColor = opacity > 0.5 ? Colors.white : primaryColor;
            }

            return Tooltip(
              message: "$dateKey: ${activity.toStringAsFixed(0)} операций",
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    dayNum,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _HeatmapBox extends StatelessWidget {
  final double opacity;
  const _HeatmapBox({required this.opacity});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12, height: 12,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(opacity),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? secondaryValue;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _StatCard({required this.title, required this.value, this.secondaryValue, required this.subtitle, required this.icon, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: color, size: 24),
                ),
                if (onTap != null) const Icon(PhosphorIconsRegular.arrowRight, size: 16, color: textGreyColor),
              ],
            ),
            const SizedBox(height: 24),
            Text(title, style: const TextStyle(color: textGreyColor, fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textDarkColor)),
                if (secondaryValue != null) ...[
                  const SizedBox(width: 8),
                  Text("/", style: TextStyle(color: textGreyColor.withOpacity(0.5), fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(secondaryValue!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: textGreyColor)),
                ]
              ],
            ),
            const SizedBox(height: 8),
            Text(subtitle, style: TextStyle(color: textGreyColor.withOpacity(0.8), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: textGreyColor, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  final List<MovementShort> movements;
  const _RecentActivityCard({required this.movements});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Последние операции", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDarkColor)),
          const SizedBox(height: 16),
          if (movements.isEmpty)
            const Padding(padding: EdgeInsets.all(16), child: Center(child: Text("Нет операций")))
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movements.length,
              separatorBuilder: (_,__) => const Divider(height: 16),
              itemBuilder: (context, index) {
                final m = movements[index];
                final isIncome = m.type == 'INCOME';
                final qty = double.parse(m.quantity).toStringAsFixed(0);
                
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isIncome ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isIncome ? PhosphorIconsRegular.arrowDownLeft : PhosphorIconsRegular.arrowUpRight,
                        size: 16,
                        color: isIncome ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.itemName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14), overflow: TextOverflow.ellipsis),
                          Text(DateFormat('dd MMM, HH:mm').format(m.date.toLocal()), style: const TextStyle(color: textGreyColor, fontSize: 12)),
                        ],
                      ),
                    ),
                    Text(
                      (isIncome ? "+" : "") + qty,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isIncome ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  final BuildContext context;
  final AppLocalizations l10n;
  const _QuickActionsCard({required this.context, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Быстрые действия", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _ActionButton(
            label: l10n.addItem, 
            icon: PhosphorIconsBold.plus,
            onTap: () => showDialog(context: context, builder: (c) => const AddItemDialog()),
          ),
          const SizedBox(height: 12),
          _ActionButton(
            label: l10n.createShipment, 
            icon: PhosphorIconsBold.truck,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => const CreateDocumentScreen(documentType: 'OUTCOME'))),
          ),
          const SizedBox(height: 12),
          _ActionButton(
            label: l10n.createIncomeDocument,
            icon: PhosphorIconsBold.downloadSimple,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => const CreateDocumentScreen(documentType: 'INCOME'))),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _ActionButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 12),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}