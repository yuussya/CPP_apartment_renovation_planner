import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/router/app_routes.dart';
import 'package:apartment_renovation_planner/core/theme/app_colors.dart';
import 'package:apartment_renovation_planner/core/widgets/app_text_field.dart';
import 'package:apartment_renovation_planner/core/widgets/app_text_link.dart';
import 'package:apartment_renovation_planner/core/widgets/auth_scaffold.dart';
import 'package:apartment_renovation_planner/core/widgets/primary_button.dart';
import 'package:apartment_renovation_planner/core/widgets/secondary_button.dart';

/// Екран відновлення пароля (ФВ-1): запит листа та стан «Check your email».
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: _sent ? 'Check your email' : 'Forgot password?',
      subtitle: _sent
          ? 'We sent password reset instructions to your email.'
          : "No worries, we'll send you reset instructions.",
      footer: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_back_rounded,
              size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          AppTextLink(
            label: 'Back to sign in',
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      child: _sent ? _buildSent(context) : _buildForm(),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: 'Email address',
          hint: 'name@example.com',
          prefixIcon: Icons.mail_outline_rounded,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          label: 'Send reset link',
          trailingIcon: Icons.send_rounded,
          expand: true,
          onPressed: () => setState(() => _sent = true),
        ),
      ],
    );
  }

  Widget _buildSent(BuildContext context) {
    final email = _emailController.text.trim().isEmpty
        ? 'name@example.com'
        : _emailController.text.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.successBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              color: AppColors.success,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          email,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 24),
        // Демонстраційний перехід: у реальному застосунку користувач
        // потрапляє на цей екран за посиланням з листа.
        PrimaryButton(
          label: 'Open reset form (demo)',
          expand: true,
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoutes.resetPassword),
        ),
        const SizedBox(height: 12),
        SecondaryButton(
          label: 'Resend email',
          expand: true,
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reset email sent again (demo)')),
          ),
        ),
      ],
    );
  }
}
