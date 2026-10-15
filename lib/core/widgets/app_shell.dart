import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/theme/app_spacing.dart';

import 'app_sidebar.dart';

/// Каркас внутрішніх екранів: постійне бічне меню на широких екранах
/// та висувна панель (Drawer) — на вузьких.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.currentRoute, required this.child});

  final String currentRoute;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= AppSpacing.wideBreakpoint;
        if (wide) {
          return Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSidebar(currentRoute: currentRoute),
                Expanded(child: child),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            title: const AppLogo(),
          ),
          drawer: Drawer(
            width: 264,
            backgroundColor: Colors.white,
            child: SafeArea(
              child: AppSidebar(currentRoute: currentRoute, inDrawer: true),
            ),
          ),
          body: child,
        );
      },
    );
  }
}
