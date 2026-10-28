
import 'package:flutter/material.dart';

import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/services/storage/local_storage_service.dart';
import 'package:todo_class/utils/dialogs/app_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = 'Student';

  String _profileImage =
      'assets/images/backgrounds/images4.jpg';

  final Color _background = const Color(0xFF202A34);
  final Color _tileColor = const Color(0xFF303B47);
  final Color _textColor = const Color(0xFFE0E5EB);
  final Color _iconColor = const Color(0xFFAAB4C0);

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  // Load the saved username.
  Future<void> _loadUser() async {
    final name =
        await LocalStorageService.instance.getUserName();

    if (!mounted) return;

    setState(() {
      _userName = name ?? 'Student';
    });
  }

  // LOG OUT
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

  // CHANGE ACCOUNT NAME
  Future<void> _changeName() async {
    final controller = TextEditingController(text: _userName);

    final newName = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _tileColor,
          title: const Text(
            'Change account name',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter your name',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final value = controller.text.trim();

                if (value.isNotEmpty) {
                  Navigator.pop(dialogContext, value);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (newName == null || !mounted) return;

    setState(() {
      _userName = newName;
    });

    // This updates the name on this screen only.
    // Connect your storage save method to persist it.
  }

  // CHANGE ACCOUNT PASSWORD BOTTOM SHEET
  Future<void> _showPasswordSheet() async {
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();

    bool hidePassword = true;
    bool hideConfirmPassword = true;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: _tileColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'Change account password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Create a new password for your account.',
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'New password',
                      style: TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter new password',
                        hintStyle:
                            const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: _background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setSheetState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _iconColor,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Confirm new password',
                      style: TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: confirmController,
                      obscureText: hideConfirmPassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Confirm new password',
                        hintStyle:
                            const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: _background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setSheetState(() {
                              hideConfirmPassword =
                                  !hideConfirmPassword;
                            });
                          },
                          icon: Icon(
                            hideConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _iconColor,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 26),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(sheetContext);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(
                                color: Colors.white30,
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              final password =
                                  passwordController.text.trim();
                              final confirm =
                                  confirmController.text.trim();

                              if (password.isEmpty || confirm.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please fill in both password fields.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (password.length < 8) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Password must be at least 8 characters.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (password != confirm) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'The passwords do not match.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              // Close the sheet after validation.
                              Navigator.pop(sheetContext);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Password validated. Connect your authentication service to save it.',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: _background,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text('Create'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    passwordController.dispose();
    confirmController.dispose();
  }

  // CHANGE ACCOUNT IMAGE BOTTOM SHEET
  Future<void> _showImageSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: _tileColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: SizedBox(
                  width: 42,
                  child: Divider(
                    thickness: 4,
                    color: Colors.white30,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Change account image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              // OPTION 1
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  'Take a photo',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showImageOptionMessage('Take a photo');
                },
              ),

              // OPTION 2
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  'Choose from gallery',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showImageOptionMessage('Choose from gallery');
                },
              ),

              // OPTION 3
              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                title: const Text(
                  'Use default avatar',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    _profileImage = '';
                  });

                  Navigator.pop(sheetContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showImageOptionMessage(String option) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$option selected. Connect image_picker to complete this action.',
        ),
      ),
    );
  }

  // NAVIGATION AND MENU ACTIONS
  void _handleMenuTap(String action) {
    switch (action) {
      case 'settings':
        AppNavigator.pushSettings(context);
        break;

      case 'stats':
        AppNavigator.pushStats(context);
        break;

      case 'name':
        _changeName();
        break;

      case 'password':
        _showPasswordSheet();
        break;

      case 'image':
        _showImageSheet();
        break;

      case 'logout':
        _logout();
        break;

      case 'about':
      case 'faq':
      case 'help':
      case 'support':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$action page has not been connected yet.'),
          ),
        );
        break;
    }
  }

  // MENU ITEMS
  final List<Map<String, dynamic>> _menuItems = [
    {'heading': 'Settings'},
    {
      'title': 'App Settings',
      'icon': Icons.settings_outlined,
      'action': 'settings',
    },

    {'heading': 'Account'},
    {
      'title': 'Change account name',
      'icon': Icons.person_outline,
      'action': 'name',
    },
    {
      'title': 'Change account password',
      'icon': Icons.key_outlined,
      'action': 'password',
    },
    {
      'title': 'Change account Image',
      'icon': Icons.camera_alt_outlined,
      'action': 'image',
    },

    {'heading': 'Updates'},
    {
      'title': 'About Us',
      'icon': Icons.grid_view_outlined,
      'action': 'about',
    },
    {
      'title': 'FAQ',
      'icon': Icons.error_outline,
      'action': 'faq',
    },
    {
      'title': 'Help & Feedback',
      'icon': Icons.bolt_outlined,
      'action': 'help',
    },
    {
      'title': 'Support Us',
      'icon': Icons.thumb_up_alt_outlined,
      'action': 'support',
    },
    {
      'title': 'Log out',
      'icon': Icons.logout,
      'action': 'logout',
      'logout': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,

      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        itemCount: _menuItems.length + 2,

        itemBuilder: (context, index) {
          // PROFILE HEADER
          if (index == 0) {
            return Column(
              children: [
                ClipOval(
                  child: _profileImage.isEmpty
                      ? Container(
                          width: 78,
                          height: 78,
                          color: _tileColor,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.person,
                            size: 42,
                            color: Colors.white70,
                          ),
                        )
                      : Image.asset(
                          _profileImage,
                          width: 78,
                          height: 78,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 78,
                              height: 78,
                              color: _tileColor,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.person,
                                size: 42,
                                color: Colors.white70,
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 12),

                Text(
                  _userName,
                  style: AppTextStyles.heading2.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 22),
              ],
            );
          }

          // STATISTICS
          if (index == 1) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStat('10', 'Task left'),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildStat('5', 'Task done'),
                  ),
                ],
              ),
            );
          }

          final item = _menuItems[index - 2];

          // SECTION HEADINGS
          if (item.containsKey('heading')) {
            return Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 7),
              child: Text(
                item['heading'],
                style: AppTextStyles.bodySmall.copyWith(
                  color: _iconColor,
                ),
              ),
            );
          }

          final bool isLogout = item['logout'] == true;

          // MENU TILE
          return ListTile(
            contentPadding: EdgeInsets.zero,

            leading: Icon(
              item['icon'] as IconData,
              color: isLogout
                  ? const Color(0xFFCE8296)
                  : _iconColor,
              size: 22,
            ),

            title: Text(
              item['title'] as String,
              style: AppTextStyles.body.copyWith(
                color: isLogout
                    ? const Color(0xFFCE8296)
                    : _textColor,
                fontSize: 13,
              ),
            ),

            trailing: Icon(
              Icons.chevron_right,
              color: _iconColor,
              size: 24,
            ),

            // This is what makes each tile respond to a tap.
            onTap: () {
              _handleMenuTap(item['action'] as String);
            },
          );
        },
      ),
    );
  }

  // STATISTIC CARD
  Widget _buildStat(String number, String label) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _tileColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        '$number $label',
        style: AppTextStyles.body.copyWith(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}


