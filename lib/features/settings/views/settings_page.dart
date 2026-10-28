
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const Color backgroundColor = Color(0xFF202B3D);
  static const Color textColor = Color(0xFFF5F5F5);
  static const Color mutedColor = Color(0xFFB9C0CC);

  // Settings items displayed in the ListView.builder.
  final List<Map<String, dynamic>> settingsItems = const [
    {'type': 'heading', 'title': 'Settings'},
    {
      'type': 'tile',
      'title': 'Change app color',
      'icon': Icons.brush_outlined,
    },
    {
      'type': 'tile',
      'title': 'Change app typography',
      'icon': Icons.title,
    },
    {
      'type': 'tile',
      'title': 'Change app language',
      'icon': Icons.translate,
    },
    {'type': 'heading', 'title': 'Import'},
    {
      'type': 'tile',
      'title': 'Import from Google calendar',
      'icon': Icons.file_download_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: Column(
          children: [
            // Top navigation bar.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              child: SizedBox(
                height: 48,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: textColor,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Settings list.
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                itemCount: settingsItems.length,

                itemBuilder: (context, index) {
                  final item = settingsItems[index];

                  // Display section headings.
                  if (item['type'] == 'heading') {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? 12 : 22,
                        bottom: 12,
                      ),
                      child: Text(
                        item['title'],
                        style: const TextStyle(
                          color: mutedColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }

                  // Display clickable settings items.
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    minTileHeight: 82,

                    leading: Icon(
                      item['icon'],
                      color: textColor,
                      size: 30,
                    ),

                    title: Text(
                      item['title'],
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    trailing: const Icon(
                      Icons.chevron_right,
                      color: textColor,
                      size: 30,
                    ),

                    onTap: () {
                      switch (item['title']) {
                        case 'Change app color':
                          _showMessage(
                            context,
                            'Change app color selected',
                          );
                          break;

                        case 'Change app typography':
                          _showMessage(
                            context,
                            'Change app typography selected',
                          );
                          break;

                        case 'Change app language':
                          _showMessage(
                            context,
                            'Change app language selected',
                          );
                          break;

                        case 'Import from Google calendar':
                          _showMessage(
                            context,
                            'Import from Google calendar selected',
                          );
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

