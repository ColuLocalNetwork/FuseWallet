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
