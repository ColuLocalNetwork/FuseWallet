import 'package:flutter/material.dart';
import 'dart:core';
import 'package:fusewallet/logic/common.dart';
import 'package:flutter/services.dart';
//import 'package:fusewallet/app.dart';
import 'package:fusewallet/screens/wallet.dart';
import 'package:fusewallet/screens/receive.dart';
import 'package:fusewallet/screens/send.dart';
import 'package:fusewallet/screens/buy.dart';
import 'package:fusewallet/splash.dart';
import 'package:fusewallet/themes/roost.dart';
import 'globals.dart' as globals;
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget bottomBar() {
    return new Container(
      padding: EdgeInsets.only(
          top: 0.0, bottom: isIPhoneX() ? 16 : 0, right: 0.0, left: 0.0),
      color: const Color(0xFFFFFFFF),
      child: new Directionality(
        textDirection: TextDirection.rtl,
        child: new Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            bottomBarItem("send.png", "Send", () {
              scan();
            }),
            bottomBarItem("buy.png", "Buy", () {
              openPage(globals.scaffoldKey.currentContext, new BuyPage());
            }),
            bottomBarItem("recieve.png", "Receive", () {
              openPage(globals.scaffoldKey.currentContext, new ReceivePage());
            })
          ],
        ),
      ),
    );
  }

  Widget bottomBarItem(String img, String text, ontap) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        borderRadius: BorderRadius.all(new Radius.circular(30.0)),
        child: new Container(
          width: 100,
          padding: const EdgeInsets.only(
              top: 5.0, bottom: 5.0, right: 0.0, left: 0.0),
          child: new Column(
            children: <Widget>[
              Image.asset('images/' + img,
                  width: 28.0, color: const Color(0xFF979797)),
              new Text(text,
                  style: new TextStyle(
                      fontSize: 14.0, color: const Color(0xFF979797)))
            ],
          ),
        ),
        onTap: ontap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new MaterialApp(
              title: 'Fuse Wallet',
              theme: getTheme(),
              home: SplashScreen() //WalletPage(title: 'Fuse Wallet'),
              ),
        ),
        //globals.showBottomBar ? bottomBar() : Divider()
      ],
    );
  }
}
