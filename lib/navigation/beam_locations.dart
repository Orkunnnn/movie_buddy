import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_buddy/home/views/home_page.dart';
import 'package:movie_buddy/settings/views/settings_page.dart';

class MoviesLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey("movies"),
          child: HomePage(),
        )
      ];

  @override
  List<Pattern> get pathPatterns => ["/movies/*"];
}

class MovieDetailsLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [];

  @override
  List<Pattern> get pathPatterns => ["/movies/details/:movieId"];
}

class SettingsLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) =>
      [const BeamPage(key: ValueKey("settings"), child: SettingsPage())];

  @override
  List<Pattern> get pathPatterns => ["/settings"];
}
