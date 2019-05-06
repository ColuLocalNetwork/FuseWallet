import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fusewallet/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:fusewallet/mnemonic.dart';
import 'package:fusewallet/screens/signup/backup2.dart';
import 'package:fusewallet/screens/signup/signup.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fusewallet/common.dart';
import 'package:fusewallet/screens/shop.dart';
import 'package:fusewallet/globals.dart' as globals;
import 'package:fusewallet/modals/businesses.dart';
import 'package:fusewallet/screens/send.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:web3dart/src/utils/dartrandom.dart';

class Backup1Page extends StatefulWidget {
  Backup1Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Backup1PageState createState() => _Backup1PageState();
}

class _Backup1PageState extends State<Backup1Page> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final addressController = TextEditingController(text: "");
  final amountController = TextEditingController(text: "");
  List<String> words;

  @override
  void initState() {
    super.initState();
    
    Random random = new Random.secure();
    var list = MnemonicUtils.generateMnemonic(new DartRandom(random).nextBytes(32));
    setState(() {
      words = list.split(" ");
    });
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
                  child: Text("Please write down those 12 words:",
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
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  color: const Color(0xFFFFFFFF)),
              padding: EdgeInsets.all(20.0),
              child: words.length > 0 ? Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      wordWidget(words[0]),
                      wordWidget(words[1]),
                      wordWidget(words[2])
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      wordWidget(words[3]),
                      wordWidget(words[4]),
                      wordWidget(words[5])
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      wordWidget(words[6]),
                      wordWidget(words[7]),
                      wordWidget(words[8])
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      wordWidget(words[9]),
                      wordWidget(words[10]),
                      wordWidget(words[11])
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 25),
                  child:
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Copy to clipboard",
                              style: TextStyle(
                                  color: const Color(0xFF546c7c),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 4.0),
                          Icon(
                            Icons.content_copy,
                            color: const Color(0xFF546c7c),
                            size: 16,
                          )
                        ],
                      ),
                    )
                     ,
                  ),
                ],
              ) : CircularProgressIndicator(),
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
                              openPage(context, new Backup2Page());
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
