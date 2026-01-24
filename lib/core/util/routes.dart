

import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somni/core/util/go_router_refresh_stream.dart';
import 'package:somni/features/chatbot/presentation/chat_bot_screen.dart';
import 'package:somni/features/auth/presentation/screens/profile_screen.dart';
import 'package:somni/features/calendar/presentation/calendar_screen.dart';
import 'package:somni/features/music/presentation/music_screen.dart';
import 'package:somni/features/dashboard/presentation/home_screen.dart';
import 'package:somni/features/sleepdisorder/presentation/bloc/sleep_disorder_bloc.dart';
import 'package:somni/features/sleepdisorder/presentation/sleep_disorder_screen.dart';

import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

import '../../features/chatbot/presentation/bloc/chatbot_bloc.dart';
import '../../features/facialstressdetection/presentation/bloc/stess_bloc.dart';
import '../../features/music/presentation/bloc/music_bloc.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';

import '../storage/token_storage.dart';
import 'navigation_util.dart';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';

final sl = GetIt.instance;

/// 🔒 Cached blocs (IMPORTANT)
final ChatbotBloc _chatbotBloc = sl<ChatbotBloc>();
final MusicBloc _musicBloc = sl<MusicBloc>();
final SleepDisorderBloc _disorderBloc = sl<SleepDisorderBloc>();

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    refreshListenable: GoRouterRefreshStream(
      sl<AuthBloc>().stream,
    ),
    redirect: (context, state) {
      final tokenStorage = sl<TokenStorage>();
      final loggedIn = tokenStorage.hasToken;
      final loggingIn = state.uri.toString() == '/login' ||
          state.uri.toString() == '/register';

      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/home';
      return null;
    },

    routes: [
      GoRoute(path: '/login', builder: (_, __) => LoginPage()),
      GoRoute(path: '/register', builder: (_, __) => RegisterPage()),

      ShellRoute(
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<DashboardBloc>(
                create: (_) => sl<DashboardBloc>(),
              ),

              /// ✅ Cached blocs
              BlocProvider<ChatbotBloc>.value(
                value: _chatbotBloc,
              ),
              BlocProvider<MusicBloc>.value(
                value: _musicBloc,
              ),
              BlocProvider<SleepDisorderBloc>.value(
                value: _disorderBloc,
              ),
            ],

            child: Scaffold(
              body: child,

              bottomNavigationBar: CurvedNavigationBar(
                index: _getSelectedIndex(state),
                backgroundColor: Colors.transparent,
                color: Theme.of(context).colorScheme.secondary,
                buttonBackgroundColor:
                Theme.of(context).colorScheme.primary,
                animationDuration: const Duration(milliseconds: 300),
                animationCurve: Curves.easeInOut,

                onTap: (index) {
                  switch (index) {
                    case 0:
                      NavigationUtil.goTo(context, '/home');
                      break;
                    case 1:
                      NavigationUtil.goTo(context, '/disorder');
                      break;
                    case 2:
                      NavigationUtil.goTo(context, '/chat');
                      break;
                    case 3:
                      NavigationUtil.goTo(context, '/music');
                      break;
                    case 4:
                      NavigationUtil.goTo(context, '/profile');
                      break;
                    case 5:
                      NavigationUtil.goTo(context, '/schedule');
                      break;
                  }
                },

                items: const [
                  CurvedNavigationBarItem(
                    child: Icon(Icons.home, color: Colors.white),
                    label: 'Home',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.single_bed_rounded, color: Colors.white),
                    label: 'Disorder',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.chat, color: Colors.white),
                    label: 'Chat',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.music_note, color: Colors.white),
                    label: 'Music',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.person, color: Colors.white),
                    label: 'Profile',
                  ),
                  CurvedNavigationBarItem(
                    child: Icon(Icons.edit_calendar_outlined,
                        color: Colors.white),
                    label: 'Schedule',
                  ),
                ],
              ),
            ),
          );
        },

        routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          GoRoute(path: '/disorder', builder: (_, __) => const SleepDisorderScreen()),
          GoRoute(path: '/chat', builder: (_, __) => const ChatBotScreen()),
          GoRoute(path: '/music', builder: (_, __) => const MusicScreen()),

          GoRoute(
            path: '/profile',
            builder: (context, state) {
              context.read<AuthBloc>().add(ProfileRequested());
              return BlocProvider<StressBloc>(
                create: (_) => sl<StressBloc>(),
                child: const ProfileScreen(),
              );
            },
          ),

          GoRoute(
            path: '/schedule',
            builder: (_, __) => const CalendarScreen(),
          ),
        ],
      ),
    ],
  );

  static int _getSelectedIndex(GoRouterState state) {
    final location = state.uri.path.toLowerCase();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/disorder')) return 1;
    if (location.startsWith('/chat')) return 2;
    if (location.startsWith('/music')) return 3;
    if (location.startsWith('/profile')) return 4;
    if (location.startsWith('/schedule')) return 5;
    return 0;
  }
}
