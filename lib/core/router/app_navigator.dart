import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_class/core/router/app_routes.dart';
import 'package:todo_class/features/tasks/widgets/add_task_sheet.dart';

/// Simplified navigation helpers.
///
/// Use:
/// - [push]     → open a page and keep history (details, add task)
/// - [replace]  → swap current page (login → home, no back to login)
/// - [go]       → jump and clear the stack to that destination
abstract final class AppNavigator {
  // --- go: clear stack / switch root destination ---

  static void goSplash(BuildContext context) {
    context.go(AppRoutes.splash);
  }

  static void goOnboarding(BuildContext context) {
    context.go(AppRoutes.onboarding);
  }

  static void goLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  static void goHome(BuildContext context) {
    context.go(AppRoutes.home);
  }

  static void goCalendar(BuildContext context) {
    context.go(AppRoutes.calendar);
  }

  static void goFocus(BuildContext context) {
    context.go(AppRoutes.focus);
  }

  static void goProfile(BuildContext context) {
    context.go(AppRoutes.profile);
  }

  // --- replace: pushReplacement (auth flows, onboarding) ---

  static void replaceWithOnboarding(BuildContext context) {
    context.pushReplacement(AppRoutes.onboarding);
  }

  static void replaceWithLogin(BuildContext context) {
    context.pushReplacement(AppRoutes.login);
  }

  static void replaceWithRegister(BuildContext context) {
    context.pushReplacement(AppRoutes.register);
  }

  static void replaceWithHome(BuildContext context) {
    context.pushReplacement(AppRoutes.home);
  }

  /// After onboarding — no back to slides.
  static void replaceOnboardingWithLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  /// After successful login / register — no back to auth screens.
  static void replaceAuthWithHome(BuildContext context) {
    context.go(AppRoutes.home);
  }

  /// Logout — clear stack and land on login.
  static void replaceWithLogout(BuildContext context) {
    context.go(AppRoutes.login);
  }

  // --- push: stack on top (can pop back) ---

  static void pushLogin(BuildContext context) {
    context.push(AppRoutes.login);
  }

  static void pushRegister(BuildContext context) {
    context.push(AppRoutes.register);
  }

  static void pushTasks(BuildContext context) {
    context.push(AppRoutes.tasks);
  }

  static void pushTaskDetail(BuildContext context, String id) {
    context.push(AppRoutes.taskDetailPath(id));
  }

  /// Opens the create-task bottom sheet (preferred over pushing a page).
  static Future<void> showAddTask(BuildContext context) {
    return AddTaskSheet.show(context);
  }

  /// Kept for lessons that compare sheet vs full-page forms.
  static void pushAddTask(BuildContext context) {
    context.push(AppRoutes.addTask);
  }

  static void pushEditTask(BuildContext context, String id) {
    context.push(AppRoutes.editTaskPath(id));
  }

  static void pushSettings(BuildContext context) {
    context.push(AppRoutes.settings);
  }

  static void pushStats(BuildContext context) {
    context.push(AppRoutes.stats);
  }

  // --- aliases kept for teaching clarity ---

  static void goTasks(BuildContext context) => pushTasks(context);

  static void goTaskDetail(BuildContext context, String id) =>
      pushTaskDetail(context, id);

  static void goAddTask(BuildContext context) => showAddTask(context);

  static void goEditTask(BuildContext context, String id) =>
      pushEditTask(context, id);

  static void goSettings(BuildContext context) => pushSettings(context);

  static void goStats(BuildContext context) => pushStats(context);

  static void back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }
}
