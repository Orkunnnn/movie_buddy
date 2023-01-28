import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/l10n/l10n.dart';
import 'package:movie_buddy/movie/cubit/movie_cubit.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().fetchMoviesPopular(
          context.read<LocalizationCubit>().state?.languageCode ?? "",
        );
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
        body: Center(
          child: Column(
            children: [
              Text(l10n.helloWorld),
              ElevatedButton(
                onPressed: () => context.beamToNamed("/settings"),
                child: const Text("Go to settings"),
              ),
              BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is MoviesLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is MoviesLoaded) {
                    print(state.movies.length);
                    return Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return ListTile(
                            title: Text(movie.title),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<MovieCubit>().fetchMoviesPopular(
            context.read<LocalizationCubit>().state?.languageCode ?? "tr",
          );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
