import 'package:flutter/widgets.dart';
import 'package:movie_buddy_ui/src/colors.dart';
import 'package:movie_buddy_ui/src/typography/font_weights.dart';

class MovieBuddyDesktopTextStyle {
  static const _baseTextStyle = TextStyle(
    package: "movie_buddy_ui",
    fontFamily: "Montserrat",
    color: MovieBuddyColors.black,
    fontWeight: MovieBuddyFontWeight.regular,
  );

  static TextStyle get headlineLarge {
    return _baseTextStyle.copyWith(
      fontSize: 64,
      height: 1.25,
      fontWeight: MovieBuddyFontWeight.bold,
    );
  }

  static TextStyle get headlineMedium {
    return _baseTextStyle.copyWith(
      fontSize: 54,
      height: 16 / 13,
      fontWeight: MovieBuddyFontWeight.medium,
    );
  }

  static TextStyle get headlineSmall {
    return _baseTextStyle.copyWith(
      fontSize: 32,
      height: 1.25,
      fontWeight: MovieBuddyFontWeight.medium,
    );
  }

  static TextStyle get titleSmall {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      height: 4 / 3,
      fontWeight: MovieBuddyFontWeight.medium,
    );
  }

  static TextStyle get bodyLarge {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      height: 4 / 3,
      fontWeight: MovieBuddyFontWeight.medium,
    );
  }

  static TextStyle get bodyMedium {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      height: 10 / 7,
      fontWeight: MovieBuddyFontWeight.regular,
    );
  }

  static TextStyle get bodySmall {
    return _baseTextStyle.copyWith(
      fontSize: 12,
      height: 5 / 3,
      fontWeight: MovieBuddyFontWeight.regular,
    );
  }

  static TextStyle get labelLarge {
    return _baseTextStyle.copyWith(
      fontSize: 20,
      height: 1.4,
      fontWeight: MovieBuddyFontWeight.medium,
    );
  }
}

class MovieBuddyMobileTextStyle {
  static const _baseTextStyle = TextStyle(
    package: 'movie_buddy_ui',
    fontFamily: 'GoogleSans',
    color: MovieBuddyColors.black,
    fontWeight: MovieBuddyFontWeight.regular,
  );

  static TextStyle get headlineLarge {
    return _baseTextStyle.copyWith(
      fontSize: 34,
      height: 22 / 17,
      fontWeight: MovieBuddyFontWeight.bold,
    );
  }

  static TextStyle get headlineMedium {
    return _baseTextStyle.copyWith(
      fontSize: 34,
      height: 1,
      fontWeight: MovieBuddyFontWeight.medium,
    );
  }

  static TextStyle get headlineSmall {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      height: 4 / 3,
      fontWeight: MovieBuddyFontWeight.medium,
    );
  }

  static TextStyle get titleSmall {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      height: 4 / 3,
      fontWeight: MovieBuddyFontWeight.medium,
    );
  }

  static TextStyle get bodyLarge {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      height: 1.5,
      fontWeight: MovieBuddyFontWeight.regular,
    );
  }

  static TextStyle get bodyMedium {
    return _baseTextStyle.copyWith(
      fontSize: 12,
      height: 5 / 3,
      fontWeight: MovieBuddyFontWeight.regular,
    );
  }

  static TextStyle get bodySmall {
    return _baseTextStyle.copyWith(
      fontSize: 12,
      height: 5 / 3,
      fontWeight: MovieBuddyFontWeight.regular,
    );
  }

  static TextStyle get labelLarge {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      height: 14 / 9,
      fontWeight: MovieBuddyFontWeight.medium,
    );
  }
}
