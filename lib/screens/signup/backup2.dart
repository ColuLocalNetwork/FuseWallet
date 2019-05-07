import 'package:flutter/material.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:fusewallet/logic/wallet_logic.dart';
import 'dart:core';
import 'package:fusewallet/screens/wallet.dart';
import 'package:fusewallet/widgets/buttons.dart';

class Backup2Page extends StatefulWidget {
  Backup2Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Backup2PageState createState() => _Backup2PageState();
}

class _Backup2PageState extends State<Backup2Page> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  List<String> words = new List<String>();
  List<int> selectedWordsNum = new List<int>();
  final _formKey = GlobalKey<FormState>();

  List<int> getRandom3Numbers() {
    var list = new List<int>.generate(12, (int index) => index + 1);
    list.shuffle();
    var _l = list.sublist(0, 3);
    _l.sort();
    return _l;
  }

  @override
  void initState() {
    super.initState();

    selectedWordsNum = getRandom3Numbers();

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
                  child: Text(
                      "Please write down words " + selectedWordsNum.join(", "),
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText:
                                  'Word ' + selectedWordsNum[0].toString(),
                            ),
                            validator: (String value) {
                              if (words[selectedWordsNum[0]-1] != value) {
                                return 'The word does not match';
                              }
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText:
                                  'Word ' + selectedWordsNum[1].toString(),
                            ),
                            validator: (String value) {
                              if (words[selectedWordsNum[1]-1] != value) {
                                return 'The word does not match';
                              }
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText:
                                  'Word ' + selectedWordsNum[2].toString(),
                            ),
                            validator: (String value) {
                              if (words[selectedWordsNum[2]-1] != value) {
                                return 'The word does not match';
                              }
                            },
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
              child: PrimaryButton(
            label: "NEXT",
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                openPageReplace(context, WalletPage());
              }
            },
          )),
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
