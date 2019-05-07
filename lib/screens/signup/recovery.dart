import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:fusewallet/logic/wallet_logic.dart';
import 'package:fusewallet/screens/wallet.dart';
import 'package:fusewallet/widgets/buttons.dart';

class RecoveryPage extends StatefulWidget {
  RecoveryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final wordsController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

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
                Text("Sign in with a recovery phrase",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                      "This is a 12 word phrase you were given when you created your previous wallet",
                      textAlign: TextAlign.center,
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
            child: Form(
              key: _formKey,
              child: Column(
              children: <Widget>[
                TextFormField(
                  controller: wordsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Write down your 12 words...',
                  ),
                  validator: (String value) {
                    if (value.split(" ").length != 12) {
                      return 'Please enter 12 words';
                    }
                  },
                )
              ],
            ),
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
              child: PrimaryButton(
            label: "NEXT",
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await WalletLogic.setMnemonic(wordsController.text);
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
