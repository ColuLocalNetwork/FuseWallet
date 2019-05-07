import 'package:flutter/material.dart';

void openPage(context, page) {
  if (Navigator.of(context).canPop()) {
    //Navigator.of(context).pop();
  }

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void openPageReplace(context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

bool isValidPhone(String value) {
    /*
    Pattern pattern =
        r'^(?:[+0]9)?[0-9]{9}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
      */

    if (value.length < 8) {
      return false;
    } else {
      return true;
    }
}

bool isValidEmail(String em) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}