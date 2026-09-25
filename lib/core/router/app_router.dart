import 'package:go_router/go_router.dart';
import 'package:todo_class/core/router/app_pages.dart';
import 'package:todo_class/core/router/app_routes.dart';
import 'package:todo_class/features/shell/views/main_shell.dart';

/// Single go_router configuration for the whole app.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: [
    // Entry / auth — use replace / go so user cannot back into these.
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => AppPages.splash(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => AppPages.onboarding(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => AppPages.login(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => AppPages.register(),
    ),

    // Bottom-nav shell: Home | Calendar | (FAB) | Focus | Profile
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              builder: (context, state) => AppPages.home(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.calendar,
              name: 'calendar',
              builder: (context, state) => AppPages.calendar(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.focus,
              name: 'focus',
              builder: (context, state) => AppPages.focus(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              name: 'profile',
              builder: (context, state) => AppPages.profile(),
            ),
          ],
        ),
      ],
    ),

    // Stack routes (pushed over the shell)
    GoRoute(
      path: AppRoutes.tasks,
      name: 'tasks',
      builder: (context, state) => AppPages.tasks(),
      routes: [
        GoRoute(
          path: 'add',
          name: 'addTask',
          builder: (context, state) => AppPages.addTask(),
        ),
        GoRoute(
          path: ':id',
          name: 'taskDetail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return AppPages.taskDetail(id: id);
          },
          routes: [
            GoRoute(
              path: 'edit',
              name: 'editTask',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return AppPages.editTask(id: id);
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      builder: (context, state) => AppPages.settings(),
    ),
    GoRoute(
      path: AppRoutes.stats,
      name: 'stats',
      builder: (context, state) => AppPages.stats(),
    ),
  ],
);
