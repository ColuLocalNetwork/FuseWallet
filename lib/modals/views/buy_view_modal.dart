import 'package:fusewallet/modals/businesses.dart';
import 'package:fusewallet/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class BuyViewModel {
  final List<Business> businessesList;
  final bool isLoading;

  BuyViewModel({this.businessesList, this.isLoading});

  static BuyViewModel fromStore(Store<AppState> store) {
    return new BuyViewModel(
      businessesList: store.state.walletState.businesses,
      isLoading: store.state.walletState.isFetchingBusinesses
    );
  }
}
