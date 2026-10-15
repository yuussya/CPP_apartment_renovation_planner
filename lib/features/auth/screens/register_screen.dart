import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/router/app_routes.dart';
import 'package:apartment_renovation_planner/core/theme/app_colors.dart';
import 'package:apartment_renovation_planner/core/widgets/app_text_field.dart';
import 'package:apartment_renovation_planner/core/widgets/app_text_link.dart';
import 'package:apartment_renovation_planner/core/widgets/auth_scaffold.dart';
import 'package:apartment_renovation_planner/core/widgets/primary_button.dart';

/// Екран реєстрації (ФВ-1). Виконується лише проста перевірка полів у UI.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _agree = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Create account',
      subtitle: 'Start planning your renovation today.',
      footer: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 4,
        children: [
          const Text(
            'Already have an account?',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          AppTextLink(
            label: 'Sign in',
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              label: 'Full name',
              hint: 'John Doe',
              prefixIcon: Icons.person_outline_rounded,
              controller: _nameController,
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
            ),
            const SizedBox(height: 20),
            AppTextField(
              label: 'Email address',
              hint: 'name@example.com',
              prefixIcon: Icons.mail_outline_rounded,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (v) => (v == null || !v.contains('@'))
                  ? 'Enter a valid email'
                  : null,
            ),
            const SizedBox(height: 20),
            AppTextField(
              label: 'Password',
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
              label: 'Confirm password',
              hint: 'Repeat your password',
              prefixIcon: Icons.lock_outline_rounded,
              isPassword: true,
              controller: _confirmController,
              textInputAction: TextInputAction.done,
              validator: (v) => v != _passwordController.text
                  ? 'Passwords do not match'
                  : null,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _agree,
                    onChanged: (v) => setState(() => _agree = v ?? false),
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      'I agree to the Terms of Service and Privacy Policy',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Create account',
              trailingIcon: Icons.arrow_forward_rounded,
              expand: true,
              onPressed: _agree ? _register : null,
            ),
          ],
        ),
      ),
    );
  }
}
