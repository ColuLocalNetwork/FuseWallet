import 'dart:async';

import 'package:fusewallet/modals/businesses.dart';
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

ThunkAction fetchBusinesses() {
  print('fetchBusinesses');
  return (Store store) async {
    loadBusinesses(store);
  };
}

Future loadBusinesses(Store store) async {
  print('loadBusinesses');
  final String communityAddress = store.state.walletState.communityAddress;
  store.dispatch(new StartFetching());
  var businesseses = await getBusinesses(communityAddress);
  store.dispatch(new DoneFeatching());
  store.dispatch(new BusinessLoadedAction(businesseses));
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



Future loadTransactions(Store store) async {
  var publicKey = store.state.userState.user.publicKey;
  var tokenAddress = store.state.walletState.tokenAddress;
  getTransactions(publicKey, tokenAddress).then((list) {
    store.dispatch(new TransactionsLoadedAction(list));
  });
}

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

class UpdateCommunityAddress {
  final String communityAddress;

  UpdateCommunityAddress(this.communityAddress);
}

class CommunityChanged {
  final bool hasChanged;

  CommunityChanged(this.hasChanged);
}

class BusinessLoadedAction {
  final List<Business> businesseses;

  BusinessLoadedAction(this.businesseses);
}

class StartFetching {
  StartFetching();
}

class DoneFeatching {
  DoneFeatching();
}