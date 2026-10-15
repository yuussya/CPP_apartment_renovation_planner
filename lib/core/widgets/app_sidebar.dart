import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/router/app_routes.dart';
import 'package:apartment_renovation_planner/core/theme/app_colors.dart';
import 'package:apartment_renovation_planner/core/theme/app_spacing.dart';
import 'package:apartment_renovation_planner/data/mock_data.dart';

class _NavItem {
  const _NavItem(this.label, this.icon, this.route);

  final String label;
  final IconData icon;
  final String route;
}

/// Бічне меню: логотип, розділи, використання сховища, поточний користувач.
class AppSidebar extends StatelessWidget {
  const AppSidebar({
    super.key,
    required this.currentRoute,
    this.inDrawer = false,
  });

  final String currentRoute;
  final bool inDrawer;

  static const _items = [
    _NavItem('Dashboard', Icons.home_rounded, AppRoutes.home),
    _NavItem('Rooms', Icons.meeting_room_rounded, AppRoutes.rooms),
    _NavItem('Tasks', Icons.checklist_rounded, AppRoutes.tasks),
    _NavItem('Spendings', Icons.account_balance_wallet_rounded,
        AppRoutes.spendings),
    _NavItem('Settings', Icons.settings_rounded, AppRoutes.profile),
  ];

  void _go(BuildContext context, String route) {
    final navigator = Navigator.of(context);
    if (inDrawer) navigator.pop();
    if (route != currentRoute) navigator.pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: inDrawer ? null : AppSpacing.sidebarWidth,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 28),
            child: AppLogo(),
          ),
          for (final item in _items)
            _NavTile(
              item: item,
              selected: item.route == currentRoute,
              onTap: () => _go(context, item.route),
            ),
          const Spacer(),
          const _StorageCard(),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 12),
          const _UserTile(),
        ],
      ),
    );
  }
}

/// Логотип «Renovate» (індиго-плитка з молотком + назва).
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.hardware_rounded, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 8),
        const Text(
          'Renovate',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textSecondary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: selected ? const Color(0xFFF5F6FC) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Icon(item.icon, size: 18, color: color),
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
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

class _StorageCard extends StatelessWidget {
  const _StorageCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'STORAGE',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: MockData.storageUsedGb / MockData.storageTotalGb,
              minHeight: 6,
              color: AppColors.primary,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${MockData.storageUsedGb} GB of ${MockData.storageTotalGb} GB used',
            style: const TextStyle(color: Color(0xFF818CF8), fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 16,
          backgroundColor: Color(0xFFE5E7EB),
          child: Text(
            'U',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MockData.userName,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              Text(
                MockData.userEmail,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Log out',
          iconSize: 18,
          color: AppColors.textMuted,
          icon: const Icon(Icons.logout_rounded),
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false),
        ),
      ],
    );
  }
}
