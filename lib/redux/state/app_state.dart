import 'package:flutter/widgets.dart';
import 'package:fusewallet/redux/state/user_state.dart';
import 'package:fusewallet/redux/state/wallet_state.dart';

class AppState {
  final UserState userState;
  final WalletState walletState;

  AppState({@required this.userState, @required this.walletState});

  factory AppState.initial() {
    return AppState(
      userState: UserState.initial(),
      walletState: WalletState.initial(),
    );
  }

  AppState copyWith({
    UserState userState,
    WalletState walletState,
  }) {
    return AppState(
      userState: userState ?? this.userState,
      walletState: walletState ?? this.walletState,
    );
  }

  static AppState fromJson(dynamic json) =>
      AppState(userState: (json != null && json["userState"] != null) ? UserState.fromJson(json["userState"]) : UserState.initial(),
       walletState: (json != null && json["walletState"] != null) ? WalletState.fromJson(json["walletState"]) : WalletState.initial());

  dynamic toJson() => {'userState': userState, 'walletState': walletState};
}
