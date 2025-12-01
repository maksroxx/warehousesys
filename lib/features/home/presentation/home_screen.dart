import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/features/home/presentation/side_navigation_bar.dart';
import 'package:warehousesys/features/stock/presentation/screens/counterparties_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/inventory_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/orders_screen.dart';
import 'package:warehousesys/features/stock/presentation/screens/shipments_screen.dart';

final pageProvider = StateProvider<int>((ref) => 1); // 1 = Inventory
final sideBarCollapsedProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Dashboard Page')), // Индекс 0
    InventoryScreen(),                     // Индекс 1
    OrdersScreen(),                        // Индекс 2
    ShipmentsScreen(),                     // Индекс 3
    Center(child: Text('Reports Page')),   // Индекс 4
    CounterpartiesScreen(),                // Индекс 5
    Center(child: Text('Settings Page')),  // Индекс 6
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(pageProvider);

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SideNavigationBar(),
          const VerticalDivider(),
          Expanded(
            child: _pages[selectedIndex],
          ),
        ],
      ),
    );
  }
}