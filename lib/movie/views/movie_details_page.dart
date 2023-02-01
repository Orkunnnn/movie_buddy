import 'package:flutter/material.dart';
import 'package:movie_repository/movie_repository.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: const Center(
        child: Text("Detail"),
      ),
    );
  }
}
