import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nested_navigation/flutter_nested_navigation.dart';
import 'package:gap/gap.dart';
import 'package:movie_buddy/l10n/l10n.dart';
import 'package:movie_buddy/movie/bloc/movie_bloc.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

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
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Buddy"),
        centerTitle: true,
      ),
      body: Padding(
        padding: MovieBuddyPadding.all.small,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                switch (state.status) {
                  case MovieStatus.success:
                    return Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.popularMovies,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Gap(8),
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              key: state.key,
                              controller: _scrollController,
                              itemCount: state.hasReachedMax
                                  ? state.movies.length
                                  : state.movies.length + 1,
                              itemBuilder: (context, index) {
                                return index >= state.movies.length
                                    ? const BottomLoader()
                                    : Clickable(
                                        onPressed: () => context.go(
                                          "/movies/$index",
                                          extra:
                                              state.movies.elementAt(index).id,
                                        ),
                                        child: SizedBox(
                                          width: 200,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      12,
                                                    ),
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image:
                                                          OptimizedCacheImageProvider(
                                                        state.movies
                                                            .elementAt(
                                                              index,
                                                            )
                                                            .posterPathFull!,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                state.movies
                                                    .elementAt(index)
                                                    .title,
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  case MovieStatus.failure:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case MovieStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                }
              },
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
