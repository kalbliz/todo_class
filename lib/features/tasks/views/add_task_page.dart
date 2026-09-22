import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/utils/buttons/app_button.dart';

/// Optional full-page create form kept for comparing with the bottom sheet.
/// Preferred create UX: [AppNavigator.showAddTask].
class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => AppNavigator.back(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create tasks with the bottom sheet instead.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Open create sheet',
              icon: Icons.add,
              onPressed: () => AppNavigator.showAddTask(context),
            ),
          ],
        ),
      ),
    );
  }
}
