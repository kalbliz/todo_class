import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/services/storage/local_storage_service.dart';
import 'package:todo_class/utils/buttons/app_button.dart';
import 'package:todo_class/utils/text_fields/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);

    // Demo login — later lesson: validate + real auth.
    await LocalStorageService.instance.setLoggedIn(true);
    await LocalStorageService.instance.setUserName(
      _emailController.text.trim().isEmpty
          ? 'Student'
          : _emailController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    // replace / go — user cannot press back to login
    AppNavigator.replaceAuthWithHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 48),
            Text('Welcome back', style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            Text(
              'Login placeholder — style with Figma later.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 32),
            AppTextField(
              controller: _emailController,
              label: 'Email',
              hint: 'you@email.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _passwordController,
              label: 'Password',
              hint: '••••••••',
              obscureText: true,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Login',
              isLoading: _isLoading,
              onPressed: _login,
            ),
            const SizedBox(height: 12),
            AppTextButton(
              label: 'Create an account',
              onPressed: () => AppNavigator.replaceWithRegister(context),
            ),
          ],
        ),
      ),
    );
  }
}
