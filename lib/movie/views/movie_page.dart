import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/movie/cubit/movie_cubit.dart';
import 'package:movie_repository/movie_repository.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          MovieCubit(movieRepository: context.read<MovieRepository>()),
      child: const MovieView(),
    );
  }
}

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.read<MovieCubit>().fetchMoviesPopular(
                context.read<LocalizationCubit>().state?.languageCode ?? "tr",
              ),
          child: const Text("Go to settings"),
        ),
        BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            switch (state.status) {
              case MovieStatus.loading:
                return const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                );
              case MovieStatus.success:
                return Expanded(
                  child: ListView.builder(
                    key: const PageStorageKey("movies"),
                    controller: _scrollController,
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.movies[index].title),
                      );
                    },
                  ),
                );
              case MovieStatus.failure:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case MovieStatus.initial:
                const SizedBox.shrink();
            }
            return const SizedBox.shrink();
          },
        )
      ],
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
    final movieCubit = context.read<MovieCubit>();
    if (_isBottom && !movieCubit.state.isFetching) {
      movieCubit.fetchMoviesPopular(
        context.read<LocalizationCubit>().state?.languageCode ?? "tr",
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    if (context.read<MovieCubit>().state.hasReachedMax) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
