import 'package:flutter/material.dart';

class MovieNotFound extends StatelessWidget {
  const MovieNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fail"),
      ),
      body: const Center(
        child: Text("Movie not found"),
      ),
    );
  }
}
