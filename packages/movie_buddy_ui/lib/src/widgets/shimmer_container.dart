import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.shade300,
    )
        .animate(
          onPlay: (controller) => controller.loop(),
        )
        .shimmer(duration: const Duration(seconds: 1));
  }
}
