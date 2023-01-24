import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void updateTheme(ThemeMode themeMode) {
    emit(themeMode);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    switch (json["theme"] as String) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {"theme": state.name};
  }
}
