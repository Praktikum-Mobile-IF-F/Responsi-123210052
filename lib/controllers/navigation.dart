import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:responsi/pages/favorite_page.dart';
import 'package:responsi/pages/home_page.dart';
import 'package:responsi/pages/bottomnavigation.dart';
import 'package:responsi/pages/profile_page.dart';
import 'package:responsi/pages/login_page.dart';
import 'package:responsi/pages/register_page.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = "/login";

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorBookmark = GlobalKey<NavigatorState>(debugLabel: 'shellBookmark');
  static final _shellNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// SignUp
      GoRoute(
        path: "/register",
        name: "register",
        builder: (BuildContext context, GoRouterState state) => const SignUpScreen(),
      ),

      /// SignIn
      GoRoute(
        path: "/login",
        name: "login",
        builder: (BuildContext context, GoRouterState state) => const SignInScreen(),
      ),

      /// MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          /// Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: "/home",
                name: "home",
                builder: (BuildContext context, GoRouterState state) =>
                const HomeScreen(),
              ),
            ],
          ),

          /// Bookmark
          // StatefulShellBranch(
          //   navigatorKey: _shellNavigatorBookmark,
          //   routes: <RouteBase>[
          //     GoRoute(
          //       path: "/bookmark",
          //       name: "bookmark",
          //       builder: (BuildContext context, GoRouterState state) =>
          //       const BookmarkScreen(),
          //     ),
          //   ],
          // ),



          /// Profile
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: <RouteBase>[
              GoRoute(
                path: "/profile",
                name: "profile",
                builder: (BuildContext context, GoRouterState state) =>
                const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
