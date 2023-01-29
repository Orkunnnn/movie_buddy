import 'package:flutter_nested_navigation/flutter_nested_navigation.dart';
import 'package:movie_buddy/home/views/home_page.dart';
import 'package:movie_buddy/movie/views/movie_page.dart';
import 'package:movie_buddy/settings/views/settings_page.dart';

class RouteConfig {
  static final router = GoRouter(
    initialLocation: "/",
    routes: [
      StatefulShellRoute(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/",
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: MoviePage()),
              ),
              GoRoute(
                path: "/settings",
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SettingsPage()),
              )
            ],
          )
        ],
        builder: (context, state, child) => HomePage(child: child),
      )
    ],
  );
}
