import 'package:flutter/material.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';
import 'package:movie_repository/movie_repository.dart';

class MovieRate extends StatelessWidget {
  const MovieRate({
    super.key,
    required double height,
    required this.movieDetails,
  }) : _height = height;

  final double _height;
  final MovieDetails movieDetails;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _height,
      right: 20,
      child: Card(
        color: Colors.white.withOpacity(0.6),
        child: Padding(
          padding: MovieBuddyPadding.all.small,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  value: movieDetails.voteAverage / 10,
                ),
              ),
              Text(
                movieDetails.voteAverage.toStringAsPrecision(2),
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
