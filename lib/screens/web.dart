import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:core';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fusewallet/modals/views/web_page_modal.dart';
import 'package:fusewallet/redux/state/app_state.dart';

String injectScript = "";

class WebPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, WebPageViewModel>(
      converter: (store) {
        return WebPageViewModel.fromStore(store);
      },
      builder: (context, WebPageViewModel _webPageViewModel) {
        return WebPage(
          webPageViewModel: _webPageViewModel,
        );
      },
    );
  }
}

class WebPage extends StatefulWidget {
  final String title;
  final WebPageViewModel webPageViewModel;

  WebPage({Key key, this.title, this.webPageViewModel}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final assetIdController = TextEditingController(text: "");
  bool isValid = true;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onUrlChange;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String getInjectString() {
    return ("""
      window.user = {
        account: '${widget.webPageViewModel.user.publicKey}'
      }
      window.pk = '0x${widget.webPageViewModel.user.privateKey}'
    """);
  }

  @override
  void initState() {
    super.initState();

    _onUrlChange = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        String jsCode = getInjectString();
        flutterWebviewPlugin.evalJavascript(jsCode);
      }
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        if (state.type == WebViewState.finishLoad) {
          // String jsCode = getInjectString();
          // flutterWebviewPlugin.evalJavascript(jsCode);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _onUrlChange.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
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
      body: new WebviewScaffold(
        url: "https://communities-qa.cln.network",
        withJavascript: true,
      ),
    );
  }
}
