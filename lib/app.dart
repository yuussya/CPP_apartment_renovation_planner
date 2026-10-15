import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/router/app_router.dart';
import 'package:apartment_renovation_planner/core/router/app_routes.dart';
import 'package:apartment_renovation_planner/core/theme/app_theme.dart';

class RenovationApp extends StatelessWidget {
  const RenovationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apartment Planner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
