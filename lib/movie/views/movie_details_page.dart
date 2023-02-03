import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_buddy/movie/bloc/movie_bloc.dart';
import 'package:movie_buddy/movie/bloc/movie_details_bloc.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsBloc>().add(MovieDetailsFetched(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    final movieState = context.watch<MovieDetailsBloc>().state;
    if (movieState.movieStatus == MovieStatus.success) {
      return Scaffold(
        appBar: AppBar(
          title: Text(movieState.movieDetails!.title),
        ),
        body: SlidingUpPanel(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          panelBuilder: () => Column(
            children: [
              Divider(
                thickness: 3,
                indent: MediaQuery.of(context).size.width * 0.45,
                endIndent: MediaQuery.of(context).size.width * 0.45,
              ),
              Text(
                movieState.movieDetails!.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gap(10),
              Text(movieState.movieDetails!.overview)
            ],
          ),
          parallaxEnabled: true,
          minHeight: MediaQuery.of(context).size.height * 0.12,
          parallaxOffset: 0.5,
          body: Column(
            children: [
              Image.network(
                movieState.movieDetails!.posterPathFull,
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const ShimmerText(),
      ),
      body: SlidingUpPanel(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        panelBuilder: () => Column(
          children: [
            Divider(
              thickness: 3,
              indent: MediaQuery.of(context).size.width * 0.45,
              endIndent: MediaQuery.of(context).size.width * 0.45,
            ),
            const ShimmerText()
          ],
        ),
        parallaxEnabled: true,
        minHeight: MediaQuery.of(context).size.height * 0.12,
        parallaxOffset: 0.5,
        body: Column(
          children: const [Expanded(child: ShimmerContainer())],
        ),
      ),
    );
  }
}
