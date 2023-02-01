import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_buddy_ui/src/colors.dart';
import 'package:movie_buddy_ui/src/layout/layout.dart';
import 'package:movie_buddy_ui/src/typography/typography.dart';

abstract class MovieBuddyTheme {
  static ThemeData get dark {
    return ThemeData(
      scaffoldBackgroundColor: MovieBuddyColors.black,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: MovieBuddyColors.black,
        brightness: Brightness.dark,
      ),
      textTheme: _textTheme.apply(bodyColor: MovieBuddyColors.white),
      elevatedButtonTheme: _darkElevatedButtonThemeData,
      textButtonTheme: _darkTextButtonThemeData,
      appBarTheme: _darkAppBarTheme,
    );
  }

  static ThemeData get darkSmall {
    return dark.copyWith(textTheme: _smallTextTheme);
  }

  static TextTheme get _textTheme {
    return TextTheme(
      headlineLarge: MovieBuddyDesktopTextStyle.headlineLarge,
      headlineMedium: MovieBuddyDesktopTextStyle.headlineMedium,
      headlineSmall: MovieBuddyDesktopTextStyle.headlineSmall,
      titleSmall: MovieBuddyDesktopTextStyle.titleSmall,
      bodyLarge: MovieBuddyDesktopTextStyle.bodyLarge,
      bodyMedium: MovieBuddyDesktopTextStyle.bodyMedium,
      bodySmall: MovieBuddyDesktopTextStyle.bodySmall,
      labelLarge: MovieBuddyDesktopTextStyle.labelLarge,
    );
  }

  static TextTheme get _smallTextTheme {
    return TextTheme(
      headlineLarge: MovieBuddyMobileTextStyle.headlineLarge,
      headlineMedium: MovieBuddyMobileTextStyle.headlineMedium,
      headlineSmall: MovieBuddyMobileTextStyle.headlineSmall,
      titleSmall: MovieBuddyMobileTextStyle.titleSmall,
      bodyLarge: MovieBuddyMobileTextStyle.bodyLarge,
      bodyMedium: MovieBuddyMobileTextStyle.bodyMedium,
      bodySmall: MovieBuddyMobileTextStyle.bodySmall,
      labelLarge: MovieBuddyMobileTextStyle.labelLarge,
    );
  }

  static IconThemeData get _darkIconThemeData {
    return const IconThemeData(color: MovieBuddyColors.white);
  }

  static AppBarTheme get _darkAppBarTheme {
    return AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      color: MovieBuddyColors.transparent,
      elevation: 0,
      actionsIconTheme: _darkIconThemeData,
    );
  }

  static TextButtonThemeData get _darkTextButtonThemeData {
    return TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: MovieBuddyColors.white),
    );
  }

  static ElevatedButtonThemeData get _darkElevatedButtonThemeData {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: MovieBuddyColors.black,
        elevation: 0,
        backgroundColor: MovieBuddyColors.yellow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: MovieBuddyPadding.all.medium,
      ),
    );
  }
}
