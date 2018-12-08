import 'package:flutter/material.dart';
import 'package:clnwallet/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:clnwallet/common.dart';
import 'globals.dart' as globals;

class ShopPage extends StatefulWidget {
  ShopPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
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
            height: 250,
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text("Mexican restaurant",
                style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
                )
,
                    Text("Family mexican restaurant",
                style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.normal))
              ],
            )
             ,
          ),
          Padding(
            padding:EdgeInsets.all(20),
            child: Text("Family mexican restaurant Family mexican restaurant Family mexican restaurant Family mexican restaurant Family mexican restaurant Family mexican ",
            style: TextStyle(
                    color: const Color(0xFF666666),
                    height: 1.3,
                    fontSize: 14,
                    fontWeight: FontWeight.normal)),
          ),
          FlatButton(
            child: Text("data"),
            onPressed: (){
              getBalance2();
            },
          ),
          Container(
            height: 200,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
               color:const Color(0xFFEAEAEA),
               borderRadius: new BorderRadius.all( new Radius.circular(15.0))
            ),
          )
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
