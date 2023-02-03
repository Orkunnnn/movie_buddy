import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShimmerText extends StatelessWidget {
  const ShimmerText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      width: 300,
      height: 10,
    )
        .animate(
          onPlay: (controller) => controller.loop(),
        )
        .shimmer(duration: const Duration(seconds: 1));
  }
}
