import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/presentation/screens/create_document_screen.dart';
import 'package:warehousesys/features/stock/presentation/widgets/add_item_dialog.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    const dashboardBg = Color(0xFFF6F7F8); 
    const cardBg = Colors.white;

    return Scaffold(
      backgroundColor: dashboardBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- ЗАГОЛОВОК ---
            Text(
              l10n.dashboard, 
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: textDarkColor
              )
            ),
            const SizedBox(height: 4),
            Text(
              l10n.overviewSubtitle, 
              style: textTheme.bodyMedium?.copyWith(color: textGreyColor)
            ),
            
            const SizedBox(height: 32),

            // --- ГЛАВНАЯ СЕТКА (2fr слева, 1fr справа) ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === ЛЕВАЯ КОЛОНКА (ГРАФИКИ) - flex: 2 ===
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // 1. График Stock Levels
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.stockLevels, 
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: textDarkColor
                              )
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "12,500", 
                                  style: textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textDarkColor
                                  )
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  l10n.last30Days, 
                                  style: textTheme.bodySmall?.copyWith(color: textGreyColor)
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "+5%", 
                                  style: TextStyle(
                                    color: Colors.green, 
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14
                                  )
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            const SizedBox(
                              height: 192,
                              width: double.infinity,
                              child: _StockCurveChart(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // 2. График Recent Activity
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.recentActivity, 
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: textDarkColor
                              )
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "320", 
                                  style: textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textDarkColor
                                  )
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  l10n.last7Days, 
                                  style: textTheme.bodySmall?.copyWith(color: textGreyColor)
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "+10%", 
                                  style: TextStyle(
                                    color: Colors.green, 
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14
                                  )
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 192,
                              child: _ActivityBarChart(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 32),

                // === ПРАВАЯ КОЛОНКА (KPI + КНОПКИ) - flex: 1 ===
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, // Растягиваем кнопки и карточки на всю ширину колонки
                    children: [
                      // KPI 1
                      _KpiCard(
                        title: l10n.totalStock, 
                        value: l10n.totalStockValue, 
                      ),
                      const SizedBox(height: 24),
                      
                      // KPI 2
                      _KpiCard(
                        title: l10n.recentOperations, 
                        value: l10n.recentOperationsValue,
                      ),
                      const SizedBox(height: 24),
                      
                      // KPI 3
                      _KpiCard(
                        title: l10n.expectedDeliveries, 
                        value: l10n.expectedDeliveriesValue, 
                      ),

                      const SizedBox(height: 32), // Отступ перед кнопками чуть больше

                      // Кнопка 1
                      FilledButton(
                        onPressed: () {
                          showDialog(context: context, builder: (c) => const AddItemDialog());
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          l10n.addItem, 
                          style: const TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ),
                      
                      const SizedBox(height: 16),

                      // Кнопка 2
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (c) => const CreateDocumentScreen(documentType: 'OUTCOME')
                            )
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFE2E8F0),
                          foregroundColor: textDarkColor,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        child: Text(
                          l10n.createShipment, 
                          style: const TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Вспомогательные виджеты
// -----------------------------------------------------------------------------

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  const _KpiCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, 
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textGreyColor, 
              fontWeight: FontWeight.w500
            )
          ),
          const SizedBox(height: 8),
          Text(
            value, 
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold, 
              color: textDarkColor,
              fontSize: 24 
            )
          ),
        ],
      ),
    );
  }
}

class _StockCurveChart extends StatelessWidget {
  const _StockCurveChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvePainter(),
      child: Container(),
    );
  }
}

class _CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintStroke = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final paintFill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          primaryColor.withOpacity(0.2),
          primaryColor.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    final h = size.height;
    final w = size.width;

    path.moveTo(0, h * 0.7); 
    path.cubicTo(w * 0.1, h * 0.1, w * 0.3, h * 0.1, w * 0.4, h * 0.6);
    path.cubicTo(w * 0.5, h * 0.9, w * 0.7, h * 0.9, w * 0.8, h * 0.3);
    path.cubicTo(w * 0.9, h * 0.1, w * 0.95, h * 0.8, w, h * 0.8);

    canvas.drawPath(path, paintStroke);

    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();
    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ActivityBarChart extends StatelessWidget {
  const _ActivityBarChart();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final values = [0.4, 1.0, 0.5, 0.1, 1.0, 0.3, 0.9];
    final labels = [
      l10n.mon, l10n.tue, l10n.wed, l10n.thu, l10n.fri, l10n.sat, l10n.sun
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(values.length, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: FractionallySizedBox(
                    heightFactor: values[index],
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  labels[index],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textGreyColor, 
                    fontSize: 12
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}