/// All route path constants used by go_router.
abstract final class AppRoutes {
  // Auth / entry
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';

  // Bottom-nav shell tabs
  static const String home = '/home';
  static const String calendar = '/calendar';
  static const String focus = '/focus';
  static const String profile = '/profile';

  // Stack routes (pushed on top of shell)
  static const String tasks = '/tasks';
  static const String taskDetail = '/tasks/:id';
  static const String addTask = '/tasks/add';
  static const String editTask = '/tasks/:id/edit';
  static const String settings = '/settings';
  static const String stats = '/stats';

  static String taskDetailPath(String id) => '/tasks/$id';

  static String editTaskPath(String id) => '/tasks/$id/edit';
}
