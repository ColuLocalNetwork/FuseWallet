import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:fusewallet/logic/crypto.dart';
import 'dart:core';
import 'package:fusewallet/screens/signup/signup.dart';
import 'package:fusewallet/widgets/widgets.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';

final String injectScript =  ("""
  var script1 = document.createElement('script');
  script1.type='module';
  script1.src = 'https://cdn.jsdelivr.net/gh/ethereum/web3.js@1.0.0-beta.34/dist/web3.min.js';
  console.log('script1 created');
  script1.onload = function() {
    console.log('script1 loaded'); 
    var script2 = document.createElement('script');
    script2.type='module';
    script2.src = 'https://cdn.jsdelivr.net/gh/ColuLocalNetwork/hdwallet-provider@ab902221eb31c78d08aa1a7021aae1b539d71d7b/dist/hdwalletprovider.client.js';
    console.log('script2 created');
    script2.onload = function() {
      console.log('script2 loaded');
      const mnemonic = 'cinnamon tape method ceiling hurry organ air umbrella inject scene foil that';
      let provider = new HDWalletProvider(mnemonic, 'https://rpc.fuse.io');
      window.ethereum = provider;
      window.web3 = new window.Web3(provider);
      window.web3.eth.defaultAccount = provider.addresses[0];
      window.chrome = {webstore: {}};
      console.log('provider.addresses ' + provider.addresses);
    };
    document.body.appendChild(script2);
  };
  document.body.appendChild(script1);
""");

class WebPage extends StatefulWidget {
  WebPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final assetIdController = TextEditingController(text: "");
  bool isValid = true;
  static Completer<WebViewController> _webViewController =
      Completer<WebViewController>();
      

  @override
  void initState() {
    super.initState();

  }

    Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _webViewController.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {

            return FloatingActionButton(
              onPressed: () async {
//                TO LATE HERE:
                controller.data.evaluateJavascript(injectScript);
              },
              child: const Icon(Icons.refresh),
            );
          }
          return Container();
        });
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
        body: WebView(
          initialUrl: 'https://communities-qa.cln.network',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) async {
//            NOT WORKING HERE:
//            await webViewController.evaluateJavascript(injectScript);

            _webViewController.complete(webViewController);
          },
        ),
        floatingActionButton: favoriteButton(),);
  }
}
