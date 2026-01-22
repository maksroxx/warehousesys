import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/auth/presentation/auth_provider.dart';
import 'package:warehousesys/features/home/presentation/home_screen.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

class SideNavigationBar extends ConsumerWidget {
  const SideNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(pageProvider);
    final isCollapsed = ref.watch(sideBarCollapsedProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    final authNotifier = ref.watch(authProvider.notifier);

    final allNavItems = [
      {
        'label': l10n.dashboard,
        'index': 0,
        'iconRegular': PhosphorIconsRegular.house,
        'iconFill': PhosphorIconsFill.house,
        'permission': 'view_dashboard',
      },
      {
        'label': l10n.inventory,
        'index': 1,
        'iconRegular': PhosphorIconsRegular.package,
        'iconFill': PhosphorIconsFill.package,
        'permission': 'view_stock',
      },
      {
        'label': l10n.orders,
        'index': 2,
        'iconRegular': PhosphorIconsRegular.shoppingCart,
        'iconFill': PhosphorIconsFill.shoppingCart,
        'permission': 'create_document',
      },
      {
        'label': l10n.shipments,
        'index': 3,
        'iconRegular': PhosphorIconsRegular.truck,
        'iconFill': PhosphorIconsFill.truck,
        'permission': 'create_document',
      },
      {
        'label': l10n.inventoryDocs,
        'index': 4,
        'iconRegular': PhosphorIconsRegular.clipboardText,
        'iconFill': PhosphorIconsFill.clipboardText,
        'permission': 'view_inventory',
      },
      {
        'label': l10n.reports,
        'index': 5,
        'iconRegular': PhosphorIconsRegular.chartBar,
        'iconFill': PhosphorIconsFill.chartBar,
        'permission': 'view_reports',
      },
      {
        'label': l10n.counterparties,
        'index': 6,
        'iconRegular': PhosphorIconsRegular.users,
        'iconFill': PhosphorIconsFill.users,
        'permission': 'view_counterparties',
      },
    ];

    final visibleNavItems = allNavItems.where((item) {
      final perm = item['permission'] as String?;
      return perm == null || authNotifier.hasPermission(perm);
    }).toList();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOutCubic,
      width: isCollapsed ? 82 : 280,
      color: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          SizedBox(
            height: 72,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isCollapsed
                  ? Center(
                      key: const ValueKey('collapsed'),
                      child: _CollapseButton(isCollapsed: isCollapsed),
                    )
                  : Padding(
                      key: const ValueKey('expanded'),
                      padding: const EdgeInsets.fromLTRB(24, 0, 16, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.warehouseManager,
                              style: theme.textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _CollapseButton(isCollapsed: isCollapsed),
                        ],
                      ),
                    ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: visibleNavItems.map((item) {
                final idx = item['index'] as int;
                final isSelected = selectedIndex == idx;
                
                return _NavItem(
                  label: item['label'] as String,
                  icon: isSelected ? item['iconFill'] as IconData : item['iconRegular'] as IconData,
                  isSelected: isSelected,
                  isCollapsed: isCollapsed,
                  onTap: () => ref.read(pageProvider.notifier).state = idx,
                );
              }).toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: _NavItem(
              label: l10n.settings,
              icon: selectedIndex == 7 ? PhosphorIconsFill.gear : PhosphorIconsRegular.gear,
              isSelected: selectedIndex == 7,
              isCollapsed: isCollapsed,
              onTap: () => ref.read(pageProvider.notifier).state = 7,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isCollapsed;
  final VoidCallback onTap;
  const _NavItem({ required this.label, required this.icon, required this.isSelected, required this.isCollapsed, required this.onTap });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Material(
        color: isSelected ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          hoverColor: primaryColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Icon(icon, color: isSelected ? Colors.white : textGreyColor, size: 22),
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: isSelected ? Colors.white : textHeaderColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CollapseButton extends StatelessWidget {
  final bool isCollapsed;
  const _CollapseButton({required this.isCollapsed});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => IconButton(
        icon: Icon(PhosphorIconsRegular.sidebarSimple, color: textGreyColor, size: 24),
        onPressed: () => ref.read(sideBarCollapsedProvider.notifier).update((state) => !state),
      ),
    );
  }
}