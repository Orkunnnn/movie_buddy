import 'package:flutter/widgets.dart';
import 'package:movie_buddy_ui/src/layout/breakpoints.dart';

typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    super.key,
    required this.small,
    this.medium,
    required this.large,
    this.xLarge,
    this.child,
  });

  final ResponsiveLayoutWidgetBuilder small;
  final ResponsiveLayoutWidgetBuilder? medium;
  final ResponsiveLayoutWidgetBuilder large;
  final ResponsiveLayoutWidgetBuilder? xLarge;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= MovieBuddyBreakpoints.small) {
          return small(context, child);
        }
        if (constraints.maxWidth <= MovieBuddyBreakpoints.medium) {
          return (medium ?? large).call(context, child);
        }
        if (constraints.maxWidth <= MovieBuddyBreakpoints.large) {
          return large(context, child);
        }

        return (xLarge ?? large).call(context, child);
      },
    );
  }
}
