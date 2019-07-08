import 'package:fusewallet/modals/user.dart';
import 'package:fusewallet/redux/actions/wallet_actions.dart';
import 'package:fusewallet/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import '../transactions.dart';

class WalletViewModel {
  final String balance;
  final User user;
  final TransactionList transactions;

  final Function() initWallet;

  WalletViewModel({
    this.balance,
    this.user,
    this.transactions,
    this.initWallet,
  });

  static WalletViewModel fromStore(Store<AppState> store) {
    return WalletViewModel(
      balance: store.state.walletState.balance,
      user: store.state.userState.user,
      transactions: store.state.walletState.transactions,
      initWallet: () {
        store.dispatch(initWalletCall());
      },
    );
  }
}
