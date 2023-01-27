import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_buddy/home/views/home_page.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/theme/cubit/theme_cubit.dart';

import 'helpers/hydrated_bloc.dart';

class MockLocalizationCubit extends MockCubit<Locale?>
    implements LocalizationCubit {}

class MockThemeCubit extends MockCubit<ThemeMode> implements ThemeCubit {}

void main() {
  initHydratedStorage();
  late ThemeCubit themeCubit;
  late LocalizationCubit localizationCubit;
  setUp(
    () {
      themeCubit = MockThemeCubit();
      localizationCubit = MockLocalizationCubit();
    },
  );
  group(
    "AppView",
    () {
      testWidgets(
        "renders AppBar",
        (tester) async {
          when(
            () => themeCubit.state,
          ).thenReturn(ThemeMode.light);
          when(
            () => localizationCubit.state,
          ).thenReturn(const Locale("tr"));
          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: themeCubit,
                ),
                BlocProvider.value(value: localizationCubit)
              ],
              child: const MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: HomeView(),
              ),
            ),
          );
          expect(find.byType(AppBar), findsOneWidget);
        },
      );
      group(
        "AppBar",
        () {
          testWidgets(
            "renders icon",
            (tester) async {
              when(
                () => themeCubit.state,
              ).thenReturn(ThemeMode.light);
              when(
                () => localizationCubit.state,
              ).thenReturn(const Locale("en"));
              await tester.pumpWidget(
                MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: themeCubit),
                    BlocProvider.value(value: localizationCubit)
                  ],
                  child: const MaterialApp(
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    home: HomeView(),
                  ),
                ),
              );
              expect(find.byType(Icon), findsOneWidget);
            },
          );
        },
      );
    },
  );
}
