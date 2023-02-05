import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_buddy/l10n/l10n.dart';
import 'package:movie_buddy/movie/bloc/movie_details_bloc.dart';
import 'package:movie_buddy/movie/bloc/movie_popular_bloc.dart';
import 'package:movie_buddy/movie/widgets/widgets.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  double _height = 112;
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsBloc>().add(MovieDetailsFetched(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    final movieState = context.watch<MovieDetailsBloc>().state;
    final l10n = context.l10n;
    if (movieState.movieStatus == MovieStatus.success) {
      final movieDetails = movieState.movieDetails!;
      return Scaffold(
        appBar: AppBar(
          title: Text(movieDetails.title),
        ),
        body: Stack(
          children: [
            SlidingUpPanel(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              panelBuilder: (ScrollController scrollController) =>
                  SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Divider(
                      thickness: 3,
                      indent: MediaQuery.of(context).size.width * 0.45,
                      endIndent: MediaQuery.of(context).size.width * 0.45,
                    ),
                    Padding(
                      padding: MovieBuddyPadding.horizontal.small,
                      child: Text(
                        movieDetails.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: MovieBuddyPadding.all.medium,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: movieDetails.genres
                                .map(
                                  (e) => SizedBox(
                                    height: 100,
                                    width: 150,
                                    child: Card(
                                      child: Padding(
                                        padding: MovieBuddyPadding.all.medium,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Ionicons.film,
                                              size: 32,
                                            ),
                                            Text(
                                              e.name,
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const Gap(10),
                          ConditionalText(
                            condition: movieDetails.overview.isEmpty,
                            ifTrue: l10n.noOverview,
                            ifFalse: movieDetails.overview,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              parallaxEnabled: true,
              minHeight: MediaQuery.of(context).size.height * 0.12,
              parallaxOffset: 0.5,
              body: Column(
                children: [
                  OptimizedCacheImage(
                    imageUrl: movieDetails.posterPathFull,
                    imageBuilder: (context, imageProvider) => Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: imageProvider,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => ShimmerContainer(
                      height: MediaQuery.of(context).size.height * 0.7,
                    ),
                    errorWidget: (context, url, error) => const Placeholder(),
                  ),
                ],
              ),
              onPanelSlide: (position) {
                setState(() {
                  final panelMaxScrollExtent =
                      500 - MediaQuery.of(context).size.height * 0.12;
                  _height = panelMaxScrollExtent * position +
                      MediaQuery.of(context).size.height * 0.12 +
                      12;
                });
              },
            ),
            MovieRate(height: _height, movieDetails: movieDetails)
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const ShimmerText(),
      ),
      body: SlidingUpPanel(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        panelBuilder: (ScrollController scrollController) => Column(
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
        body: ShimmerContainer(
          height: MediaQuery.of(context).size.height * 0.7,
        ),
      ),
    );
  }
}
