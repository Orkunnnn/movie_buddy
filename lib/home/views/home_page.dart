import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/l10n/l10n.dart';
import 'package:movie_buddy/settings/views/settings_page.dart';
import 'package:movie_buddy/theme/cubit/theme_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        actions: const [],
      ),
      body: Center(
        child: Column(
          children: [
            Text(l10n.helloWorld),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                SettingsPage.route(
                  localizationCubit: context.read<LocalizationCubit>(),
                  themeCubit: context.read<ThemeCubit>(),
                ),
              ),
              child: const Text("Go to settings"),
            )
          ],
        ),
      ),
    );
  }
}
