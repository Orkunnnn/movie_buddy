// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movie_buddy/app/app.dart';
import 'package:movie_buddy/app/app_bloc_observer.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:path_provider/path_provider.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    print(details.exceptionAsString());
    print(details.stack);
  };
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  final movieRepository = MovieRepository();
  runZonedGuarded(
    () => runApp(
      App(
        movieRepository: movieRepository,
      ),
    ),
    (error, stack) {
      print(error);
      print(stack);
    },
  );
}
