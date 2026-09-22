import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/services/storage/local_storage_service.dart';

/// Flutter bootstrap after the native splash.
/// Decides: onboarding → login → home.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final storage = LocalStorageService.instance;
    final onboardingDone = await storage.getOnboardingDone();
    final isLoggedIn = await storage.getIsLoggedIn();

    // Brief pause so native splash does not flash away too fast.
    await Future<void>.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;
    FlutterNativeSplash.remove();

    if (!onboardingDone) {
      AppNavigator.goOnboarding(context);
    } else if (isLoggedIn) {
      AppNavigator.goHome(context);
    } else {
      AppNavigator.goLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Native splash covers this; keep a matching solid color underneath.
    return const Scaffold(
      backgroundColor: Color(0xFF4A6CF7),
      body: SizedBox.shrink(),
    );
  }
}
