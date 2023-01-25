import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:movie_buddy/home/views/home_page.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/theme/cubit/theme_cubit.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocalizationCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        )
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale?>(
      builder: (context, locale) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData.light(),
              darkTheme: MovieBuddyTheme.dark,
              themeMode: themeMode,
              locale: locale,
              home: const HomePage(),
            );
          },
        );
      },
    );
  }
}
