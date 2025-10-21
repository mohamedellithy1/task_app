import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences sharedPreferences;

  ThemeCubit({required this.sharedPreferences}) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final themeModeString = sharedPreferences.getString(
      AppConstants.themeModeKey,
    );
    if (themeModeString != null) {
      emit(
        ThemeMode.values.firstWhere(
          (mode) => mode.toString() == themeModeString,
          orElse: () => ThemeMode.system,
        ),
      );
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await sharedPreferences.setString(
      AppConstants.themeModeKey,
      mode.toString(),
    );
    emit(mode);
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }
}
