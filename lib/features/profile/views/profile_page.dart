import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/services/storage/local_storage_service.dart';
import 'package:todo_class/utils/buttons/app_button.dart';
import 'package:todo_class/utils/dialogs/app_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = 'Student';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final name = await LocalStorageService.instance.getUserName();
    if (!mounted) return;
    setState(() => _userName = name ?? 'Student');
  }

  Future<void> _logout() async {
    final confirmed = await AppDialogs.confirm(
      context: context,
      title: 'Log out?',
      message: 'You will need to log in again.',
      confirmLabel: 'Log out',
      isDestructive: true,
    );
    if (confirmed != true || !mounted) return;

    await LocalStorageService.instance.clearSession();
    if (!mounted) return;
    AppNavigator.replaceWithLogout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(_userName, style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          Text(
            'Profile tab — wire Figma UI + storage lessons here.',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 24),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Settings', style: AppTextStyles.body),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => AppNavigator.pushSettings(context),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Stats', style: AppTextStyles.body),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => AppNavigator.pushStats(context),
          ),
          const SizedBox(height: 24),
          AppOutlinedButton(label: 'Log out', onPressed: _logout),
        ],
      ),
    );
  }
}
