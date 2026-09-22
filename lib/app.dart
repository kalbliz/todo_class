import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_router.dart';
import 'package:todo_class/core/theme/app_theme.dart';

/// Root app widget — theme + router only.
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Todo Class',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
