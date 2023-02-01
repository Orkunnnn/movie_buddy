import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nested_navigation/flutter_nested_navigation.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_buddy/movie/bloc/movie_bloc.dart';
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
    return Scaffold(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              switch (state.status) {
                case MovieStatus.success:
                  return Expanded(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      key: state.key,
                      controller: _scrollController,
                      itemCount: state.hasReachedMax
                          ? state.movies.length
                          : state.movies.length + 1,
                      itemBuilder: (context, index) {
                        return index >= state.movies.length
                            ? const BottomLoader()
                            : ListTile(
                                onTap: () => context.go(
                                  "/movies/$index",
                                  extra: state.movies.elementAt(index),
                                ),
                                title:
                                    Text(state.movies.elementAt(index).title),
                              );
                      },
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
