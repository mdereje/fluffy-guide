import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _colorScheme = ColorScheme(
  primary: Color.fromRGBO(244, 174, 134, 1),
  background: Color.fromRGBO(243, 243, 243, 1),
  brightness: Brightness.light,
  error: Color.fromRGBO(209, 102, 102, 1),
  onBackground: Color.fromRGBO(73, 73, 73, 1),
  onError: Color.fromRGBO(73, 73, 73, 1),
  onPrimary: Color.fromRGBO(243, 243, 243, 1),
  onSecondary: Color.fromRGBO(243, 243, 243, 1),
  onSurface: Color.fromRGBO(73, 73, 73, 1),
  secondary: Color.fromRGBO(46, 158, 70, 1),
  surface: Color.fromRGBO(243, 243, 243, 1),
);

FontStyle style = FontStyle.normal;
Color textColor = Color.fromRGBO(73, 73, 73, 1);
double textSize = 14;
FontWeight weight = FontWeight.normal;

final _textTheme = GoogleFonts.montserratTextTheme();
final _tabThemeBar = TabBarTheme(
    labelColor: _colorScheme.onSurface,
    indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: _colorScheme.primary)));

final mainTheme = ThemeData(
  useMaterial3: true,
  iconTheme: IconThemeData(color: _colorScheme.primary),
  fontFamily: 'Montserrat',
  brightness: Brightness.light,
  primaryColor: _colorScheme.primary,
  cardColor: _colorScheme.background,
  primaryColorDark: _colorScheme.primaryContainer,
  colorScheme: _colorScheme,
  errorColor: _colorScheme.error,
  textTheme: _textTheme,
  primaryTextTheme: _textTheme,
  tabBarTheme: _tabThemeBar,
);

final darkTheme = ThemeData(
  fontFamily: 'Montserrat',
  brightness: Brightness.dark,
);

MaterialColor colorToMaterialColor(Color color) {
  var colorSwatch = {
    50: Color.fromRGBO(color.red, color.green, color.blue, .1),
    100: Color.fromRGBO(color.red, color.green, color.blue, .2),
    200: Color.fromRGBO(color.red, color.green, color.blue, .3),
    300: Color.fromRGBO(color.red, color.green, color.blue, .4),
    400: Color.fromRGBO(color.red, color.green, color.blue, .5),
    500: Color.fromRGBO(color.red, color.green, color.blue, .6),
    600: Color.fromRGBO(color.red, color.green, color.blue, .7),
    700: Color.fromRGBO(color.red, color.green, color.blue, .8),
    800: Color.fromRGBO(color.red, color.green, color.blue, .9),
    900: Color.fromRGBO(color.red, color.green, color.blue, 1),
  };
  return MaterialColor(color.value, colorSwatch);
}
