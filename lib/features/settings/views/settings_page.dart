import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/core/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/core/theme/cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          )
        ],
      ),
    );
  }
}
