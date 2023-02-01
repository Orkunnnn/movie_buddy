import 'package:flutter/material.dart';
import 'package:flutter_nested_navigation/flutter_nested_navigation.dart';
import 'package:movie_buddy/home/views/home_page.dart';
import 'package:movie_buddy/movie/views/movie_details_page.dart';
import 'package:movie_buddy/movie/views/movie_page.dart';
import 'package:movie_buddy/settings/views/settings_page.dart';
import 'package:movie_repository/movie_repository.dart';

class RouteConfig {
  static final _routerKey = GlobalKey<NavigatorState>();
  static final moviesNavigatorKey = GlobalKey<NavigatorState>();
  static final settingsNavigatorKey = GlobalKey<NavigatorState>();
  static final router = GoRouter(
    navigatorKey: _routerKey,
    initialLocation: "/movies",
    routes: [
      StatefulShellRoute(
        branches: [
          StatefulShellBranch(
            navigatorKey: moviesNavigatorKey,
            defaultLocation: "/movies",
            routes: [
              GoRoute(
                path: "/movies",
                builder: (context, state) => const MoviePage(),
                routes: [
                  GoRoute(
                    path: ":movieId",
                    builder: (context, state) =>
                        MovieDetailsPage(movie: state.extra! as Movie),
                  )
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: settingsNavigatorKey,
            defaultLocation: "/settings",
            routes: [
              GoRoute(
                path: "/settings",
                builder: (context, state) => const SettingsPage(),
              )
            ],
          )
        ],
        builder: (context, state, child) => HomePage(
          child: child,
        ),
      )
    ],
  );
}
