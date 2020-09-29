import 'package:flutter/material.dart';
import 'color_theme.dart';

ThemeData pxAppTheme = ThemeData(
  fontFamily: 'TTCommons',
  backgroundColor: Yellow.sunYellow,
  primaryColor: White.white,
  accentColor: Yellow.sunYellow,
  buttonColor: Purple.barneyPurple,
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    fillColor: White.white,
    focusColor: White.white,
    contentPadding: EdgeInsets.all(10),
    filled: true,
  ),
  buttonTheme: ButtonThemeData(
    //update and enhance in screens where necessary
    buttonColor: Purple.barneyPurple,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  toggleableActiveColor: Purple.royalPurple,
);
