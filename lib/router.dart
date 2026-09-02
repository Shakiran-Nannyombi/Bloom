import 'package:go_router/go_router.dart';

import 'screens/ai_assist_screen.dart';
import 'screens/app_shell.dart';
import 'screens/home_screen.dart';
import 'screens/learn_module_screen.dart';
import 'screens/modules_screen.dart';
import 'screens/role_selector_screen.dart';
import 'screens/session_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/support_screens.dart';
import 'state/app_state.dart';

GoRouter createRouter(BloomAppState state) {
  return GoRouter(
    refreshListenable: state,
    initialLocation: '/',
    redirect: (context, goState) {
      final onSelector = goState.uri.path == '/';
      if (state.role == null && !onSelector) return '/';
      if (state.role != null && onSelector) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const RoleSelectorScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/modules',
            builder: (context, state) => const ModulesScreen(),
          ),
          GoRoute(
            path: '/ai',
            builder: (context, state) => const AiAssistScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/modules/:id',
        builder: (context, state) => LearnModuleScreen(
          moduleId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/session/:id',
        builder: (context, state) => SessionScreen(
          moduleId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/refer',
        builder: (context, state) => const ReferMentorScreen(),
      ),
      GoRoute(
        path: '/report',
        builder: (context, state) => const ReportConcernScreen(),
      ),
    ],
  );
}
