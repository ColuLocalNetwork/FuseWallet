import 'package:flutter/material.dart';
import 'package:clnwallet/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:clnwallet/common.dart';
import 'package:clnwallet/shoppage.dart';
import 'globals.dart' as globals;

class BuyPage extends StatefulWidget {
  BuyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
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
        ),
        body: ListView(children: <Widget>[
          Container(
            color: const Color(0xFF393174),
            padding: EdgeInsets.all(20.0),
            child: Text("Buy",
                style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 38,
                    fontWeight: FontWeight.bold)),
          ),
          new shopsList()
        ]));
  }
}

class shopsList extends StatefulWidget {
  @override
  createState() => new shopsListState();
}

class shopsListState extends State<shopsList> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Expanded(
                child: new Padding(
                    padding: new EdgeInsets.only(bottom: 5.0),
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          new Divider(),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: 50,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: new CircleAvatar(backgroundColor: const Color(0xFFEAEAEA)),
                          title: Text('Nina | מסעדת נינא'),
                          subtitle: Text('Herzel st'),
                          onTap:() {
                                openPage(globals.scaffoldKey.currentContext,
                                    new ShopPage());
                              },
                        );
                      },
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
