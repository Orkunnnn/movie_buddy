import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_buddy/l10n/l10n.dart';
import 'package:movie_buddy/movie/bloc/movie_bloc.dart';
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
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: MovieBuddyPadding.all.small,
        child: Column(
          children: [
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                switch (state.status) {
                  case MovieStatus.success:
                    return _buildPopularMovies(
                      context,
                      state,
                      () => SizedBox(
                        height: size.height * 0.4,
                        child: _buildMovieCards(state),
                      ),
                    );
                  case MovieStatus.failure:
                    return const Center(
                      child: Text("Fail"),
                    );
                  case MovieStatus.initial:
                    return _buildPopularMovies(context, state, () {
                      return SizedBox(
                        height: size.height * 0.3,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ShimmerContainer(
                            width: size.width * 0.5,
                          ),
                          separatorBuilder: (context, index) => const Gap(8),
                          itemCount: 10,
                        ),
                      );
                    });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildPopularMovies(
    BuildContext context,
    MovieState state,
    Widget Function() build,
  ) {
    final l10n = context.l10n;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.popularMovies,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          build.call()
        ],
      ),
    );
  }

  ListView _buildMovieCards(MovieState state) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Gap(8),
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      key: state.key,
      controller: _scrollController,
      itemCount:
          state.hasReachedMax ? state.movies.length : state.movies.length + 1,
      itemBuilder: (context, index) {
        return index >= state.movies.length
            ? const BottomLoader()
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
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<MovieBloc>().add(MoviesFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
