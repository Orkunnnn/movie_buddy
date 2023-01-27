import 'package:flutter/widgets.dart';

class Clickable extends StatelessWidget {
  const Clickable({super.key, required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
