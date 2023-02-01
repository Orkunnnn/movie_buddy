import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nested_navigation/flutter_nested_navigation.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_buddy/navigation/cubit/navigation_cubit.dart';
import 'package:movie_buddy/navigation/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return HomeView(
      child: child,
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final shellState = StatefulShellRouteState.of(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => _onTap(context, shellState, value),
        currentIndex: context.watch<NavigationCubit>().state,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Ionicons.home)),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Ionicons.settings),
          )
        ],
      ),
    );
  }

  void _onTap(
    BuildContext context,
    StatefulShellRouteState shellState,
    int? index,
  ) {
    context
        .read<NavigationCubit>()
        .changePage(context, shellState, Routes.values[index ?? 0]);
  }
}
