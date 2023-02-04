import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({super.key, required this.size, required this.imageUrl});

  final Size size;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      width: size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: OptimizedCacheImageProvider(
            imageUrl,
          ),
        ),
      ),
    );
  }
}
