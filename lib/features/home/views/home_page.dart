import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_buddy/core/l10n/cubit/localization_cubit.dart';
import 'package:movie_buddy/core/l10n/extensions/localization_extension.dart';
import 'package:movie_buddy/core/theme/cubit/theme_cubit.dart';
import 'package:movie_buddy/features/settings/views/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Buddy"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(context.locale.helloWorld),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: context.read<LocalizationCubit>(),
                      ),
                      BlocProvider.value(
                        value: context.read<ThemeCubit>(),
                      ),
                    ],
                    child: const SettingsPage(),
                  ),
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
