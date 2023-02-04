import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
  });

  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: borderRadius,
      ),
      height: height,
      width: width,
    )
        .animate(
          onPlay: (controller) => controller.loop(),
        )
        .shimmer(duration: const Duration(seconds: 1));
  }
}
