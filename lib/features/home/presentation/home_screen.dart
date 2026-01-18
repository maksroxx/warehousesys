import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/features/home/presentation/side_navigation_bar.dart';
import 'package:warehousesys/features/stock/presentation/screens/counterparties_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/home_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/inventory_docs_screen.dart';
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
      const InventoryScreen(),
      const OrdersScreen(),
      const ShipmentsScreen(),
      const InventoryDocsScreen(),
      const ReportsScreen(),
      const CounterpartiesScreen(),
      Center(child: Text(l10n.settings)),
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