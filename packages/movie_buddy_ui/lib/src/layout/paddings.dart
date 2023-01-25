import 'package:flutter/widgets.dart';

enum MovieBuddyPadding {
  all,
  horizontal,
  vertical,
  horitical,
  top,
  left,
  right,
  bottom,
  tl,
  tr,
  bl,
  br,
  tlr,
  blr
}

extension MovieBuddyPaddingExtension on MovieBuddyPadding {
  static const double _smallValue = 8;
  static const double _mediumValue = 16;
  static const double _largeValue = 32;
  static const double _xLargeValue = 64;
  EdgeInsets get small {
    switch (this) {
      case MovieBuddyPadding.all:
        return const EdgeInsets.all(_smallValue);
      case MovieBuddyPadding.horizontal:
        return const EdgeInsets.symmetric(horizontal: _smallValue);
      case MovieBuddyPadding.vertical:
        return const EdgeInsets.symmetric(vertical: _smallValue);
      case MovieBuddyPadding.top:
        return const EdgeInsets.only(top: _smallValue);
      case MovieBuddyPadding.left:
        return const EdgeInsets.only(left: _smallValue);
      case MovieBuddyPadding.right:
        return const EdgeInsets.only(right: _smallValue);
      case MovieBuddyPadding.bottom:
        return const EdgeInsets.only(bottom: _smallValue);
      case MovieBuddyPadding.tl:
        return const EdgeInsets.only(top: _smallValue, left: _smallValue);
      case MovieBuddyPadding.tr:
        return const EdgeInsets.only(top: _smallValue, right: _smallValue);
      case MovieBuddyPadding.bl:
        return const EdgeInsets.only(bottom: _smallValue, left: _smallValue);
      case MovieBuddyPadding.br:
        return const EdgeInsets.only(bottom: _smallValue, right: _smallValue);
      case MovieBuddyPadding.tlr:
        return const EdgeInsets.only(
          top: _smallValue,
          left: _smallValue,
          right: _smallValue,
        );
      case MovieBuddyPadding.blr:
        return const EdgeInsets.only(
          bottom: _smallValue,
          left: _smallValue,
          right: _smallValue,
        );
      case MovieBuddyPadding.horitical:
        return const EdgeInsets.symmetric(
          horizontal: _smallValue,
          vertical: _smallValue,
        );
    }
  }

  EdgeInsets get medium {
    switch (this) {
      case MovieBuddyPadding.all:
        return const EdgeInsets.all(_mediumValue);
      case MovieBuddyPadding.horizontal:
        return const EdgeInsets.symmetric(horizontal: _mediumValue);
      case MovieBuddyPadding.vertical:
        return const EdgeInsets.symmetric(vertical: _mediumValue);
      case MovieBuddyPadding.top:
        return const EdgeInsets.only(top: _mediumValue);
      case MovieBuddyPadding.left:
        return const EdgeInsets.only(left: _mediumValue);
      case MovieBuddyPadding.right:
        return const EdgeInsets.only(right: _mediumValue);
      case MovieBuddyPadding.bottom:
        return const EdgeInsets.only(bottom: _mediumValue);
      case MovieBuddyPadding.tl:
        return const EdgeInsets.only(top: _mediumValue, left: _mediumValue);
      case MovieBuddyPadding.tr:
        return const EdgeInsets.only(top: _mediumValue, right: _mediumValue);
      case MovieBuddyPadding.bl:
        return const EdgeInsets.only(bottom: _mediumValue, left: _mediumValue);
      case MovieBuddyPadding.br:
        return const EdgeInsets.only(bottom: _mediumValue, right: _mediumValue);
      case MovieBuddyPadding.tlr:
        return const EdgeInsets.only(
          top: _mediumValue,
          left: _mediumValue,
          right: _mediumValue,
        );
      case MovieBuddyPadding.blr:
        return const EdgeInsets.only(
          bottom: _mediumValue,
          left: _mediumValue,
          right: _mediumValue,
        );
      case MovieBuddyPadding.horitical:
        return const EdgeInsets.symmetric(
          vertical: _mediumValue,
          horizontal: _mediumValue,
        );
    }
  }

  EdgeInsets get large {
    switch (this) {
      case MovieBuddyPadding.all:
        return const EdgeInsets.all(_largeValue);
      case MovieBuddyPadding.horizontal:
        return const EdgeInsets.symmetric(horizontal: _largeValue);
      case MovieBuddyPadding.vertical:
        return const EdgeInsets.symmetric(vertical: _largeValue);
      case MovieBuddyPadding.top:
        return const EdgeInsets.only(top: _largeValue);
      case MovieBuddyPadding.left:
        return const EdgeInsets.only(left: _largeValue);
      case MovieBuddyPadding.right:
        return const EdgeInsets.only(right: _largeValue);
      case MovieBuddyPadding.bottom:
        return const EdgeInsets.only(bottom: _largeValue);
      case MovieBuddyPadding.tl:
        return const EdgeInsets.only(top: _largeValue, left: _largeValue);
      case MovieBuddyPadding.tr:
        return const EdgeInsets.only(top: _largeValue, right: _largeValue);
      case MovieBuddyPadding.bl:
        return const EdgeInsets.only(bottom: _largeValue, left: _largeValue);
      case MovieBuddyPadding.br:
        return const EdgeInsets.only(bottom: _largeValue, right: _largeValue);
      case MovieBuddyPadding.tlr:
        return const EdgeInsets.only(
          top: _largeValue,
          left: _largeValue,
          right: _largeValue,
        );
      case MovieBuddyPadding.blr:
        return const EdgeInsets.only(
          bottom: _largeValue,
          left: _largeValue,
          right: _largeValue,
        );
      case MovieBuddyPadding.horitical:
        return const EdgeInsets.symmetric(
          vertical: _largeValue,
          horizontal: _largeValue,
        );
    }
  }

  EdgeInsets get xLarge {
    switch (this) {
      case MovieBuddyPadding.all:
        return const EdgeInsets.all(_xLargeValue);
      case MovieBuddyPadding.horizontal:
        return const EdgeInsets.symmetric(horizontal: _xLargeValue);
      case MovieBuddyPadding.vertical:
        return const EdgeInsets.symmetric(vertical: _xLargeValue);
      case MovieBuddyPadding.top:
        return const EdgeInsets.only(top: _xLargeValue);
      case MovieBuddyPadding.left:
        return const EdgeInsets.only(left: _xLargeValue);
      case MovieBuddyPadding.right:
        return const EdgeInsets.only(right: _xLargeValue);
      case MovieBuddyPadding.bottom:
        return const EdgeInsets.only(bottom: _xLargeValue);
      case MovieBuddyPadding.tl:
        return const EdgeInsets.only(top: _xLargeValue, left: _xLargeValue);
      case MovieBuddyPadding.tr:
        return const EdgeInsets.only(top: _xLargeValue, right: _xLargeValue);
      case MovieBuddyPadding.bl:
        return const EdgeInsets.only(bottom: _xLargeValue, left: _xLargeValue);
      case MovieBuddyPadding.br:
        return const EdgeInsets.only(bottom: _xLargeValue, right: _xLargeValue);
      case MovieBuddyPadding.tlr:
        return const EdgeInsets.only(
          top: _xLargeValue,
          left: _xLargeValue,
          right: _xLargeValue,
        );
      case MovieBuddyPadding.blr:
        return const EdgeInsets.only(
          bottom: _xLargeValue,
          left: _xLargeValue,
          right: _xLargeValue,
        );
      case MovieBuddyPadding.horitical:
        return const EdgeInsets.symmetric(
          vertical: _xLargeValue,
          horizontal: _xLargeValue,
        );
    }
  }
}
