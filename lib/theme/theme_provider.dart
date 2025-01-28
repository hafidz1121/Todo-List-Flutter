import 'package:flutter/material.dart';

import 'theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _themeData = (_themeData.brightness == Brightness.light) ? nightMode : lightMode;
    notifyListeners();
  }
}
