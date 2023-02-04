import 'package:flutter/material.dart';
import 'package:flutter_nested_navigation/flutter_nested_navigation.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';
import 'package:movie_repository/movie_repository.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Clickable(
      onPressed: () => context.go(
        "/movies/${movie.id}",
        extra: movie.id,
      ),
      child: SizedBox(
        width: size.width * 0.5,
        child: Column(
          children: [
            RoundedImage(size: size, imageUrl: movie.posterPathFull!),
            Text(
              movie.title,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
