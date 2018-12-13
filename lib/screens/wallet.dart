import 'package:flutter/material.dart';
import 'package:fusewallet/crypto.dart';
import 'dart:core';
import 'package:fusewallet/globals.dart' as globals;
import 'package:fusewallet/common.dart';
import 'package:fusewallet/screens/receive.dart';
import 'package:fusewallet/widgets/drawer.dart';
import 'package:fusewallet/widgets/transactions_list.dart';
import 'package:fusewallet/modals/transactions.dart';

class WalletPage extends StatefulWidget {
  WalletPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  bool isLoading = true;
  List<Transaction> transactionsList = [];

  void loadBalance() {
    setState(() {
      isLoading = true;
    });

    getPublickKey().then((_publicKey) {
      globals.publicKey = _publicKey;
      getBalance(_publicKey).then((response) {
        setState(() {
          isLoading = false;
          globals.balance = response.toString();
        });
      });
    });
  }

  void loadTransactions() {
    getPublickKey().then((_publicKey) {
      transactionsList.clear();
      getTransactions(_publicKey).then((list) {
        setState(() {
          transactionsList.addAll(list.transactions);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();

    initWallet().then((_privateKey) {
      loadBalance();
      loadTransactions();
    });
  }

  @override
  Widget build(BuildContext _context) {
    GlobalKey<ScaffoldState> scaffoldState;

    return new Scaffold(
        key: globals.scaffoldKey,
        appBar: AppBar(
          title: InkWell(
            child: Image.asset(
              'images/cln.png',
              width: 42.0,
              gaplessPlayback: true,
            ),
            onTap:
                () {}, //sendNIS("0x1b36c26c8f3b330787f6be03083eb8b9b2f1a6d5"); },
          ),
          centerTitle: true,
          actions: <Widget>[
            Builder(
                builder: (context) => IconButton(
                      icon: const Icon(Icons.refresh),
                      color: const Color(0xFFFFFFFF),
                      tooltip: 'refresh',
                      onPressed: () {
                        loadBalance();
                        loadTransactions();
                      },
                    )),
          ],
          elevation: 0.0,
        ),
        drawer: new DrawerWidget(),
        body: ListView(
          children: <Widget>[
            Container(
              height: 300.0,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(20.0),
              color: const Color(0xFF393174),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 60.0),
                    child: new RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: Theme.of(context).textTheme.title,
                        children: <TextSpan>[
                          new TextSpan(
                              text: 'Good evening,',
                              style:
                                  TextStyle(fontSize: 42, color: Colors.white)),
                          new TextSpan(
                              text: ' Mark',
                              style: TextStyle(
                                  fontSize: 42,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      verticalDirection: VerticalDirection.up,
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              child: Text("Balance",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0)),
                              padding: EdgeInsets.only(bottom: 6.0),
                            ),
                            new Container(
                              padding: EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 3.0,
                                  bottom: 3.0),
                              decoration: new BoxDecoration(
                                  border: new Border.all(
                                      color: Colors.white, width: 3.0),
                                  borderRadius: new BorderRadius.only(
                                    topLeft: new Radius.circular(0.0),
                                    topRight: new Radius.circular(30.0),
                                    bottomRight: new Radius.circular(30.0),
                                    bottomLeft: new Radius.circular(30.0),
                                  )),
                              child: isLoading
                                  ? Container(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 3),
                                      width: 28.0,
                                      height: 28.0,
                                      margin:
                                          EdgeInsets.only(left: 28, right: 28))
                                  : new RichText(
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style:
                                            Theme.of(context).textTheme.title,
                                        children: <TextSpan>[
                                          new TextSpan(
                                              text: globals.balance,
                                              style: new TextStyle(
                                                  fontSize: 32,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          new TextSpan(
                                              text: "₪",
                                              style: new TextStyle(
                                                  fontSize: 32,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  height: 0.0)),
                                        ],
                                      ),
                                    ),
                            )
                          ],
                        ),
                        new Container(
                          child: new FloatingActionButton(
                              backgroundColor: const Color(0xFF4dd9b4),
                              elevation: 0,
                              child: const Icon(
                                Icons.add,
                                size: 36.0,
                              ),
                              onPressed: () {
                                openPage(globals.scaffoldKey.currentContext, new ReceivePage());
                                //sendNIS("0x1b36c26c8f3b330787f6be03083eb8b9b2f1a6d5", 52);
                                //getBalance2();
                              }),
                          width: 46.0,
                          height: 46.0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new TransactionsWidget(transactionsList)
          ],
        ));
  }
}
