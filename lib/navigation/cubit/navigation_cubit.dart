import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_buddy/navigation/routes.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void changePage(BuildContext context, Routes routes) {
    emit(routes.index);
    switch (routes) {
      case Routes.movies:
        context.go("/");
        break;
      case Routes.settings:
        context.go("/settings");
        break;
    }
  }
}
