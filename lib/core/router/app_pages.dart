import 'package:flutter/material.dart';
import 'package:todo_class/features/auth/views/login_page.dart';
import 'package:todo_class/features/auth/views/register_page.dart';
import 'package:todo_class/features/calendar/views/calendar_page.dart';
import 'package:todo_class/features/focus/views/focus_page.dart';
import 'package:todo_class/features/home/views/home_page.dart';
import 'package:todo_class/features/onboarding/views/onboarding_page.dart';
import 'package:todo_class/features/profile/views/profile_page.dart';
import 'package:todo_class/features/settings/views/settings_page.dart';
import 'package:todo_class/features/splash/views/splash_page.dart';
import 'package:todo_class/features/stats/views/stats_page.dart';
import 'package:todo_class/features/tasks/views/add_task_page.dart';
import 'package:todo_class/features/tasks/views/edit_task_page.dart';
import 'package:todo_class/features/tasks/views/task_detail_page.dart';
import 'package:todo_class/features/tasks/views/tasks_page.dart';

/// Central map of every page in the app.
abstract final class AppPages {
  static Widget splash() => const SplashPage();

  static Widget onboarding() => const OnboardingPage();

  static Widget login() => const LoginPage();

  static Widget register() => const RegisterPage();

  static Widget home() => const HomePage();

  static Widget calendar() => const CalendarPage();

  static Widget focus() => const FocusPage();

  static Widget profile() => const ProfilePage();

  static Widget tasks() => const TasksPage();

  static Widget taskDetail({required String id}) => TaskDetailPage(taskId: id);

  static Widget addTask() => const AddTaskPage();

  static Widget editTask({required String id}) => EditTaskPage(taskId: id);

  static Widget settings() => const SettingsPage();

  static Widget stats() => const StatsPage();
}
