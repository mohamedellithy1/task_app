import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageCubit extends Cubit<Locale> {
  final SharedPreferences sharedPreferences;
  static const String _languageKey = 'language_code';

  LanguageCubit({required this.sharedPreferences}) : super(const Locale('en')) {
    _loadLanguage();
  }

  void _loadLanguage() {
    final languageCode = sharedPreferences.getString(_languageKey);
    if (languageCode != null) {
      emit(Locale(languageCode));
    }
  }

  Future<void> setLanguage(Locale locale) async {
    await sharedPreferences.setString(_languageKey, locale.languageCode);
    emit(locale);
  }

  Future<void> toggleLanguage() async {
    final newLocale = state.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');
    await setLanguage(newLocale);
  }

  bool get isArabic => state.languageCode == 'ar';
  bool get isEnglish => state.languageCode == 'en';
}
