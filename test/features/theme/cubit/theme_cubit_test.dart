import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_buddy/core/theme/cubit/theme_cubit.dart';

import '../../../helpers/hydrated_bloc.dart';

void main() {
  initHydratedStorage();
  group(
    "ThemeCubit",
    () {
      test(
        "initial state is ThemeMode.system",
        () {
          expect(ThemeCubit().state, ThemeMode.system);
        },
      );
      group(
        "fromJson",
        () {
          test(
            "works correctly",
            () {
              expect(ThemeCubit().fromJson({"theme": "dark"}), ThemeMode.dark);
            },
          );
        },
      );
      group(
        "toJson",
        () {
          test(
            "works correctly",
            () {
              expect(
                ThemeCubit().toJson(ThemeMode.system),
                {"theme": "system"},
              );
            },
          );
        },
      );
    },
  );
}
