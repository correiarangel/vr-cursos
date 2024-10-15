import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ImobThemeState> {
  ThemeCubit() : super(ImobThemeState(ThemeMode.light));
  ThemeMode togglesTheme() {
    if (state.theme == ThemeMode.light) {
      emit(ImobThemeState(ThemeMode.dark));
      return ThemeMode.dark;
    } else {
      emit(ImobThemeState(ThemeMode.light));
      return ThemeMode.light;
    }
  }

  void setTheme(ThemeMode themeMode)=>  emit(ImobThemeState(themeMode));
  
}

class ImobThemeState {
  final ThemeMode theme;

  ImobThemeState(this.theme);
}
