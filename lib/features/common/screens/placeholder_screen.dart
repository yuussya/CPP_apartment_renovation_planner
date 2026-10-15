import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/theme/app_colors.dart';
import 'package:apartment_renovation_planner/core/widgets/app_card.dart';
import 'package:apartment_renovation_planner/core/widgets/app_shell.dart';
import 'package:apartment_renovation_planner/core/widgets/page_body.dart';
import 'package:apartment_renovation_planner/core/widgets/page_header.dart';

/// Заглушка для розділів, що будуть реалізовані в наступних лабораторних.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.route,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String route;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      currentRoute: route,
      child: PageBody(
        children: [
          PageHeader(title: title, subtitle: subtitle),
          const SizedBox(height: 24),
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
            child: Column(
              children: [
                Icon(icon, size: 48, color: AppColors.primary),
                const SizedBox(height: 16),
                const Text(
                  'Coming soon',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This section will be implemented in the next lab.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
