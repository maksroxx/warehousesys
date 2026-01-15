import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/features/home/presentation/side_navigation_bar.dart';
import 'package:warehousesys/features/stock/presentation/screens/counterparties_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/home_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/reports_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/inventory_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/orders_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/shipments_screen.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

final pageProvider = StateProvider<int>((ref) => 1); // 1 = Inventory
final sideBarCollapsedProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(pageProvider);
    final l10n = AppLocalizations.of(context)!;

    final pages = <Widget>[
      const DashboardScreen(),
      // Center(child: Text(l10n.dashboard)), // Индекс 0
      const InventoryScreen(),             // Индекс 1
      const OrdersScreen(),                // Индекс 2
      const ShipmentsScreen(),             // Индекс 3
      const ReportsScreen(),
      // Center(child: Text(l10n.reports)),   // Индекс 4
      const CounterpartiesScreen(),        // Индекс 5
      Center(child: Text(l10n.settings)),  // Индекс 6
    ];

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SideNavigationBar(),
          const VerticalDivider(),
          Expanded(
            child: pages[selectedIndex],
          ),
        ],
      ),
    );
  }
}