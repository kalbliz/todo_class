import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/services/storage/local_storage_service.dart';
import 'package:todo_class/utils/buttons/app_button.dart';
import 'package:todo_class/utils/text_fields/app_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() => _isLoading = true);

    await LocalStorageService.instance.setLoggedIn(true);
    await LocalStorageService.instance.setUserName(
      _nameController.text.trim().isEmpty
          ? 'Student'
          : _nameController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);
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
            Text('Create account', style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            Text(
              'Register placeholder — style with Figma later.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 32),
            AppTextField(
              controller: _nameController,
              label: 'Name',
              hint: 'Your name',
            ),
            const SizedBox(height: 16),
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
              label: 'Register',
              isLoading: _isLoading,
              onPressed: _register,
            ),
            const SizedBox(height: 12),
            AppTextButton(
              label: 'Already have an account? Login',
              onPressed: () => AppNavigator.replaceWithLogin(context),
            ),
          ],
        ),
      ),
    );
  }
}
