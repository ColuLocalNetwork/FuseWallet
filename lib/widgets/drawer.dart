import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusewallet/logic/crypto.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:fusewallet/globals.dart' as globals;
//import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:fusewallet/logic/wallet_logic.dart';
import 'package:fusewallet/screens/send.dart';
import 'package:fusewallet/screens/switch_community.dart';
import 'package:fusewallet/screens/web.dart';
import 'dart:convert';
//import 'package:local_auth/local_auth.dart';

import 'package:fusewallet/splash.dart';

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
          /*
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
                          Row(
                            children: <Widget>[
                              FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
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
                                  var v =
                                      "0x308c3b277B05E75Da98b2a961b9189CA139C0De8"; //assetIdController.text
                                  setAssetID(v);
                                  var listAddress =
                                      loadListAddress(v).then((address) {
                                    setListAddress(address);
                                  });
                                  Navigator.of(context).pop(true);
                                },
                              )
                            ],
                          )
                        ]),
                      ));
            },
          ),
          */
          ListTile(
            title: Text('Switch community'),
            onTap: () {
              openPage(context, SwitchCommunityPage());
            },
          ),
          /*
          ListTile(
            title: Text('Start NFC'),
            onTap: () {
              startNFC();
            },
          ),
          ListTile(
            title: Text('Stop NFC'),
            onTap: () {
              stopNFC();
            },
          ),
          */

          /*
          ListTile(
            title: Text('Enter fingerprint'),
            onTap: () async {
              var localAuth = LocalAuthentication();
              bool didAuthenticate =
                  await localAuth.authenticateWithBiometrics(
                      localizedReason: 'Please authenticate to show account balance');
            },
          ),
          */
          
          ListTile(
            title: Text('Log out'),
            onTap: () async {
              await storage.deleteAll();
              await FirebaseAuth.instance.signOut();
              openPageReplace(context, SplashScreen());
            },
          ),
          ListTile(
            title: Text('Web text'),
            onTap: () {
              openPage(context, WebPage());
            },
          )
        ],
      ),
    );
  }
}
