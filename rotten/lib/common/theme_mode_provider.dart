import 'package:flutter/material.dart';
import 'package:rotten/common/shared_preferences.dart';

class ThemeModeProvider extends ChangeNotifier {
  late bool _isDark;
  late ThemePreferences _themePreference;
  bool get isDark => _isDark;

  ThemeModeProvider() {
    _isDark = false;
    _themePreference = ThemePreferences();
    getPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    _themePreference.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _themePreference.getTheme();
    notifyListeners();
  }
}
