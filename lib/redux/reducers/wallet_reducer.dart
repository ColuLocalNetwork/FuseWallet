
import 'package:fusewallet/redux/actions/wallet_actions.dart';
import 'package:fusewallet/redux/state/user_state.dart';
import 'package:fusewallet/redux/state/wallet_state.dart';
import 'package:redux/redux.dart';

final walletReducer = combineReducers<WalletState>([
  TypedReducer<WalletState, CommunityLoadedAction>(_communityLoaded),
  TypedReducer<WalletState, BalanceLoadedAction>(_balanceLoaded),
  TypedReducer<WalletState, TransactionsLoadedAction>(_transactionsLoaded),
]);

WalletState _communityLoaded(WalletState state, CommunityLoadedAction action) {
  return state.copyWith(communityAddress: action.communityAddress, tokenAddress: action.tokenAddress);
}

WalletState _balanceLoaded(WalletState state, BalanceLoadedAction action) {
  return state.copyWith(balance: action.balance);
}

WalletState _transactionsLoaded(WalletState state, TransactionsLoadedAction action) {
  return state.copyWith(transactions: action.transactions);
}