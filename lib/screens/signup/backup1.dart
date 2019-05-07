import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fusewallet/logic/crypto.dart';
import 'package:fusewallet/logic/wallet_logic.dart';
import 'dart:core';
import 'package:fusewallet/screens/signup/backup2.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:fusewallet/widgets/buttons.dart';


class Backup1Page extends StatefulWidget {
  Backup1Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Backup1PageState createState() => _Backup1PageState();
}

class _Backup1PageState extends State<Backup1Page> {
  final scaffoldState = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  final addressController = TextEditingController(text: "");
  final amountController = TextEditingController(text: "");
  List<String> words = new List<String>();

  @override
  Future initState() {
    super.initState();

    WalletLogic.getMnemonic().then((list) {
      setState(() {
        words = list.split(" ");
      });
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
                          new InkWell(
                                child: Text("Copy to clipboard",
                              style: TextStyle(
                                  color: const Color(0xFF546c7c),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                                onTap: () async {
                                  Clipboard.setData(new ClipboardData(text: await WalletLogic.getMnemonic()));
                                  scaffoldState.currentState.showSnackBar(new SnackBar(content: new Text("Copied to Clipboard", textAlign: TextAlign.center,),));
                                },
                              )

                          ,
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
          const SizedBox(height: 16.0),
          Center(
                    child: PrimaryButton(
                      label: "NEXT",
                      onPressed: () async {
                        openPage(context, new Backup2Page());
                      },
                    )
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
