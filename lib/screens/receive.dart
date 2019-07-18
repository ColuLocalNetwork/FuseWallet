import 'package:flutter/material.dart';
import 'package:fusewallet/widgets/widgets.dart';
import 'dart:core';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fusewallet/globals.dart' as globals;

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

    //startNFC();
  }

  @override
  Widget build(BuildContext _context) {
    final scaffoldState = new GlobalKey<ScaffoldState>();

    return 
    Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
//              title: Text("hello"),
            expandedHeight: 100,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Receive",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900)),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              //background: Container(
              //color: Theme.of(context).canvasColor,
              //),
            ),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Theme.of(context).canvasColor,
          ),
          SliverFillRemaining(child:
            Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
            //color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                      "Scan the QR code to receive money",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                )
              ],
            ),
          ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 0),
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
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: 250,
                  padding: EdgeInsets.only(top: 20),
                  child: Opacity(
                     opacity: 0.5,
                     child: Center(
                       child: CopyToClipboard(scaffoldState: scaffoldState,),
                     ) ,
                  ) ,
                ),
                
              ],
            )),
          ],
        )
          ),
        ],
      ),
    );
  }
}
