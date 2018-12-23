import 'package:flutter/material.dart';
import 'dart:core';
import 'package:fusewallet/common.dart';
import 'package:flutter/services.dart';
import 'package:fusewallet/app.dart';
import 'package:fusewallet/screens/wallet.dart';
import 'package:fusewallet/screens/receive.dart';
import 'package:fusewallet/screens/send.dart';
import 'package:fusewallet/screens/buy.dart';
import 'globals.dart' as globals;
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  bool _isIPhoneX() {
      return Platform.isIOS;
      //if (Platform.isIOS && scaffoldKey.currentContext != null) {
      //  var size = MediaQuery.of(scaffoldKey.currentContext).size;
      //  if (size.height == 812.0 || size.width == 812.0) {
      //    return true;
      //  }
      //}
      //return false;
  }

  Widget bottomBar() {
    return new Container(
      padding: EdgeInsets.only(top: 0.0, bottom:  _isIPhoneX() ? 16 : 0, right: 0.0, left: 0.0),
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
      child:new InkWell(
        borderRadius: BorderRadius.all(
                                new Radius.circular(30.0)),
      child: new Container(
        width: 100,
              padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 0.0, left: 0.0),
        child: new Column(
          children: <Widget>[
            Image.asset('images/' + img, width: 28.0, color: const Color(0xFF979797)),
            new Text(text,
                style: new TextStyle(
                    fontSize: 14.0, color: const Color(0xFF979797)))
          ],
        ),
      ),
      onTap: ontap,
    ),
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new MaterialApp(
            title: 'Fuse Wallet',
            theme: ThemeData(
                //fontFamily: 'Gotham',
                brightness: Brightness.light,
                primaryColor: const Color(0xFF25435A),
                accentColor: const Color(0xFFA8EB8C),
                canvasColor: const Color(0xFFF8F8F8)),
            home: WalletPage(title: 'Fuse Wallet'),
          ),
        ),
        bottomBar()
      ],
    );
  }
}
