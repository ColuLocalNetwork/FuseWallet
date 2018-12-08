import 'package:flutter/material.dart';
import 'package:clnwallet/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'globals.dart' as globals;

class ReceivePage extends StatefulWidget {
  ReceivePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReceivePageState createState() => _ReceivePageState();
}

String sendAddress = "";

class _ReceivePageState extends State<ReceivePage> {
  bool isLoading = false;
  final myController = TextEditingController(text: "10");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext _context) {
    GlobalKey<ScaffoldState> scaffoldState;

    return new Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: const Color(0xFF393174),
              padding: EdgeInsets.all(20.0),
              child: Text("Receive",
                  style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 38,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 50),
                    width: 220,
                    child: globals.publicKey != ""
                        ? new QrImage(
                            data: globals.publicKey,
                            onError: (ex) {
                              print("[QR] ERROR - $ex");
                            },
                          )
                        : new Text(""),
                  ),
                ),
                Container(
                  width: 220,
                  padding: EdgeInsets.only(top: 20),
                  child: new Text(globals.publicKey,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color(0xFF393174),
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: 250,
                  padding: EdgeInsets.only(top: 20),
                  child: new Text("Tap to copy",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color(0xFF393174), fontSize: 14)),
                ),
                
              ],
            )),
          ],
        ));
  }
}
