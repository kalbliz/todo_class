import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:todo_class/app.dart';
import 'package:todo_class/features/categories/notifiers/categories_notifier.dart';
import 'package:todo_class/features/tasks/notifiers/tasks_notifier.dart';
import 'package:todo_class/services/storage/local_storage_service.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await LocalStorageService.instance.init();
  await CategoriesNotifier.instance.load();
  await TasksNotifier.instance.load();

  // Remove here when skipping SplashPage (designing a specific screen).
  // When using AppRoutes.splash again, delete this and let SplashPage remove it.
  FlutterNativeSplash.remove();

  runApp(const TodoApp());
}
