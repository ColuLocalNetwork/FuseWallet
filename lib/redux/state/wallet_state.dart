import 'package:fusewallet/modals/transactions.dart';
import 'package:fusewallet/modals/user.dart';
import 'package:meta/meta.dart';

@immutable
class WalletState {
  final String balance;
  final TransactionList transactions;
  final String communityAddress;
  final String tokenAddress;

  WalletState({
    @required this.balance,
    @required this.transactions,
    @required this.communityAddress,
    @required this.tokenAddress
  });

  factory WalletState.initial() {
    return new WalletState(balance: "0", transactions: null);
  }

  WalletState copyWith({String balance, TransactionList transactions, String communityAddress, String tokenAddress}) {
    return new WalletState(
        balance: balance ?? this.balance, transactions: transactions ?? this.transactions, communityAddress: communityAddress ?? this.communityAddress, tokenAddress: tokenAddress ?? this.tokenAddress);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WalletState &&
              runtimeType == other.runtimeType &&
              balance == other.balance &&
              transactions == other.transactions;

  //@override
  //int get hashCode => isLoading.hashCode ^ user.hashCode;

  static WalletState fromJson(dynamic json) =>
      WalletState(balance: json["balance"], transactions: null);

  dynamic toJson() => {'balance': balance};
}
