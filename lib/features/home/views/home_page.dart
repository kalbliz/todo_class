import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/features/home/views/index.dart';
import 'package:todo_class/utils/buttons/app_button.dart';

/// Home tab inside the bottom-nav shell.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Index'),
         leading: IconButton(
    icon: const Icon(Icons.filter_list),
    onPressed: () {
      // Handle navigation drawer or back action
    },
  ),
    actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          // Handle profile tap
        },
        child: const CircleAvatar(
          radius: 18, // Adjust the size as needed
          backgroundImage: AssetImage('assets/images/backgrounds/images4.jpg'), // Your local asset path
        ),
      ),
    ),
  ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/backgrounds/images3.jpg"),
            Padding(
              padding: const EdgeInsets.only(left: 53),
              child: InkWell(
                onTap: () {
                  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Index()),
    );
                },
                child: Text('What do you want to do today?', style: AppTextStyles.heading3)),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 103),
              child: InkWell(
                onTap:  () => AppNavigator.pushTasks(context),
                child: Text(
                  'Tap + to add you tasks',
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // AppButton(
            //   label: 'View all tasks',
            //   onPressed: () => AppNavigator.pushTasks(context),
            // ),
            // const SizedBox(height: 12),
            // AppOutlinedButton(
            //   label: 'View stats',
            //   onPressed: () => AppNavigator.pushStats(context),
            // ),
          ],
        ),
      ),
    );
  }
}
