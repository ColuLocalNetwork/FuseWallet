import 'package:flutter/material.dart';
import 'dart:core';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({this.onPressed, this.label, this.width, this.height});
  final GestureTapCallback onPressed;
  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200.0,
      height: height ?? 50.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // Add one stop for each color. Stops should increase from 0 to 1
            //stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              const Color(0xFF34d080),
              const Color(0xFFfae83e),
            ],
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(30.0))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
            child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        )),
      ),
    );
  }
}
