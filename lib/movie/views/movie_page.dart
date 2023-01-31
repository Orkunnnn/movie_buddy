import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_buddy/movie/bloc/movie_bloc.dart';

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
    return Column(
      children: [
        BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            switch (state.status) {
              case MovieStatus.success:
                return Expanded(
                  child: ListView.builder(
                    key: state.key,
                    controller: _scrollController,
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () => context.go("/movies/details"),
                            title: Text(state.movies[index].title),
                          ),
                          if (index != 0 && index % 20 == 0)
                            const Divider(
                              thickness: 1,
                              color: Colors.red,
                            )
                          else
                            const SizedBox.shrink()
                        ],
                      );
                    },
                  ),
                );
              case MovieStatus.failure:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case MovieStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
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
