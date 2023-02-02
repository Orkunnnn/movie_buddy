import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/movie/bloc/movie_details_bloc.dart';
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
    final movieDetails = context.watch<MovieDetailsBloc>().state.movieDetails;
    return Scaffold(
      appBar: AppBar(
        title: Text(movieDetails?.title ?? "Unknown"),
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
              movieDetails?.title ?? "Unknown",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ],
        ),
        parallaxEnabled: true,
        minHeight: MediaQuery.of(context).size.height * 0.08,
        parallaxOffset: 0.5,
        body: Column(
          children: [
            if (movieDetails != null)
              Image.network(movieDetails.posterPathFull)
            else
              const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
