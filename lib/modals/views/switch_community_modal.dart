import 'package:fusewallet/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:fusewallet/redux/actions/wallet_actions.dart';


class SwitchCommunityViewModel {
  final void Function(String communityAddress) updateCommunityAddress;

  SwitchCommunityViewModel({
    this.updateCommunityAddress
  });

  static SwitchCommunityViewModel fromStore(Store<AppState> store) {
    return SwitchCommunityViewModel(
      updateCommunityAddress: (String communityAddress) {
        store.dispatch(new UpdateCommunityAddress(communityAddress));
      }
    );
  }
}