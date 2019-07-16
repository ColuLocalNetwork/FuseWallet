import 'package:fusewallet/modals/businesses.dart';
import 'package:fusewallet/modals/transactions.dart';
import 'package:meta/meta.dart';

@immutable
class WalletState {
  final String balance;
  final TransactionList transactions;
  final String communityAddress;
  final String tokenAddress;
  final bool communityChanged;
  final List<Business> businesses;
  final bool isFetchingBusinesses;

  WalletState({
    @required this.balance,
    @required this.transactions,
    @required this.communityAddress,
    @required this.tokenAddress,
    @required this.communityChanged,
    this.businesses = const [],
    this.isFetchingBusinesses = false,
  });

  factory WalletState.initial() {
    return new WalletState(balance: "0", transactions: null, communityChanged: false,);
  }

  WalletState copyWith(
      {String balance,
      TransactionList transactions,
      String communityAddress,
      String tokenAddress,
      bool communityChanged,
      List<Business> businesses,
      bool isFetchingBusinesses}) {
    return new WalletState(
        balance: balance ?? this.balance,
        transactions: transactions ?? this.transactions,
        communityAddress: communityAddress ?? this.communityAddress,
        tokenAddress: tokenAddress ?? this.tokenAddress,
        communityChanged: communityChanged ?? this.communityChanged,
        businesses: businesses ?? this.businesses,
        isFetchingBusinesses: isFetchingBusinesses ?? this.isFetchingBusinesses);
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

  static WalletState fromJson(dynamic json) => WalletState(
      balance: json["balance"],
      transactions: null,
      communityChanged: json["communityChanged"],
      communityAddress: json["communityAddress"]);

  dynamic toJson() => {'balance': balance, 'communityChanged': communityChanged, 'communityAddress': communityAddress};
}
