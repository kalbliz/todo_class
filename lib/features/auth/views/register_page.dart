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
         body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            IconButton(
                 icon: const Icon(Icons.chevron_left, size: 48,),
                 onPressed: () {
                 },
                ),
                SizedBox(height: 0,),
                   Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Register', style: AppTextStyles.heading1),
              const SizedBox(height: 28),
              // Text(
              //   'Please login to your account or create new account to continue.',
              //   style: AppTextStyles.bodySmall,
              // ),
              //  Text(
              //   'new account to continue.',
              //   style: AppTextStyles.bodySmall,
              // ),
                ],
              ),
              const SizedBox(height: 32),
              AppTextField(
                controller: _nameController,
                label: 'Username',
                hint: 'John',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 25),
              AppTextField(
                controller: _passwordController,
                label: 'Password',
                hint: '••••••••',
                obscureText: true,
              ),
              const SizedBox(height: 25),
              AppTextField(
                controller: _passwordController,
                label: 'Confirm Password',
                hint: '••••••••',
                obscureText: true,
              ),
              const SizedBox(height: 69),
              AppButton(
                label: 'Register',
                isLoading: _isLoading,
                onPressed: _register,
              ),
              const SizedBox(height: 28),
              Row(
            children: const [
              Expanded(
                child: Divider(
          thickness: 1,
          color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
          "OR",
          style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                child: Divider(
          thickness: 1,
          color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 39,),
          OutlinedButton(
            onPressed: () {
              // TODO: Add your login logic here
            },
            style: OutlinedButton.styleFrom(
             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Colors.black87,
              side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // Google standard radius
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google "G" Icon (Replace with your local asset image in production)
                Image.asset("assets/images/brand/google.png"),
                const SizedBox(width: 12),
                const Text(
          'Sign in with Google',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          OutlinedButton(
            onPressed: () {
              // TODO: Add your login logic here
            },
            style: OutlinedButton.styleFrom(
             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Colors.black87,
              side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // Google standard radius
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google "G" Icon (Replace with your local asset image in production)
                Image.asset("assets/images/brand/apple.png"),
                const SizedBox(width: 12),
                const Text(
          'Sign in with Apple',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
                ),
              ],
            ),
          ),
          SizedBox(height: 46,),
              Padding(
                padding: const EdgeInsets.only(left: 75),
                child: Row(
                  children: [
                    Text("Already have an account?"),
                    SizedBox(width: 0,),
                    AppTextButton(
                  label: 'Login',
                  onPressed: () => AppNavigator.replaceWithRegister(context),
                ),
                  ],
                ),
              )
            ],
          ),
        ),
          ],
        )
    );
  }
}
