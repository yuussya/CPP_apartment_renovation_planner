import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/router/app_routes.dart';
import 'package:apartment_renovation_planner/core/theme/app_colors.dart';
import 'package:apartment_renovation_planner/core/widgets/app_shell.dart';
import 'package:apartment_renovation_planner/core/widgets/app_text_field.dart';
import 'package:apartment_renovation_planner/core/widgets/page_body.dart';
import 'package:apartment_renovation_planner/core/widgets/page_header.dart';
import 'package:apartment_renovation_planner/core/widgets/primary_button.dart';
import 'package:apartment_renovation_planner/core/widgets/responsive_row.dart';
import 'package:apartment_renovation_planner/core/widgets/secondary_button.dart';
import 'package:apartment_renovation_planner/core/widgets/section_card.dart';
import 'package:apartment_renovation_planner/data/mock_data.dart';

/// Екран керування профілем (ФВ-2): особисті дані, фото, сповіщення,
/// зміна пароля. Кнопки лише показують повідомлення — без збереження.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController(text: MockData.userEmail);
  final _currentPasswordController = TextEditingController(text: 'password123');
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _emailNotifications = true;
  bool _pushNotifications = false;
  bool _taskDeadlines = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _discard() {
    setState(() {
      _nameController.clear();
      _emailController.text = MockData.userEmail;
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      _emailNotifications = true;
      _pushNotifications = false;
      _taskDeadlines = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      currentRoute: AppRoutes.profile,
      child: PageBody(
        maxWidth: 780,
        children: [
          const PageHeader(
            title: 'Account Settings',
            subtitle: 'Manage your profile and application preferences',
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: 'Profile Information',
            subtitle: 'Update your personal details and how others see you.',
            child: _buildProfileSection(),
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: 'Notifications',
            subtitle: 'Configure how and when you receive alerts.',
            child: _buildNotificationsSection(),
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: 'Security',
            subtitle:
                'Secure your account with a strong password and multi-factor authentication.',
            child: _buildSecuritySection(),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 12,
            runSpacing: 12,
            children: [
              SecondaryButton(label: 'Discard Changes', onPressed: _discard),
              PrimaryButton(
                label: 'Save Settings',
                onPressed: () => _message('Settings saved (demo)'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 32,
                    color: AppColors.primary,
                  ),
                ),
                Positioned(
                  right: -6,
                  bottom: -6,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(
                      Icons.photo_camera_rounded,
                      size: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile Photo',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Recommended size: 400×400px. PNG or JPG.',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryLight,
                          foregroundColor: AppColors.primary,
                          minimumSize: const Size(0, 30),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => _message('Photo picker (next lab)'),
                        child: const Text('Change'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textMuted,
                          minimumSize: const Size(0, 30),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () => _message('Photo removed (demo)'),
                        child: const Text('Remove'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ResponsiveRow(
          breakpoint: 520,
          children: [
            AppTextField(
              label: 'Display Name',
              hint: 'Display Name',
              controller: _nameController,
            ),
            AppTextField(
              label: 'Email Address',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return Column(
      children: [
        _SwitchRow(
          title: 'Email Notifications',
          description: 'Receive weekly digests and project updates via email.',
          value: _emailNotifications,
          onChanged: (v) => setState(() => _emailNotifications = v),
        ),
        const Divider(height: 32, color: AppColors.border),
        _SwitchRow(
          title: 'Browser Push Notifications',
          description: 'Get real-time alerts on your desktop for task mentions.',
          value: _pushNotifications,
          onChanged: (v) => setState(() => _pushNotifications = v),
        ),
        const Divider(height: 32, color: AppColors.border),
        _SwitchRow(
          title: 'Task Deadlines',
          description: 'Reminders for upcoming tasks 24 hours before they are due.',
          value: _taskDeadlines,
          onChanged: (v) => setState(() => _taskDeadlines = v),
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: 'Current Password',
          isPassword: true,
          controller: _currentPasswordController,
        ),
        const SizedBox(height: 20),
        ResponsiveRow(
          breakpoint: 520,
          children: [
            AppTextField(
              label: 'New Password',
              hint: 'New password',
              isPassword: true,
              controller: _newPasswordController,
            ),
            AppTextField(
              label: 'Confirm New Password',
              hint: 'Confirm new password',
              isPassword: true,
              controller: _confirmPasswordController,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFDEFC3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  size: 18,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Two-factor authentication is disabled',
                      style: TextStyle(
                        color: Color(0xFF7C2D12),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Protect your account with an extra layer of security. '
                      "Once turned on, you'll need to enter a code from your phone to sign in.",
                      style: TextStyle(color: Color(0xFFB45309), fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _message('2FA setup (next lab)'),
                      child: const Text(
                        'Enable 2FA',
                        style: TextStyle(
                          color: Color(0xFF7C2D12),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
