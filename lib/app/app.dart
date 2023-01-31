import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/l10n/l10n.dart';
import 'package:movie_buddy/movie/bloc/movie_bloc.dart';
import 'package:movie_buddy/navigation/cubit/navigation_cubit.dart';
import 'package:movie_buddy/navigation/router.dart';
import 'package:movie_buddy/theme/cubit/theme_cubit.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';
import 'package:movie_repository/movie_repository.dart';

class App extends StatelessWidget {
  App({super.key, required this.movieRepository});

  final MovieRepository movieRepository;
  final localizationCubit = LocalizationCubit();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: movieRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: localizationCubit,
          ),
          BlocProvider(
            create: (_) => ThemeCubit(),
          ),
          BlocProvider(
            create: (_) => NavigationCubit(),
          ),
          BlocProvider(
            create: (_) => MovieBloc(
              movieRepository: movieRepository,
              localizationCubit: localizationCubit,
            )..add(MoviesFetched()),
          )
        ],
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalizationCubit, Locale?>(
      listener: (context, state) =>
          context.read<MovieBloc>()..add(MoviesLanguageChanged()),
      builder: (context, locale) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              routerConfig: RouteConfig.router,
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
