import 'package:flutter/material.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';

/// Focus / timer tab — placeholder for Figma UI.
class FocusPage extends StatelessWidget {
  const FocusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Focus')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Focus tab\nBuild the timer UI from Figma here.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall,
          ),
        ),
      ),
    );
  }
}
