import 'package:flutter/material.dart';

import 'package:apartment_renovation_planner/core/router/app_routes.dart';
import 'package:apartment_renovation_planner/core/theme/app_colors.dart';
import 'package:apartment_renovation_planner/core/widgets/app_text_field.dart';
import 'package:apartment_renovation_planner/core/widgets/app_text_link.dart';
import 'package:apartment_renovation_planner/core/widgets/auth_scaffold.dart';
import 'package:apartment_renovation_planner/core/widgets/primary_button.dart';
import 'package:apartment_renovation_planner/core/widgets/secondary_button.dart';

/// Екран входу (ФВ-1). Бізнес-логіки немає: кнопка «Sign In»
/// одразу відкриває головний екран.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Apartment Planner',
      subtitle: 'Welcome back! Please enter your details.',
      footer: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 4,
        children: [
          const Text(
            "Don't have an account?",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          AppTextLink(
            label: 'Create account',
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.register),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: 'Email address',
            hint: 'name@example.com',
            prefixIcon: Icons.mail_outline_rounded,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Password',
            hint: '••••••••',
            prefixIcon: Icons.lock_rounded,
            isPassword: true,
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            labelTrailing: AppTextLink(
              label: 'Forgot password?',
              fontSize: 12,
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: (v) => setState(() => _rememberMe = v ?? false),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Remember for 30 days',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            label: 'Sign In',
            trailingIcon: Icons.arrow_forward_rounded,
            expand: true,
            onPressed: _signIn,
          ),
          const SizedBox(height: 24),
          const _OrDivider(),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: 'Google',
                  expand: true,
                  leading: const Text(
                    'G',
                    style: TextStyle(
                      color: Color(0xFFEA4335),
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: _signIn,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SecondaryButton(
                  label: 'Apple',
                  expand: true,
                  leading: const Icon(Icons.apple, size: 18),
                  onPressed: _signIn,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR CONTINUE WITH',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}
