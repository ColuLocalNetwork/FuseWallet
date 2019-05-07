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
      padding: EdgeInsets.only(
          top: 0.0, bottom: _isIPhoneX() ? 16 : 0, right: 0.0, left: 0.0),
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
              theme: ThemeData(
                fontFamily: 'Gotham',
                brightness: Brightness.light,
                primaryColor: const Color(0xFF05283e),
                accentColor: const Color(0xFFA8EB8C),
                canvasColor: const Color(0xFFF8F8F8),
                scaffoldBackgroundColor: Colors.white,
                textSelectionHandleColor: const Color(0xFF05283e),
                textSelectionColor: Colors.black12,
                cursorColor: const Color(0xFF05283e),
                toggleableActiveColor: const Color(0xFF05283e),
                inputDecorationTheme: InputDecorationTheme(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFF05283e)),
                    //borderRadius: BorderRadius.all(Radius.circular(70.0))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.1)),
                        borderRadius: BorderRadius.all(Radius.circular(27.0))
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFF05283e)),
                    borderRadius: BorderRadius.all(Radius.circular(27.0))
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(27.0))
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(27.0))
                  ),
                  labelStyle: const TextStyle(
                    color: const Color(0xFF05283e),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 30)
                ),
              ),
              home: SplashScreen() //WalletPage(title: 'Fuse Wallet'),
              ),
        ),
        //bottomBar()
      ],
    );
  }
}
