import 'package:flutter/material.dart';
import 'package:fusewallet/logic/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:fusewallet/widgets/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:fusewallet/globals.dart' as globals;

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

final addressController =
      TextEditingController(text: "");

Future openCameraScan(openPage) async {
      addressController.text = await BarcodeScanner.scan();
      if (openPage) {
        openPage(globals.scaffoldKey.currentContext, new SendPage());
      }
    }
class SendPage extends StatefulWidget {
  SendPage({Key key, this.title, this.address, this.privateKey}) : super(key: key);

  final String title;
  final String address;
  final String  privateKey;

  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  
  final amountController = TextEditingController(text: "");

  @override
  void initState() {

    addressController.text = widget.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void sendTransaction(_context) {
      setState(() {
        isLoading = true;
      });
      try {
        sendNIS(cleanAddress(addressController.text), int.parse(amountController.text))
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

    return 
    CustomScaffold(
      title: "Send",
      children: <Widget>[
        
            Container(
            //color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                      "Scan an QR code to send money",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
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
                    autofocus: true,
                    //keyboardType: TextInputType.number,
                    style: const TextStyle(
                              fontSize: 18
                            ),
                    decoration: const InputDecoration(
                      labelText: 'Address',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Address is required';
                      }
                    },
                  ),
                        Padding(
                          child: InkWell(
                            child: Image.asset('images/scan.png', width: 28.0),
                            onTap: () {
                              openCameraScan(false);
                            },
                          ),
                          padding: EdgeInsets.only(bottom: 14, right: 20),
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
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                              fontSize: 18
                            ),
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Amount is required';
                      }
                    },
                  ),
                        Padding(
                          child: Text(
                            "\$",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context).primaryColor),
                          ),
                          padding: EdgeInsets.only(bottom: 12, right: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Center(
                    child: PrimaryButton(
                      label: "SEND",
                      onPressed: () async {
                        sendTransaction(context);
                      },
                      preload: isLoading,
                    ))
                  //Expanded(
                 
                  // )
                ],
              ),
            )
              ],
            ),
          ),

      ]);

    
    
    
  }
}
