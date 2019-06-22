import 'package:flutter/material.dart';

ThemeData getTheme() {
  return ThemeData(
    fontFamily: 'NunitoSans', //'Source',  //'Gotham',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF0d338d),
    accentColor: const Color(0xFF4affb0),
    canvasColor: const Color(0xFFF8F8F8),
    scaffoldBackgroundColor: Colors.white,
    textSelectionHandleColor: const Color(0xFF05283e),
    textSelectionColor: Colors.black12,
    cursorColor: const Color(0xFF05283e),
    toggleableActiveColor: const Color(0xFF05283e),
    primaryColorLight: const Color(0xFF1a5af5),
    primaryColorDark: const Color(0xFF54c6d9),
    textTheme: TextTheme(
      body1: new TextStyle(color: const Color(0xFF182b5b)),
      button: new TextStyle(color: const Color(0xFFFFFFFF))
        //body1: TextStyle(fontSize: 74.0),
        ),
    inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFF05283e)),
          //borderRadius: BorderRadius.all(Radius.circular(70.0))
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF05283e)),
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        /*
                  hintStyle: const TextStyle(
                    fontSize: 30
                  ),
                  */
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 30)),
  );
}