import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences prefs;

  ThemeProvider(this.prefs) {
    _themeMode = ThemeMode.values[prefs.getInt('themeMode') ?? 0];
  }

  ThemeMode _themeMode = ThemeMode.system;
  final ValueNotifier<double> _textScaleNotifier = ValueNotifier(1.0);

  ThemeMode get themeMode => _themeMode;
  ValueNotifier<double> get textScaleNotifier => _textScaleNotifier;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    prefs.setInt('themeMode', ThemeMode.values.indexOf(_themeMode));
    notifyListeners();
  }

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    prefs.setInt('themeMode', ThemeMode.values.indexOf(_themeMode));
    notifyListeners();
  }

  void updateTextScale(double value) {
    _textScaleNotifier.value = value;
    prefs.setDouble('textScale', value); // Save to prefs
  }

  void notify() {
    notifyListeners();
  }
}