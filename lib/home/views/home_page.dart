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
    final currentIndex = context.watch<NavigationCubit>().state;
    final shellState = StatefulShellRouteState.of(context);
    return Scaffold(
      body: child,
      bottomNavigationBar:
          _buildNavigationBar(context, shellState, currentIndex),
    );
  }

  NavigationBar _buildNavigationBar(
    BuildContext context,
    StatefulShellRouteState shellState,
    int currentIndex,
  ) {
    return NavigationBar(
      onDestinationSelected: (value) =>
          _onDestinationSelected(context, shellState, value),
      selectedIndex: currentIndex,
      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Ionicons.home),
          label: "Home",
          icon: Icon(Ionicons.home_outline),
        ),
        NavigationDestination(
          selectedIcon: Icon(Ionicons.settings),
          icon: Icon(Ionicons.settings_outline),
          label: "Settings",
        ),
      ],
    );
  }

  void _onDestinationSelected(
    BuildContext context,
    StatefulShellRouteState shellState,
    int? index,
  ) {
    context
        .read<NavigationCubit>()
        .changePage(context, shellState, Routes.values[index ?? 0]);
  }
}
