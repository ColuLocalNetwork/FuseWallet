import 'package:flutter/material.dart';
import 'package:fusewallet/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fusewallet/common.dart';
import 'package:fusewallet/globals.dart' as globals;
import 'package:fusewallet/crypto.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  final assetIdController = TextEditingController(text: "");

  @override
  Widget build(BuildContext _context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(color: const Color(0xFFFFFFFF)),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text('Delete Account'),
            onTap: () {
              setPrivateKey("");
            },
          ),
          ListTile(
            title: Text('Generate Mnemonic'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
          ListTile(
            title: Text('Change Asset ID'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Asset ID"),
                        content: Column(children: <Widget>[
                          TextField(
                            controller: assetIdController,
                          ),
                          Row(children: <Widget>[
FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Theme.of(context).accentColor,
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setAssetID(assetIdController.text);
                              Navigator.of(context).pop(true);
                            },
                          )
                          ],)
                          
                        ]),
                      ));
            },
          ),
        ],
      ),
    );
  }
}
