import 'package:flutter/widgets.dart';

class ConditionalText extends StatelessWidget {
  const ConditionalText({
    super.key,
    required this.condition,
    required this.ifTrue,
    required this.ifFalse,
  });

  final bool condition;
  final String ifTrue;
  final String ifFalse;

  @override
  Widget build(BuildContext context) {
    return condition
        ? Text(
            ifTrue,
            textAlign: TextAlign.center,
          )
        : Text(
            ifFalse,
            textAlign: TextAlign.center,
          );
  }
}
