import 'dart:html' as html;
import "package:meta/meta.dart";

class PlatformHelper {
  @visibleForTesting
  html.Window? window;

  html.Window get _window => window ?? html.window;

  bool get isMobile {
    final userAgent = _window.navigator.userAgent.toLowerCase();
    if (userAgent.contains("iphone") ||
        userAgent.contains("android") ||
        userAgent.contains("ipad")) return true;
    return false;
  }
}
