import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/features/auth/screens/forgot_password_screen.dart';
import 'package:apartment_renovation_planner/features/auth/screens/login_screen.dart';
import 'package:apartment_renovation_planner/features/auth/screens/register_screen.dart';
import 'package:apartment_renovation_planner/features/auth/screens/reset_password_screen.dart';
import 'package:apartment_renovation_planner/features/common/screens/placeholder_screen.dart';
import 'package:apartment_renovation_planner/features/home/screens/home_screen.dart';
import 'package:apartment_renovation_planner/features/profile/screens/profile_screen.dart';

import 'app_routes.dart';

/// Проста навігація на основі Navigator і іменованих маршрутів.
abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.register:
        return _page(const RegisterScreen(), settings);
      case AppRoutes.forgotPassword:
        return _page(const ForgotPasswordScreen(), settings);
      case AppRoutes.resetPassword:
        return _page(const ResetPasswordScreen(), settings);
      case AppRoutes.home:
        return _instant(const HomeScreen(), settings);
      case AppRoutes.profile:
        return _instant(const ProfileScreen(), settings);
      case AppRoutes.rooms:
        return _instant(
          const PlaceholderScreen(
            route: AppRoutes.rooms,
            title: 'Rooms',
            subtitle: 'Manage project details room by room',
            icon: Icons.meeting_room_outlined,
          ),
          settings,
        );
      case AppRoutes.tasks:
        return _instant(
          const PlaceholderScreen(
            route: AppRoutes.tasks,
            title: 'Tasks',
            subtitle: 'Manage and track your renovation tasks',
            icon: Icons.checklist_rounded,
          ),
          settings,
        );
      case AppRoutes.spendings:
        return _instant(
          const PlaceholderScreen(
            route: AppRoutes.spendings,
            title: 'Budget & Expenses',
            subtitle: 'Monitor real-time renovation costs and materials',
            icon: Icons.account_balance_wallet_outlined,
          ),
          settings,
        );
      case AppRoutes.login:
      default:
        return _page(const LoginScreen(), settings);
    }
  }

  /// Стандартний перехід у стилі Material.
  static Route<void> _page(Widget page, RouteSettings settings) {
    return MaterialPageRoute<void>(builder: (_) => page, settings: settings);
  }

  /// Перехід без анімації — для перемикання розділів через бічне меню.
  static Route<void> _instant(Widget page, RouteSettings settings) {
    return PageRouteBuilder<void>(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
