@TestOn("!chrome")
import 'package:platform_helper/src/mobile.dart';
import 'package:test/test.dart';

void main() {
  group(
    "MobilePlatformHelper",
    () {
      test(
        "returns true",
        () {
          expect(PlatformHelper().isMobile, true);
        },
      );
    },
  );
}
