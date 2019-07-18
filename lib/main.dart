import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:core';
import 'package:fusewallet/logic/navigation.dart';
import 'package:fusewallet/redux/state/app_state.dart';
import 'package:fusewallet/splash.dart';
import 'package:fusewallet/themes/fuse.dart';
import 'package:redux/redux.dart';
import 'redux/reducers/app_reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:flutter/foundation.dart';

void main() async {

  final persistor = Persistor<AppState>(
    storage: FlutterStorage(key: "app2"),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  final initialState = await persistor.load();
  
  final store = Store<AppState>(
      appReducer,
      initialState: initialState ?? new AppState.initial(),
      middleware: [thunkMiddleware, persistor.createMiddleware()]
  );
  
  runApp(new MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  /*
  final Store<AppState> store = Store<AppState>(
    appReducer, /* Function defined in the reducers file */
    initialState: AppState.initial(),
    middleware: createStoreMiddleware(),
  // );
  */

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new StoreProvider<AppState> (
            store: store,
            child: new MaterialApp(
              title: 'Fuse Wallet',
              navigatorKey: Keys.navKey,
              theme: getTheme(),
              home: SplashScreen() //WalletPage(title: 'Fuse Wallet'),
              
              ),
          ),
        ),
        //globals.showBottomBar ? bottomBar() : Divider()
      ],
    );
  }
}
