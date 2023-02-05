import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_buddy/l10n/l10n.dart';
import 'package:movie_buddy/movie/bloc/movie_bloc.dart';
import 'package:movie_buddy/movie/bloc/movie_top_rated_bloc.dart';
import 'package:movie_buddy/movie/widgets/movie_card.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MovieView();
  }
}

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final _popularScrollController = ScrollController();
  final _topRatedScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _popularScrollController.addListener(_onPopularMoviesScroll);
    _topRatedScrollController.addListener(_onTopRatedMoviesScroll);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: MovieBuddyPadding.all.small,
          child: Column(
            children: [
              BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  switch (state.status) {
                    case MovieStatus.success:
                      return _buildMoviesSection(
                        context,
                        state,
                        l10n.popularMovies,
                        () => SizedBox(
                          height: size.height * 0.4,
                          child: _buildMovieCards(
                            state: state,
                            scrollController: _popularScrollController,
                          ),
                        ),
                      );
                    case MovieStatus.failure:
                      return const Center(
                        child: Text("Fail"),
                      );
                    case MovieStatus.initial:
                      return _buildMoviesSection(
                          context, state, l10n.popularMovies, () {
                        return SizedBox(
                          height: size.height * 0.4,
                          child: _buildLoadingMovies(),
                        );
                      });
                  }
                },
              ),
              BlocBuilder<MovieTopRatedBloc, MovieState>(
                builder: (context, state) {
                  switch (state.status) {
                    case MovieStatus.initial:
                      return _buildMoviesSection(
                          context, state, l10n.topRatedMovies, () {
                        return SizedBox(
                          height: size.height * 0.4,
                          child: _buildLoadingMovies(),
                        );
                      });
                    case MovieStatus.success:
                      return _buildMoviesSection(
                        context,
                        state,
                        l10n.topRatedMovies,
                        () => SizedBox(
                          height: size.height * 0.4,
                          child: _buildMovieCards(
                            state: state,
                            scrollController: _topRatedScrollController,
                          ),
                        ),
                      );
                    case MovieStatus.failure:
                      return const Center(
                        child: Text("Fail"),
                      );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildLoadingMovies() {
    final size = MediaQuery.of(context).size;
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => SizedBox(
        width: size.width * 0.5,
        child: Column(
          children: [
            ShimmerContainer(
              width: size.width * 0.5,
              height: size.height * 0.3,
            ),
            const Gap(8),
            const ShimmerText()
          ],
        ),
      ),
      separatorBuilder: (context, index) => const Gap(8),
      itemCount: 10,
    );
  }

  Widget _buildMoviesSection(
    BuildContext context,
    MovieState state,
    String title,
    Widget Function() build,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        build.call()
      ],
    );
  }

  Widget _buildMovieCards({
    required ScrollController scrollController,
    required MovieState state,
  }) {
    return ListView.separated(
      controller: scrollController,
      separatorBuilder: (context, index) => const Gap(8),
      scrollDirection: Axis.horizontal,
      key: state.key,
      itemCount:
          state.hasReachedMax ? state.movies.length : state.movies.length + 1,
      itemBuilder: (context, index) {
        return index >= state.movies.length
            ? const Loader()
            : MovieCard(
                movie: state.movies.elementAt(index),
              );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Movie Buddy"),
      centerTitle: true,
    );
  }

  @override
  void dispose() {
    _popularScrollController
      ..removeListener(_onPopularMoviesScroll)
      ..dispose();
    _topRatedScrollController
      ..removeListener(_onTopRatedMoviesScroll)
      ..dispose();
    super.dispose();
  }

  void _onPopularMoviesScroll() {
    if (_isEnd(_popularScrollController)) {
      context.read<MovieBloc>().add(MoviesFetched());
    }
  }

  void _onTopRatedMoviesScroll() {
    if (_isEnd(_topRatedScrollController)) {
      context.read<MovieTopRatedBloc>().add(MoviesFetched());
    }
  }

  bool _isEnd(ScrollController scrollController) {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
