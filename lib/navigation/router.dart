import 'package:flutter_nested_navigation/flutter_nested_navigation.dart';
import 'package:movie_buddy/home/views/home_page.dart';
import 'package:movie_buddy/movie/views/movie_details_page.dart';
import 'package:movie_buddy/movie/views/movie_page.dart';
import 'package:movie_buddy/settings/views/settings_page.dart';

class RouteConfig {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        redirect: (_, __) => "/movies",
      ),
      StatefulShellRoute(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/movies",
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: MoviePage()),
                routes: [
                  GoRoute(
                    path: "details",
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: MovieDetailsPage()),
                  )
                ],
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
