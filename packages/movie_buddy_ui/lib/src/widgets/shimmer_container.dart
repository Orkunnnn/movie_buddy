import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.63,
      color: Colors.grey.shade300,
    )
        .animate(
          onPlay: (controller) => controller.loop(),
        )
        .shimmer(duration: const Duration(seconds: 1));
  }
}
