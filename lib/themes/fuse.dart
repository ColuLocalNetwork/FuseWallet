import 'package:flutter/material.dart';

ThemeData getTheme() {
  return ThemeData(
    fontFamily: 'NunitoSans', //'Source',  //'Gotham',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF05283e),
    accentColor: const Color(0xFFA8EB8C),
    canvasColor: const Color(0xFFF8F8F8),
    scaffoldBackgroundColor: Colors.white,
    textSelectionHandleColor: const Color(0xFF05283e),
    textSelectionColor: Colors.black12,
    cursorColor: const Color(0xFF05283e),
    toggleableActiveColor: const Color(0xFF05283e),
    primaryColorLight: const Color(0xFF34d080),
    primaryColorDark: const Color(0xFFfae83e),
    textTheme: TextTheme(
        body1: new TextStyle(color: const Color(0xFF05283e)),
        button: new TextStyle(color: const Color(0xFF05283e))
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
