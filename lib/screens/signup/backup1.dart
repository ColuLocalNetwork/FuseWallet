import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fusewallet/logic/crypto.dart';
import 'package:fusewallet/logic/wallet_logic.dart';
import 'dart:core';
import 'package:fusewallet/screens/signup/backup2.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:fusewallet/screens/wallet.dart';
import 'package:fusewallet/widgets/widgets.dart';

class Backup1Page extends StatefulWidget {
  Backup1Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Backup1PageState createState() => _Backup1PageState();
}

class _Backup1PageState extends State<Backup1Page> {
  //final scaffoldState = new GlobalKey<ScaffoldState>();
  static GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = true;
  final addressController = TextEditingController(text: "");
  final amountController = TextEditingController(text: "");
  List<String> words = new List<String>();
  Timer _timer;

  static String initWalletCompute(str) {
    WalletLogic.init().then((list) {
      return "done";
    });
    return null;
  }

  Future initWallet() async {
    isLoading = true;

    //_timer = new Timer(const Duration(milliseconds: 500), () async {
      //setState(() {
        //String list = await compute(initWalletCompute, "");

        await WalletLogic.init();
        
        //WalletLogic.init().then((list) {
          WalletLogic.getMnemonic().then((list) {
            setState(() {
              words = list.split(" ");
              isLoading = false;
            });
          });
        //});
      //});
    //});
  }

  @override
  Future initState() {
    super.initState();

    scaffoldState = new GlobalKey<ScaffoldState>();
    initWallet();
  }

  @override
  Widget build(BuildContext context) {
    return 
    CustomScaffold(
      //key: scaffoldState,
      title: "Back up",
      children: <Widget>[
        
          Container(
            //color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text("Please write down those 12 words:",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                )
              ],
            ),
          ),
          (words.length > 0 && !isLoading)
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            color: const Color(0xFFFFFFFF)),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
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
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CopyToClipboard(
                                      context: context,
                                      scaffoldState: scaffoldState,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Icon(
                                      Icons.content_copy,
                                      color: const Color(0xFF546c7c),
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Center(
                        child: PrimaryButton(
                      label: "NEXT",
                      onPressed: () async {
                        openPage(context, new Backup2Page());
                      },
                    )),
                    const SizedBox(height: 16.0),
                    TransparentButton(
                        label: "Skip",
                        onPressed: () {
                          openPageReplace(context, WalletPage());
                        }),
                        const SizedBox(height: 30.0),
                  ],
                )
              : Padding(
                  child: Preloader(),
                  padding: EdgeInsets.only(top: 70),
                )
      ]);
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
