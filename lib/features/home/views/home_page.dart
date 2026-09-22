import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/utils/buttons/app_button.dart';

/// Home tab inside the bottom-nav shell.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Welcome', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            Text(
              'Home tab — drop Figma UI here. Use the center FAB to add a task.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'View all tasks',
              onPressed: () => AppNavigator.pushTasks(context),
            ),
            const SizedBox(height: 12),
            AppOutlinedButton(
              label: 'View stats',
              onPressed: () => AppNavigator.pushStats(context),
            ),
          ],
        ),
      ),
    );
  }
}
