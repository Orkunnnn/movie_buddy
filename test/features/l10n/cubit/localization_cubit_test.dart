import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_buddy/core/l10n/cubit/localization_cubit.dart';

import '../../../helpers/hydrated_bloc.dart';

void main() {
  initHydratedStorage();
  group(
    "LocalizationCubit",
    () {
      test(
        "initial state is correct",
        () {
          expect(LocalizationCubit().state, null);
        },
      );
      group(
        "fromJson",
        () {
          test(
            "works correctly",
            () {
              expect(
                LocalizationCubit().fromJson({"locale": "en"}),
                const Locale("en"),
              );
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
              const state = Locale("tr");
              expect(LocalizationCubit().toJson(state), {"locale": "tr"});
            },
          );
        },
      );
      group(
        "setLocale",
        () {
          test(
            "works correctly",
            () {
              final cubit = LocalizationCubit()..setLocale(const Locale("tr"));
              expect(cubit.state, const Locale("tr"));
            },
          );
        },
      );
    },
  );
}
