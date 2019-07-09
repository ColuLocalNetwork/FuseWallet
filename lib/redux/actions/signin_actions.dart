import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:fusewallet/logic/wallet_logic.dart';
import 'package:fusewallet/modals/user.dart';
import 'package:fusewallet/screens/signup/backup1.dart';
import 'package:fusewallet/screens/signup/signin_verification.dart';
import 'package:fusewallet/screens/signup/signup.dart';
import 'package:fusewallet/screens/wallet.dart';
import 'package:fusewallet/services/wallet_service.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction loadUserState(BuildContext context) {
  return (Store store) async {
    //new Future(() async {
      /*
    WalletLogic.isLogged().then((isLogged) {
      store.dispatch(new LoadUserAction(isLogged));
      if (isLogged) {
        openPageReplace(context, WalletPage());
      }
    });
    */
    //store.dispatch(new LoginSuccessAction(null));
    //Keys.navKey.currentState.pushNamed(Routes.homeScreen);
    //});

    var _isLogged = store.state.userState.user != null && store.state.userState.user.firstName != null;
    
    //if (isLogged) {
    //  openPageReplace(context, WalletPage());
    //}
    WalletLogic.isLogged().then((isLogged) {
      store.dispatch(new LoadUserAction(_isLogged));
      if (_isLogged) {
        openPageReplace(context, WalletPage(user: store.state.userState.user));
      }
    });

  };
}

ThunkAction sendCodeToPhoneNumberCall(BuildContext context, String phone) {
  return (Store store) async {
    phone = phone.trim();

    if (phone.isEmpty || !isValidPhone(phone)) {
      store.dispatch(new LoginFailedAction());
    } else {
      store.dispatch(new StartLoadingAction());

      final PhoneVerificationCompleted verificationCompleted =
          (AuthCredential user) async {
        print(
            'Inside _sendCodeToPhoneNumber: signInWithPhoneNumber auto succeeded: $user');

        await FirebaseAuth.instance
            .signInWithCredential(user)
            .then((FirebaseUser user) async {
          final FirebaseUser currentUser =
              await FirebaseAuth.instance.currentUser();
          assert(user.uid == currentUser.uid);

          var _user = store.state.userState.user;
          _user.firstName = currentUser.displayName;
          _user.lastName = currentUser.photoUrl;
          _user.email = currentUser.email;
          _user.phone = currentUser.phoneNumber;
          store.dispatch(new UpdateUserAction(_user));

          if (currentUser.displayName != null) {
            openPage(context, new Backup1Page());
          } else {
            openPage(context, new SignUpPage());
          }

          print('signed in with phone number successful: user -> $user');
        });
      };

      final PhoneVerificationFailed verificationFailed =
          (AuthException authException) {
        print(
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
        store.dispatch(new LoginFailedAction());
      };

      final PhoneCodeSent codeSent =
          (String verificationId, [int forceResendingToken]) async {
        store.dispatch(new LoginCodeSentSuccessAction(verificationId));
        print("code sent to " + phone);
        openPage(context, new SignInVerificationPage());
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        print("time out");
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    }
  };
}

ThunkAction signInWithPhoneNumberCall(BuildContext context, String smsCode) {
  return (Store store) async {
    store.dispatch(new StartLoadingAction());

    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: store.state.userState.verificationCode,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((FirebaseUser user) async {
      final FirebaseUser currentUser =
          await FirebaseAuth.instance.currentUser();
      assert(user.uid == currentUser.uid);

      var _user = store.state.userState.user;
      if (_user == null) {
        _user = new User();
      }
      _user.firstName = currentUser.displayName;
      _user.lastName = currentUser.photoUrl;
      _user.email = currentUser.email;
      _user.phone = currentUser.phoneNumber;
      store.dispatch(new UpdateUserAction(_user));

      if (currentUser.displayName != null) {
        openPage(context, new Backup1Page());
      } else {
        openPage(context, new SignUpPage());
      }

      //setState(() {
      //  isLoading = false;
      //});

      print('signed in with phone number successful: user -> $user');
    }).catchError((err) async {
      //isValidVerificationCode = false;
      //_formKey.currentState.validate();
      store.dispatch(new LoginFailedAction());
    });
    return true;
  };
}

ThunkAction signUpCall(BuildContext context, String firstName, String lastName, String email) {
  return (Store store) async {
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    UserUpdateInfo userInfo = new UserUpdateInfo();
    userInfo.displayName = firstName;
    userInfo.photoUrl = lastName;
    currentUser.updateProfile(userInfo);

    //await storage.write(key: "firstName", value: firstNameController.text.trim());
    //await storage.write(key: "lastName", value: lastNameController.text.trim());
    //await storage.write(key: "email", value: emailController.text.trim());
    openPage(context, new Backup1Page());
    return true;
  };
}

ThunkAction generateWalletCall() {
  return (Store store) async {
    store.dispatch(new StartLoadingAction());
    var user = await generateWallet(store.state.userState.user);
    store.dispatch(new UpdateUserAction(user));
  };
}

class LoadUserAction {
  final bool isUserLogged;
  LoadUserAction(this.isUserLogged);
}

class StartLoadingAction {
  StartLoadingAction();
}

class LoginCodeSentSuccessAction {
  final String verificationCode;

  LoginCodeSentSuccessAction(this.verificationCode);
}

class UpdateUserAction {
  final User user;

  UpdateUserAction(this.user);
}

class LoginFailedAction {
  LoginFailedAction();
}
