import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nested_navigation/flutter_nested_navigation.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_buddy/l10n/l10n.dart';
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
    return Scaffold(
      body: child,
      bottomNavigationBar: _buildNavigationBar(context, currentIndex),
    );
  }

  NavigationBar _buildNavigationBar(
    BuildContext context,
    int currentIndex,
  ) {
    final l10n = context.l10n;
    final shellState = StatefulShellRouteState.of(context);
    return NavigationBar(
      onDestinationSelected: (value) =>
          _onDestinationSelected(context, shellState, value),
      selectedIndex: currentIndex,
      destinations: [
        NavigationDestination(
          selectedIcon: const Icon(Ionicons.home),
          label: l10n.home,
          icon: const Icon(Ionicons.home_outline),
        ),
        NavigationDestination(
          selectedIcon: const Icon(Ionicons.settings),
          icon: const Icon(Ionicons.settings_outline),
          label: l10n.settings,
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
