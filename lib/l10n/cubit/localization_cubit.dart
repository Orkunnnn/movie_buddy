import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocalizationCubit extends HydratedCubit<Locale> {
  LocalizationCubit() : super(Locale(Platform.localeName));

  void setLocale(Locale locale) {
    emit(locale);
  }

  @override
  Locale? fromJson(Map<String, dynamic> json) {
    return Locale(json["locale"] as String);
  }

  @override
  Map<String, dynamic>? toJson(Locale? state) {
    return {"locale": "${state?.languageCode}"};
  }
}
