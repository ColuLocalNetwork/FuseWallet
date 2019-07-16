import 'package:fusewallet/modals/user.dart';
import 'package:fusewallet/redux/actions/wallet_actions.dart';
import 'package:fusewallet/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:fusewallet/redux/actions/signin_actions.dart';


class WalletWrapperViewModel {
  final User user;
  final bool has3boxAccount;
  final bool communityChanged;
  final String communityAddress;
  final void Function(bool isChange) toggleCommunityChange;
  final void Function() updateHas3boxAccount;

  WalletWrapperViewModel({
    this.user,
    this.updateHas3boxAccount,
    this.has3boxAccount,
    this.communityChanged,
    this.communityAddress,
    this.toggleCommunityChange
  });

  static WalletWrapperViewModel fromStore(Store<AppState> store) {
    return WalletWrapperViewModel(
      user: store.state.userState.user,
      has3boxAccount: store.state.userState.has3boxAccount,
      communityChanged: store.state.walletState.communityChanged,
      communityAddress: store.state.walletState.communityAddress,
      toggleCommunityChange: (isChange) => store.dispatch(new CommunityChanged(isChange)),
      updateHas3boxAccount: () => store.dispatch(new UpdateHas3boxAccount()),
    );
  }
}