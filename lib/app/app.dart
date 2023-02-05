import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/l10n/l10n.dart';
import 'package:movie_buddy/movie/bloc/movie_details_bloc.dart';
import 'package:movie_buddy/movie/bloc/movie_now_playing_bloc.dart';
import 'package:movie_buddy/movie/bloc/movie_popular_bloc.dart';
import 'package:movie_buddy/movie/bloc/movie_top_rated_bloc.dart';
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
            create: (_) => MoviePopularBloc(
              movieRepository: movieRepository,
              localizationCubit: localizationCubit,
            )..add(MoviesFetched()),
          ),
          BlocProvider(
            create: (_) => MovieDetailsBloc(
              movieRepository: movieRepository,
              localizationCubit: localizationCubit,
            ),
          ),
          BlocProvider(
            create: (_) => MovieTopRatedBloc(
              movieRepository: movieRepository,
              localizationCubit: localizationCubit,
            )..add(MoviesFetched()),
          ),
          BlocProvider(
            create: (_) => MovieNowPlayingBloc(
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
      listener: (context, state) {
        context.read<MoviePopularBloc>().add(MoviesLanguageChanged());
        context.read<MovieTopRatedBloc>().add(MoviesLanguageChanged());
        context.read<MovieNowPlayingBloc>().add(MoviesLanguageChanged());
      },
      builder: (context, locale) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              routerConfig: RouteConfig.router,
              title: "Movie Buddy",
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData.light(useMaterial3: true).copyWith(
                tooltipTheme: const TooltipThemeData(
                  triggerMode: TooltipTriggerMode.manual,
                ),
              ),
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
