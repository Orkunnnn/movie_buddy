import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_buddy/navigation/cubit/navigation_cubit.dart';
import 'package:movie_buddy/navigation/routes.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              color: MovieBuddyColors.transparent,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.search),
              ),
            )
          ],
        ),
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => _onTap(context, value),
          currentIndex: context.watch<NavigationCubit>().state,
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Ionicons.home)),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(Ionicons.settings),
            )
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int? index) {
    context
        .read<NavigationCubit>()
        .changePage(context, Routes.values[index ?? 0]);
  }
}
