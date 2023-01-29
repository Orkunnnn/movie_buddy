import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/l10n/l10n.dart';
import 'package:movie_buddy/movie/cubit/movie_cubit.dart';
import 'package:movie_buddy/navigation/beam_locations.dart';
import 'package:movie_buddy/theme/cubit/theme_cubit.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';
import 'package:movie_repository/movie_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.movieRepository});

  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: movieRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LocalizationCubit(),
          ),
          BlocProvider(
            create: (_) => ThemeCubit(),
          ),
          BlocProvider(
            create: (_) => MovieCubit(movieRepository),
          )
        ],
        child: _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  _AppView();

  final routerDelegate = BeamerDelegate(
    initialPath: "/movies",
    transitionDelegate: const NoAnimationTransitionDelegate(),
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        MoviesLocation(),
        MovieDetailsLocation(),
        SettingsLocation()
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale?>(
      builder: (context, locale) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              routeInformationParser: BeamerParser(),
              routerDelegate: routerDelegate,
              title: "Movie Buddy",
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData.light(),
              darkTheme: MovieBuddyTheme.dark,
              themeMode: themeMode,
              locale: locale,
            );
          },
        );
      },
    );
  }
}
