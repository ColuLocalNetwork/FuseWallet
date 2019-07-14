

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusewallet/modals/user.dart';
import 'package:fusewallet/modals/views/wallet_wrappermodel.dart';
import 'package:fusewallet/redux/state/app_state.dart';
import 'package:fusewallet/screens/wallet.dart';

class WalletPageWapper extends StatelessWidget {
  WalletPageWapper({Key key, this.title, this.user, this.has3boxAccount, this.store})
      : super(key: key);

  final User user;
  final bool has3boxAccount;
  final String title;
  final store;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, WalletWrapperViewModel>(
      converter: (store) {
        return WalletWrapperViewModel.fromStore(store);
      },
      builder: (context, WalletWrapperViewModel walletWrapperViewModel) {
        return WalletPage(walletWrapperViewModel: walletWrapperViewModel,);
      },
    );
  }
}
