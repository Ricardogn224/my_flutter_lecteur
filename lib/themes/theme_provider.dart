import 'package:flutter/material.dart';
import 'package:my_flutter_lecteur/themes/light_mode.dart';
import 'package:my_flutter_lecteur/themes/dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initialy, light mode
  ThemeData _themeData = ligthMode;

  // get theme
  ThemeData get themeData => _themeData;

  // set theme

  //is dark mode
  bool get isDarkMode => _themeData == darkMode;

  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    //update the ui
    notifyListeners();
  }

  //toggle theme
  void toggleTheme() {
    _themeData = isDarkMode ? ligthMode : darkMode;
    notifyListeners();
  }
}
