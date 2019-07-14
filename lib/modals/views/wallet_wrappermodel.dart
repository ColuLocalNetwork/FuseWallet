import 'package:fusewallet/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:fusewallet/redux/actions/signin_actions.dart';

import '../user.dart';

class WalletWrapperViewModel {
  final User user;
  final bool has3boxAccount;
  final void Function() updateHas3boxAccount;

  WalletWrapperViewModel({
    this.user,
    this.updateHas3boxAccount,
    this.has3boxAccount
  });

  static WalletWrapperViewModel fromStore(Store<AppState> store) {
    return WalletWrapperViewModel(
      user: store.state.userState.user,
      has3boxAccount: store.state.userState.has3boxAccount,
      updateHas3boxAccount: () {
        store.dispatch(UpdateHas3boxAccount());
      },
    );
  }
}