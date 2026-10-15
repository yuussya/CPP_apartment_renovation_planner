import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/router/app_routes.dart';
import 'package:apartment_renovation_planner/core/theme/app_colors.dart';
import 'package:apartment_renovation_planner/core/widgets/app_text_field.dart';
import 'package:apartment_renovation_planner/core/widgets/auth_scaffold.dart';
import 'package:apartment_renovation_planner/core/widgets/primary_button.dart';

/// Екран встановлення нового пароля після переходу за посиланням з листа.
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _reset() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password updated. Please sign in.')),
    );
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Set new password',
      subtitle: 'Your new password must be different from previous ones.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              label: 'New password',
              hint: 'At least 8 characters',
              prefixIcon: Icons.lock_rounded,
              isPassword: true,
              controller: _passwordController,
              textInputAction: TextInputAction.next,
              validator: (v) => (v == null || v.length < 8)
                  ? 'Use at least 8 characters'
                  : null,
            ),
            const SizedBox(height: 20),
            AppTextField(
              label: 'Confirm new password',
              hint: 'Repeat new password',
              prefixIcon: Icons.lock_outline_rounded,
              isPassword: true,
              controller: _confirmController,
              textInputAction: TextInputAction.done,
              validator: (v) => v != _passwordController.text
                  ? 'Passwords do not match'
                  : null,
            ),
            const SizedBox(height: 12),
            const Text(
              'Use 8 or more characters with a mix of letters and numbers.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Reset password',
              trailingIcon: Icons.check_rounded,
              expand: true,
              onPressed: _reset,
            ),
          ],
        ),
      ),
    );
  }
}
