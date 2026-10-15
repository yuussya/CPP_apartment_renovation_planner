import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/theme/app_colors.dart';

/// Прогрес окремого проєкту (рядок у блоці «Project Progress»).
class ProjectProgress {
  const ProjectProgress({
    required this.name,
    required this.progress,
    required this.icon,
    required this.color,
    required this.background,
  });

  final String name;
  final double progress;
  final IconData icon;
  final Color color;
  final Color background;

  int get percent => (progress * 100).round();
}

/// Найближче завдання (блок «Upcoming Tasks»).
class UpcomingTask {
  const UpcomingTask(this.title, this.due);

  final String title;
  final String due;
}

enum ActivityStatus { updated, completed }

/// Запис у таблиці «Recent Activity».
class ActivityItem {
  const ActivityItem({
    required this.text,
    required this.project,
    required this.date,
    required this.status,
  });

  final String text;
  final String project;
  final String date;
  final ActivityStatus status;
}

/// Захардкоджені дані для відображення (до підключення бекенду).
abstract final class MockData {
  static const String userName = 'User';
  static const String userEmail = 'user@example.com';

  static const double storageUsedGb = 7.5;
  static const double storageTotalGb = 10;

  static const String currentMonth = 'October 2026';
  static const String activeProjects = '04';
  static const String tasksInProgress = '28';
  static const String spentSoFar = '\$12,450';

  static const projects = [
    ProjectProgress(
      name: 'Kitchen Remodel',
      progress: 0.65,
      icon: Icons.restaurant_rounded,
      color: AppColors.primary,
      background: AppColors.primaryLight,
    ),
    ProjectProgress(
      name: 'Master Bathroom',
      progress: 0.30,
      icon: Icons.bathtub_outlined,
      color: AppColors.success,
      background: AppColors.successBg,
    ),
    ProjectProgress(
      name: 'Living Room Refresh',
      progress: 0.85,
      icon: Icons.weekend_outlined,
      color: AppColors.warning,
      background: AppColors.warningBg,
    ),
  ];

  static const upcomingTasks = [
    UpcomingTask('Approve floor samples', 'Due today, 4:00 PM'),
    UpcomingTask('Finalize paint selection', 'Tomorrow, 10:00 AM'),
    UpcomingTask('Contractor site visit', 'Friday, 02:00 PM'),
    UpcomingTask('Order cabinet hardware', 'Next week'),
  ];

  static const recentActivity = [
    ActivityItem(
      text: "User updated 'Lighting Fixtures'",
      project: 'Living Room Refresh',
      date: '2 hours ago',
      status: ActivityStatus.updated,
    ),
    ActivityItem(
      text: "User completed 'Plumbing rough-in'",
      project: 'Kitchen Remodel',
      date: '5 hours ago',
      status: ActivityStatus.completed,
    ),
  ];
}
