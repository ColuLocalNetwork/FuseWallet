import 'package:fusewallet/modals/transactions.dart';
import 'package:fusewallet/services/wallet_service.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction initWalletCall() {
  return (Store store) async {
    loadCommunity(store);
    store.dispatch(new WalletLoadedAction());
  };
}

Future loadCommunity(Store store) async {
  var communityAddress = store.state.walletState.communityAddress;
  if (communityAddress == null) {
    communityAddress = DEFAULT_COMMUNITY;
  }
  var tokenAddress = await getTokenAddress(communityAddress);
  store.dispatch(new CommunityLoadedAction(communityAddress, tokenAddress));
  loadBalance(store);
  loadTransactions(store);
}

Future loadBalance(Store store) async {
  var publicKey = store.state.userState.user.publicKey;
  var tokenAddress = store.state.walletState.tokenAddress;
  var balance = await getBalance(publicKey, tokenAddress);
  store.dispatch(new BalanceLoadedAction(balance));
}



Future loadTransactions(Store store) {
  var publicKey = store.state.userState.user.publicKey;
  var tokenAddress = store.state.walletState.tokenAddress;
  getTransactions(publicKey, tokenAddress).then((list) {
    store.dispatch(new TransactionsLoadedAction(list));
  });
}

/*
void loadBalance() {
  setState(() {
    isLoading = true;
  });

  getPublickKey().then((_publicKey) {
    getTokenAddress().then((tokenAddress) {
      globals.publicKey = _publicKey;
      print('my address: ' + _publicKey);
      getBalance(_publicKey, tokenAddress).then((response) {
        setState(() {
          isLoading = false;
          globals.balance = response.toString();
        });
      });
    });
  });
}
*/

class WalletLoadedAction {
  WalletLoadedAction();
}

class StartLoadingAction {
  StartLoadingAction();
}

class CommunityLoadedAction {
  final String communityAddress;
  final String tokenAddress;

  CommunityLoadedAction(this.communityAddress, this.tokenAddress);
}

class TransactionsLoadedAction {
  final TransactionList transactions;

  TransactionsLoadedAction(this.transactions);
}

class BalanceLoadedAction {
  final String balance;

  BalanceLoadedAction(this.balance);
}