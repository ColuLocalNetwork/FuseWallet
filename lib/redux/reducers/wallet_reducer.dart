
import 'package:fusewallet/redux/actions/wallet_actions.dart';
import 'package:fusewallet/redux/state/wallet_state.dart';
import 'package:redux/redux.dart';

final walletReducer = combineReducers<WalletState>([
  TypedReducer<WalletState, CommunityLoadedAction>(_communityLoaded),
  TypedReducer<WalletState, BalanceLoadedAction>(_balanceLoaded),
  TypedReducer<WalletState, TransactionsLoadedAction>(_transactionsLoaded),
  TypedReducer<WalletState, UpdateCommunityAddress>(_updateCommunityAddress),
  TypedReducer<WalletState, CommunityChanged>(_communityChanged),
  TypedReducer<WalletState, BusinessLoadedAction>(_businessLoaded),
  TypedReducer<WalletState, StartFetching>(_startLoadingBusiness),
  TypedReducer<WalletState, DoneFeatching>(_doneLoadingBusiness),
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

WalletState _communityChanged(WalletState state, CommunityChanged action) {
  return state.copyWith(communityChanged: action.hasChanged);
}

WalletState _updateCommunityAddress(WalletState state, UpdateCommunityAddress action) {
  return state.copyWith(communityAddress: action.communityAddress, communityChanged: true);
}

WalletState _startLoadingBusiness(WalletState state, StartFetching action) {
  return state.copyWith(isFetchingBusinesses: true);
}

WalletState _doneLoadingBusiness(WalletState state, DoneFeatching action) {
  return state.copyWith(isFetchingBusinesses: false);
}

WalletState _businessLoaded(WalletState state, BusinessLoadedAction action) {
  return state.copyWith(businesses: action.businesseses);
}