import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/theme/cubit/theme_cubit.dart';
import 'package:movie_buddy_ui/movie_buddy_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<void> route({
    required LocalizationCubit localizationCubit,
    required ThemeCubit themeCubit,
  }) =>
      AppPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: localizationCubit),
            BlocProvider.value(value: themeCubit)
          ],
          child: const SettingsPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Center(child: Text("Localization")),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => context
                      .read<LocalizationCubit>()
                      .setLocale(const Locale("tr")),
                  child: const Text("Türkçe"),
                ),
                ElevatedButton(
                  onPressed: () => context
                      .read<LocalizationCubit>()
                      .setLocale(const Locale("en")),
                  child: const Text("English"),
                )
              ],
            ),
          ),
          ListTile(
            title: const Center(child: Text("Theme")),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      context.read<ThemeCubit>().updateTheme(ThemeMode.light),
                  child: const Text("Light"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.read<ThemeCubit>().updateTheme(ThemeMode.system),
                  child: const Text("System"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.read<ThemeCubit>().updateTheme(ThemeMode.dark),
                  child: const Text("Dark"),
                )
              ],
            ),
          ),
          Padding(
            padding: MovieBuddyPadding.horizontal.medium,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Watch Now"),
            ),
          )
        ],
      ),
    );
  }
}
