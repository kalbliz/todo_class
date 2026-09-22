import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/utils/buttons/app_button.dart';
import 'package:todo_class/utils/dialogs/app_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => AppNavigator.back(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Preferences', style: AppTextStyles.heading3),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('About', style: AppTextStyles.body),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              AppDialogs.info(
                context: context,
                title: 'Todo Class',
                message: 'Teaching project — setState + ChangeNotifier.',
              );
            },
          ),
        ],
      ),
    );
  }
}
