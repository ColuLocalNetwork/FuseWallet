import 'package:fusewallet/redux/reducers/user_reducer.dart';
import 'package:fusewallet/redux/reducers/wallet_reducer.dart';
import 'package:fusewallet/redux/state/app_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    userState: userReducer(state.userState, action),
    walletState: walletReducer(state.walletState, action),
  );
}