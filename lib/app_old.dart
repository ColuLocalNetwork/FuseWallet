import 'package:flutter/material.dart';
import 'package:fusewallet/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fusewallet/common.dart';
import 'package:fusewallet/screens/wallet.dart';
import 'package:fusewallet/screens/receive.dart';
import 'package:fusewallet/screens/send.dart';
import 'package:fusewallet/widgets/drawer.dart';
import 'globals.dart' as globals;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String sendAddress = "";

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  final myController = TextEditingController(text: "10");

  int _selectedIndex = 0;

  final _widgetOptions = [
    new WalletPage(),
    new ReceivePage(),
    Text('Buy'),
    new SendPage(address: "",),
  ];

  @override
  void initState() {
    super.initState();
    
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext _context) {
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
                        initWallet();

                        getPublickKey().then((_publicKey) {
                          setState(() {
                            globals.publicKey = _publicKey;
                          });
                          getBalance(_publicKey).then((response) {
                            setState(() {
                              globals.balance = response.toString();
                            });
                          });
                        });
                      },
                    )),
          ],
          elevation: 0.0,
        ),
        drawer: new DrawerWidget(),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        //bottomNavigationBar: BottomNavigationBar(
        //  onTap: onTabTapped, // new
        //  currentIndex: _selectedIndex,
        //  type: BottomNavigationBarType.fixed,
        //  items: [
        //    bottomBar(Icons.home, "Wallet"),
        //    bottomBar(Icons.arrow_downward, "Receive"),
        //    bottomBar(Icons.add_shopping_cart, "Buy"),
        //    bottomBar(Icons.arrow_upward, "Send")
        //  ],
        //)
        );
  }

  BottomNavigationBarItem bottomBar(IconData icon, String text) { 
    return new BottomNavigationBarItem(
              icon: Icon(icon, color: Theme.of(context).primaryColor),
              title: Text(text, style: TextStyle(color: Theme.of(context).primaryColor),));
  }
}

class transferPrompt extends StatefulWidget {
  transferPrompt({Key key, this.outerContext}) : super(key: key);

  final dynamic outerContext;

  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<transferPrompt> {
  bool isLoading = false;
  final myController = TextEditingController(text: "10");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Amount (₪)'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: myController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: isLoading ? new CircularProgressIndicator() : Text('SEND'),
          onPressed: () {
            setState(() {
              isLoading = true;
            });

            //sendAddress = "0x104602283d94236bcea2af119d2f37d21540068c";
            sendNIS(sendAddress, int.parse(myController.text), null).then((ret) {
              Navigator.of(context).pop();

              Scaffold.of(widget.outerContext).showSnackBar(new SnackBar(
                content: new Text('Transaction sent successfully'),
                //duration: new Duration(seconds: 5),
              ));

              setState(() {
                isLoading = false;
              });
            });
          },
        ),
      ],
    );
  }
}
