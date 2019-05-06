import 'package:flutter/material.dart';
import 'package:fusewallet/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:fusewallet/screens/signup/signup.dart';
import 'package:fusewallet/screens/wallet.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fusewallet/common.dart';
import 'package:fusewallet/screens/shop.dart';
import 'package:fusewallet/globals.dart' as globals;
import 'package:fusewallet/modals/businesses.dart';
import 'package:fusewallet/screens/send.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Backup2Page extends StatefulWidget {
  Backup2Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Backup2PageState createState() => _Backup2PageState();
}

class _Backup2PageState extends State<Backup2Page> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final addressController = TextEditingController(text: "");
  final amountController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Theme.of(context).canvasColor,
        ),
        backgroundColor: const Color(0xFFF8F8F8),
        body: ListView(children: <Widget>[
          Container(
            //color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Text("Back up",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text("Please write down words 2, 4, 6",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 30, right: 30),
            child: 
            Column(
              children: <Widget>[
                Padding(
            padding: EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Word 2',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'First name is required';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Word 4',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'First name is required';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Word 6',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'First name is required';
                      }
                    },
                  )
              ],
            ),
          )
              ],
            ),
          ),
          Center(
                    child: Container(
                      width: 200,
                      height: 50.0,
                      margin: EdgeInsets.only(top: 30, bottom: 25),
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
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(30.0))),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => WalletPage()),
                              );
                            },
                            child: Center(
                              child: Text(
                                "NEXT",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            )),
                      ),
                    ),
                  ),
        ]));
  }

  Widget wordWidget(word) {
    return Expanded(
      child: Center(
        child: Padding(
          child: Text(word,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
        ),
      ),
    );
  }
}
