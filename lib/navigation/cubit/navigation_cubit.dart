import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nested_navigation/flutter_nested_navigation.dart';
import 'package:movie_buddy/navigation/router.dart';
import 'package:movie_buddy/navigation/routes.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void changePage(
    BuildContext context,
    StatefulShellRouteState shellState,
    Routes routes,
  ) {
    emit(routes.index);
    switch (routes) {
      case Routes.movies:
        shellState.goBranch(navigatorKey: RouteConfig.moviesNavigatorKey);
        break;
      case Routes.settings:
        shellState.goBranch(navigatorKey: RouteConfig.settingsNavigatorKey);
        break;
    }
  }
}
