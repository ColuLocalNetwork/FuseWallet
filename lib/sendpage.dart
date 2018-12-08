import 'package:flutter/material.dart';
import 'package:clnwallet/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:clnwallet/common.dart';
import 'globals.dart' as globals;

Future scan() async {
  try {
    //globals.sendAddress = await BarcodeScanner.scan();
    openPage(globals.scaffoldKey.currentContext, new SendPage());
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
      //setState(() {
      //  globals.balance = 'The user did not grant the camera permission!';
      //});
    } else {
      //setState(() => globals.balance = 'Unknown error: $e');
    }
  } on FormatException {
    //setState(() => globals.balance =
    //    'null (User returned using the "back"-button before scanning anything. Result)');
  } catch (e) {
    //setState(() => globals.balance = 'Unknown error: $e');
  }
}

class SendPage extends StatefulWidget {
  SendPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final addressController =
      TextEditingController(text: "");
  final amountController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void sendTransaction(_context) {
      setState(() {
        isLoading = true;
      });
      try {
        sendNIS(addressController.text, int.parse(amountController.text))
            .then((ret) {
          Navigator.of(context).pop();

          Scaffold.of(_context).showSnackBar(new SnackBar(
            content: new Text('Transaction sent successfully'),
            //duration: new Duration(seconds: 5),
          ));

          setState(() {
            isLoading = false;
          });
        });
      } catch (e) {
        print(e.toString());
        Scaffold.of(_context).showSnackBar(new SnackBar(
          content: new Text("Error sending transaction: " + e.toString()),
        ));
        setState(() {
          isLoading = false;
        });
      }
    }

    Future openCameraScan() async {
      addressController.text = await BarcodeScanner.scan();
    }

    return new Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
        ),
        body: ListView(
          children: <Widget>[
            Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: const Color(0xFF393174),
              padding: EdgeInsets.all(20.0),
              child: Text("Send",
                  style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 38,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    //width: 220,
                    padding: EdgeInsets.only(top: 10),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: <Widget>[
                        TextFormField(
                          controller: addressController,
                          decoration: new InputDecoration(
                            labelText: "Address",
                            border: new UnderlineInputBorder(
                              borderSide: new BorderSide(),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.normal),
                          ),
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              //fontFamily: 'Gotham'
                              ),
                          keyboardType: TextInputType.number,
                        ),
                        Padding(
                          child: InkWell(
                            child: Image.asset('images/scan.png', width: 28.0),
                            onTap: () {
                              openCameraScan();
                            },
                          ),
                          padding: EdgeInsets.only(bottom: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: <Widget>[
                        TextFormField(
                          controller: amountController,
                          decoration: new InputDecoration(
                              labelText: "Amount",
                              border: new UnderlineInputBorder(
                                borderSide: new BorderSide(),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(),
                              ),
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.normal),
                              hintText: "0"),
                          style: TextStyle(
                              fontSize: 32,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              //fontFamily: 'Gotham'
                              ),
                          keyboardType: TextInputType.number,
                        ),
                        Padding(
                          child: Text(
                            "₪",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context).primaryColor),
                          ),
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                      ],
                    ),
                  ),
                  //Expanded(
                  //  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Builder(
                          builder: (context) => FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: const Color(0xFF4dd9b4),
                                padding: EdgeInsets.all(15),
                                child: isLoading
                                    ? Container(
                                        child: CircularProgressIndicator(
                                            strokeWidth: 3,valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                                        width: 21.0,
                                        height: 21.0,
                                        margin: EdgeInsets.only(
                                            left: 28, right: 28),)
                                    : Text(
                                        "Send",
                                        style: TextStyle(
                                            color: const Color(0xFF003187),
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                onPressed: () {
                                  sendTransaction(context);
                                },
                              ),
                        ),
                      )
                    ],
                  ),
                  // )
                ],
              ),
            ),
          ],
        )
          ])
            );
  }
}
