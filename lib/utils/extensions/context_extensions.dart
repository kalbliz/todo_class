import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';

/// Handy BuildContext shortcuts for teaching / cleaner UI code.
extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenWidth => mediaQuery.size.width;

  double get screenHeight => mediaQuery.size.height;

  void showSnack(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void goBack() => AppNavigator.back(this);
}
