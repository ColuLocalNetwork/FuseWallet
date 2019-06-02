import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:fusewallet/logic/crypto.dart';
import 'package:fusewallet/screens/signup/recovery.dart';
import 'package:fusewallet/screens/signup/signin.dart';
import 'package:fusewallet/logic/wallet_logic.dart';
import 'package:fusewallet/screens/wallet.dart';
import 'package:fusewallet/widgets/widgets.dart';
import 'package:local_auth/local_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int splashDuration = 2;
  final _controller = new PageController();
  bool isLoading = true;
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  final _kArrowColor = Colors.black.withOpacity(0.8);

  var _pages = <Widget>[
    Center(child: Image.asset('images/fuselogo3.png', width: 160)),
    Center(child: Image.asset('images/fuselogo3.png', width: 160)),
    Center(child: Image.asset('images/fuselogo3.png', width: 160)),
    Center(child: Image.asset('images/fuselogo3.png', width: 160))
  ];
  logon() async {
    //WalletLogic.init();

    //var localAuth = LocalAuthentication();
    //bool didAuthenticate =
    //await localAuth.authenticateWithBiometrics(
    //    localizedReason: 'Please authenticate to show account balance');
    
    WalletLogic.isLogged().then((isLogged) {
          if (isLogged) {
      openPageReplace(context, WalletPage());
    } else {
      setState(() {
        isLoading = false;
      });
    }
        });

    
  }

  @override
  void initState() {
    super.initState();
    logon();
  }

  void gotoPage(page) {
    _controller.animateToPage(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    var drawer = Drawer();

    return Scaffold(
        drawer: drawer,
        body: Container(
            child: Column(
          children: <Widget>[
            Expanded(
              flex: 20,
              child: Container(
                  decoration: BoxDecoration(
                    // Box decoration takes a gradient
                    gradient: LinearGradient(
                      // Where the linear gradient begins and ends
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      //stops: [0.1, 0.5, 0.7, 0.9],
                      colors: [
                        // Colors are easy thanks to Flutter's Colors class.
                        const Color(0xFF34d080),
                        const Color(0xFFfae83e),
                      ],
                    ),
                  ),
                  //alignment: FractionalOffset(0.5, 0.5),
                  child: !isLoading ? Column(
                    children: <Widget>[
                      Expanded(
                        child: new Stack(
                          children: <Widget>[
                            new PageView.builder(
                              physics: new AlwaysScrollableScrollPhysics(),
                              controller: _controller,
                              itemCount: _pages.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _pages[index % _pages.length];
                              },
                            ),
                            new Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: new Container(
                                //color: Colors.grey[800].withOpacity(0.5),
                                padding: const EdgeInsets.all(20.0),
                                child: new Center(
                                  child: new DotsIndicator(
                                    controller: _controller,
                                    itemCount: _pages.length,
                                    onPageSelected: (int page) {
                                      gotoPage(page);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Theme.of(context).primaryColor,
                                padding: EdgeInsets.only(
                                    top: 20, bottom: 20, left: 70, right: 70),
                                child: Text(
                                  "Create a new wallet",
                                  style: TextStyle(
                                      color: const Color(0xFFfae83e),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                onPressed: () {
                                  openPage(context, new SignInPage());
                                },
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: TransparentButton(
                                    label: "Restore existing wallet",
                                    onPressed: () {
                                      openPage(context, new RecoveryPage());
                                    }))
                                    
                          ],
                        ),
                      )
                      
                    ],
                  ): Preloader()
                  ),
            ),
          ],
        )));
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    //double selectedness = Curves.easeOut.transform(
    //  max(
    //    0.0,
    //    1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
    //  ),
    //);
    //double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Container(
          width: 9.0,
          height: 9.0,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(100.0),
            color: index == controller.page?.round()
                ? const Color(0xFF05283e)
                : new Color.fromRGBO(5, 40, 62, 0.3),
          ),
          child: new InkWell(
            onTap: () => onPageSelected(index),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
