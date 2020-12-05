//light_theme.dart
import 'package:flutter/material.dart';

const Color APP_PRIMARY_COLOR = Color(0xFF3977DE);
const Color APP_PRIMARY_LIGHT_COLOR = Color(0xFFD7E4F9);
const Color APP_ACCENT_COLOR = Color(0xFFF8F8F8);
const Color APP_BACKGROUND_COLOR = Color(0xFFFFFFFF);
const Color APP_BAR_BACKGROUND_COLOR = Color(0xFFFFFFFF);
const Color APP_BORDER_COLOR = Color(0xFFEAEBEC);
const Color APP_TEXT_COLOR = Color(0xFF263238);

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: APP_PRIMARY_COLOR,
    primaryColorLight: APP_PRIMARY_LIGHT_COLOR,
    accentColor: APP_ACCENT_COLOR,
    backgroundColor: APP_BACKGROUND_COLOR,
    scaffoldBackgroundColor: APP_BACKGROUND_COLOR,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: APP_TEXT_COLOR,
      ),
      headline2: TextStyle(
        fontSize: 18,
        color: APP_TEXT_COLOR,
      ),
      headline3: TextStyle(
        fontSize: 16,
        color: APP_TEXT_COLOR,
      ),
      headline4: TextStyle(
        fontSize: 14,
        color: APP_TEXT_COLOR,
      ),
      headline5: TextStyle(
        fontSize: 12,
        color: APP_TEXT_COLOR,
      ),
      headline6: TextStyle(
        fontSize: 10,
        color: APP_TEXT_COLOR,
      ),
    ),
  );
}
