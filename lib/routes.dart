// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:get_it/get_it.dart';
// import 'package:somni/chat_bot_screen.dart';
// import 'package:somni/profile_screen.dart';
// import 'package:somni/schedule_screen.dart';
// import 'core/storage/token_storage.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'features/auth/presentation/login_screen.dart';
// import 'features/auth/presentation/register_screen.dart';
// import 'features/dashboard/presentation/home_screen.dart';
// import 'navigation_util.dart';
//
// final sl = GetIt.instance;
//
// class AppRoutes {
//   static final GoRouter router = GoRouter(
//     initialLocation: '/home',
//     redirect: (context, state) {
//       final tokenStorage = sl<TokenStorage>();
//       final loggedIn = tokenStorage.hasToken;
//       final loggingIn = state.uri.toString() == '/login' || state.uri.toString() == '/register';
//
//       if (!loggedIn && !loggingIn) {
//         // not logged in, send to login
//         return '/login';
//       }
//       if (loggedIn && loggingIn) {
//         // already logged in, don't show auth pages
//         return '/home';
//       }
//       return null;
//     },
//     routes: [
//       GoRoute(path: '/login', builder: (context, state) => LoginPage.withProvider()),
//       GoRoute(path: '/register', builder: (context, state) => RegisterPage.withProvider()),
//       ShellRoute(
//         builder: (context, state, child) {
//           return Scaffold(
//             body: child,
//             bottomNavigationBar: CurvedNavigationBar(
//               buttonBackgroundColor: Theme.of(context).colorScheme.primary,
//               index: _getSelectedIndex(state),
//               onTap: (index) {
//                 switch (index) {
//                   case 0:
//                     NavigationUtil.goTo(context, '/home');
//                     break;
//                   case 1:
//                     NavigationUtil.goTo(context, '/chat');
//                     break;
//                   case 2:
//                     NavigationUtil.goTo(context, '/profile');
//                     break;
//                   case 3:
//                     NavigationUtil.goTo(context, '/schedule');
//                     break;
//                 }
//               },
//               items: const [
//                 CurvedNavigationBarItem(child: Icon(Icons.home, color: Colors.white), label: 'Home'),
//                 CurvedNavigationBarItem(child: Icon(Icons.chat, color: Colors.white), label: 'Chat'),
//                 CurvedNavigationBarItem(child: Icon(Icons.person, color: Colors.white), label: 'Profile'),
//                 CurvedNavigationBarItem(child: Icon(Icons.edit_calendar_outlined, color: Colors.white), label: 'Schedule'),
//               ],
//               backgroundColor: Colors.transparent,
//               color: Theme.of(context).colorScheme.secondary,
//               animationCurve: Curves.easeInOut,
//               animationDuration: Duration(milliseconds: 300),
//             ),
//           );
//         },
//         routes: [
//           GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
//           GoRoute(path: '/chat', builder: (_, __) => const ChatBotScreen()),
//           GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
//           GoRoute(path: '/schedule', builder: (_, __) => const ScheduleScreen()),
//         ],
//       ),
//     ],
//   );
//
//   static int _getSelectedIndex(GoRouterState state) {
//     final location = state.uri.path.toLowerCase();
//     if (location.startsWith('/home')) return 0;
//     if (location.startsWith('/chat')) return 1;
//     if (location.startsWith('/profile')) return 2;
//     if (location.startsWith('/schedule')) return 3;
//     return 0;
//   }
// }



import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:somni/chat_bot_screen.dart';
import 'package:somni/profile_screen.dart';
import 'package:somni/schedule_screen.dart';
import 'core/storage/token_storage.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/register_screen.dart';
import 'features/dashboard/presentation/home_screen.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_event.dart';
import 'navigation_util.dart';

final sl = GetIt.instance;

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final tokenStorage = sl<TokenStorage>();
      final loggedIn = tokenStorage.hasToken;
      final loggingIn = state.uri.toString() == '/login' || state.uri.toString() == '/register';

      if (!loggedIn && !loggingIn) {
        // not logged in, send to login
        return '/login';
      }
      if (loggedIn && loggingIn) {
        // already logged in, don't show auth pages
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginPage.withProvider()),
      GoRoute(path: '/register', builder: (context, state) => RegisterPage.withProvider()),
      ShellRoute(
        builder: (context, state, child) {
          // Provide DashboardBloc (and any other shared blocs) to all shell children
          return MultiBlocProvider(
            providers: [
              BlocProvider<DashboardBloc>(
                create: (_) => sl<DashboardBloc>(),
                // Optionally load dashboard immediately:
                // create: (_) => sl<DashboardBloc>()..add(LoadDashboardRequested()),
              ),
            ],
            child: Scaffold(
              body: child,
              bottomNavigationBar: CurvedNavigationBar(
                buttonBackgroundColor: Theme.of(context).colorScheme.primary,
                index: _getSelectedIndex(state),
                onTap: (index) {
                  switch (index) {
                    case 0:
                      NavigationUtil.goTo(context, '/home');
                      break;
                    case 1:
                      NavigationUtil.goTo(context, '/chat');
                      break;
                    case 2:
                      NavigationUtil.goTo(context, '/profile');
                      break;
                    case 3:
                      NavigationUtil.goTo(context, '/schedule');
                      break;
                  }
                },
                items: const [
                  CurvedNavigationBarItem(child: Icon(Icons.home, color: Colors.white), label: 'Home'),
                  CurvedNavigationBarItem(child: Icon(Icons.chat, color: Colors.white), label: 'Chat'),
                  CurvedNavigationBarItem(child: Icon(Icons.person, color: Colors.white), label: 'Profile'),
                  CurvedNavigationBarItem(child: Icon(Icons.edit_calendar_outlined, color: Colors.white), label: 'Schedule'),
                ],
                backgroundColor: Colors.transparent,
                color: Theme.of(context).colorScheme.secondary,
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 300),
              ),
            ),
          );
        },
        routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          GoRoute(path: '/chat', builder: (_, __) => const ChatBotScreen()),
          GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
          GoRoute(path: '/schedule', builder: (_, __) => const ScheduleScreen()),
        ],
      ),
    ],
  );

  static int _getSelectedIndex(GoRouterState state) {
    final location = state.uri.path.toLowerCase();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/chat')) return 1;
    if (location.startsWith('/profile')) return 2;
    if (location.startsWith('/schedule')) return 3;
    return 0;
  }
}