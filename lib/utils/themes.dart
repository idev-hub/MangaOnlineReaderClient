import 'package:flutter/material.dart';

final TextTheme textTheme = TextTheme(
  body1: TextStyle(),
  body2: TextStyle(
    fontSize: 14.0,
    fontFamily: 'NunitoSemiBold',
  ),
  headline: TextStyle(
      fontSize: 28.0,
      fontFamily: 'NunitoBlack',
      color: Colors.black
  ),
  title: TextStyle(
      fontSize: 18.0,
      fontFamily: 'NunitoBlack'
  ),
  subtitle: TextStyle(
      fontSize: 14.0,
      fontFamily: 'NunitoBlack'
  ),
  button: TextStyle(
      fontSize: 14.0,
      fontFamily: 'NunitoBold'
  ),
);
final ThemeData themeDataDark = ThemeData(
    primarySwatch: Colors.deepOrange,
    primaryColor: Color.fromRGBO(241, 90, 36, 1),
    brightness: Brightness.dark,
    fontFamily: 'Nunito',
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    textTheme: textTheme,
);
final ThemeData themeDataLight = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Nunito',
    primarySwatch: Colors.deepOrange,
    primaryColor: Color.fromRGBO(241, 90, 36, 1),
    accentColor: Color.fromRGBO(255, 140, 0, 1),
    textTheme: textTheme
);