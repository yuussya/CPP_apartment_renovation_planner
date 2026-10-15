import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/router/app_routes.dart';
import 'package:apartment_renovation_planner/core/theme/app_colors.dart';
import 'package:apartment_renovation_planner/core/widgets/app_card.dart';
import 'package:apartment_renovation_planner/core/widgets/app_shell.dart';
import 'package:apartment_renovation_planner/core/widgets/app_text_link.dart';
import 'package:apartment_renovation_planner/core/widgets/info_chip.dart';
import 'package:apartment_renovation_planner/core/widgets/page_body.dart';
import 'package:apartment_renovation_planner/core/widgets/page_header.dart';
import 'package:apartment_renovation_planner/core/widgets/icon_badge.dart';
import 'package:apartment_renovation_planner/core/widgets/primary_button.dart';
import 'package:apartment_renovation_planner/core/widgets/responsive_row.dart';
import 'package:apartment_renovation_planner/core/widgets/stat_card.dart';
import 'package:apartment_renovation_planner/core/widgets/status_chip.dart';
import 'package:apartment_renovation_planner/data/mock_data.dart';

/// Головний екран / дашборд (ФВ-3): зведена статистика, прогрес проєктів,
/// найближчі завдання та остання активність. Дані — захардкоджені.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      currentRoute: AppRoutes.home,
      child: PageBody(
        children: [
          PageHeader(
            title: 'Overview',
            subtitle: 'Track your home renovation progress',
            actions: [
              const InfoChip(
                icon: Icons.calendar_today_outlined,
                label: MockData.currentMonth,
              ),
              PrimaryButton(
                label: 'Add Project',
                leadingIcon: Icons.add_rounded,
                onPressed: () => _showDemoMessage(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const ResponsiveRow(
            breakpoint: 760,
            children: [
              StatCard(
                icon: Icons.handyman_outlined,
                iconColor: AppColors.info,
                iconBackground: AppColors.infoBg,
                label: 'Active Projects',
                value: MockData.activeProjects,
                badge: StatusChip(
                  label: '+12%',
                  color: AppColors.success,
                  background: AppColors.successBg,
                ),
              ),
              StatCard(
                icon: Icons.hourglass_bottom_rounded,
                iconColor: AppColors.warning,
                iconBackground: AppColors.warningBg,
                label: 'Tasks in Progress',
                value: MockData.tasksInProgress,
                badge: StatusChip(
                  label: 'Pending',
                  color: AppColors.warning,
                  background: AppColors.warningBg,
                ),
              ),
              StatCard(
                icon: Icons.account_balance_wallet_outlined,
                iconColor: AppColors.success,
                iconBackground: AppColors.successBg,
                label: 'Spent so far',
                value: MockData.spentSoFar,
                badge: Text(
                  'BUDGET',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ResponsiveRow(
            breakpoint: 760,
            flexes: const [3, 2],
            spacing: 24,
            children: [
              _ProjectProgressCard(onViewAll: () => _showDemoMessage(context)),
              const _UpcomingTasksCard(),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Recent Activity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          const _RecentActivityTable(),
        ],
      ),
    );
  }

  static void _showDemoMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This screen will be added in the next lab')),
    );
  }
}

class _ProjectProgressCard extends StatelessWidget {
  const _ProjectProgressCard({required this.onViewAll});

  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Project Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              AppTextLink(label: 'View all', onTap: onViewAll),
            ],
          ),
          const SizedBox(height: 24),
          for (final project in MockData.projects) ...[
            _ProgressRow(project: project),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({required this.project});

  final ProjectProgress project;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconBadge(
              icon: project.icon,
              color: project.color,
              background: project.background,
              size: 36,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                project.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '${project.percent}%',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: project.progress,
            minHeight: 8,
            color: project.color,
            backgroundColor: AppColors.track,
          ),
        ),
      ],
    );
  }
}

class _UpcomingTasksCard extends StatelessWidget {
  const _UpcomingTasksCard();

  @override
  Widget build(BuildContext context) {
    final tasks = MockData.upcomingTasks;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming Tasks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.track,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.more_horiz_rounded,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          for (var i = 0; i < tasks.length; i++)
            _TimelineItem(
              task: tasks[i],
              isFirst: i == 0,
              isLast: i == tasks.length - 1,
            ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.task,
    required this.isFirst,
    required this.isLast,
  });

  final UpcomingTask task;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 12,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isFirst
                          ? AppColors.primary
                          : const Color(0xFFD1D5DB),
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 1.5, color: AppColors.border),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    task.due,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentActivityTable extends StatelessWidget {
  const _RecentActivityTable();

  static const _headerStyle = TextStyle(
    color: AppColors.textMuted,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
  );

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 640;
          return Column(
            children: [
              if (!compact) ...[
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 20, 24, 12),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4, child: Text('ACTIVITY', style: _headerStyle)),
                      Expanded(
                          flex: 3, child: Text('PROJECT', style: _headerStyle)),
                      Expanded(
                          flex: 2, child: Text('DATE', style: _headerStyle)),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'STATUS',
                          textAlign: TextAlign.right,
                          style: _headerStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.border),
              ],
              for (var i = 0; i < MockData.recentActivity.length; i++) ...[
                if (i > 0) const Divider(height: 1, color: AppColors.border),
                _ActivityRow(
                  item: MockData.recentActivity[i],
                  compact: compact,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.item, required this.compact});

  final ActivityItem item;
  final bool compact;

  bool get _completed => item.status == ActivityStatus.completed;

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: 14,
      backgroundColor: _completed ? AppColors.successBg : AppColors.infoBg,
      child: Text(
        'U',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: _completed ? AppColors.success : AppColors.info,
        ),
      ),
    );
    final chip = StatusChip(
      label: _completed ? 'COMPLETED' : 'UPDATED',
      color: _completed ? AppColors.success : AppColors.info,
      background: _completed ? AppColors.successBg : AppColors.infoBg,
    );
    const textStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);
    const mutedStyle = TextStyle(color: AppColors.textSecondary, fontSize: 13);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: compact
          ? Row(
              children: [
                avatar,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.text, style: textStyle),
                      const SizedBox(height: 2),
                      Text('${item.project} • ${item.date}', style: mutedStyle),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                chip,
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      avatar,
                      const SizedBox(width: 12),
                      Expanded(child: Text(item.text, style: textStyle)),
                    ],
                  ),
                ),
                Expanded(flex: 3, child: Text(item.project, style: mutedStyle)),
                Expanded(flex: 2, child: Text(item.date, style: mutedStyle)),
                Expanded(
                  flex: 2,
                  child: Align(alignment: Alignment.centerRight, child: chip),
                ),
              ],
            ),
    );
  }
}
