import 'package:fusewallet/modals/user.dart';
import 'package:fusewallet/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class WebPageViewModel {
  final User user;

  WebPageViewModel({
    this.user
  });

  static WebPageViewModel fromStore(Store<AppState> store) {
    return WebPageViewModel(
      user: store.state.userState.user
    );
  }
}