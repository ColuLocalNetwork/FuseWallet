import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusewallet/logic/crypto.dart';
import 'package:fusewallet/logic/wallet_logic.dart';
import 'package:fusewallet/screens/signup/backup1.dart';
import 'package:fusewallet/screens/signup/signin_verification.dart';
import 'dart:core';
import 'package:fusewallet/screens/signup/signup.dart';
import 'package:fusewallet/screens/wallet.dart';
import 'package:fusewallet/widgets/widgets.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:fusewallet/globals.dart' as globals;

class SignInPage extends StatefulWidget {
  SignInPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final phoneController = TextEditingController(text: "");
  CountryCode countryCode;
  bool isValid = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _sendCodeToPhoneNumber(phone) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential user) async {
      print(
          'Inside _sendCodeToPhoneNumber: signInWithPhoneNumber auto succeeded: $user');
      setState(() {
        isLoading = false;
      });

      await FirebaseAuth.instance
          .signInWithCredential(user)
          .then((FirebaseUser user) async {
        final FirebaseUser currentUser =
            await FirebaseAuth.instance.currentUser();
        assert(user.uid == currentUser.uid);

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
      setState(() {
        isValid = false;
        isLoading = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      globals.verificationCode = verificationId;
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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Sign in",
      children: <Widget>[
        Container(
          //color: Theme.of(context).primaryColor,
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
          child: Column(
            children: <Widget>[
              //Text("Sign in",
              //    style: TextStyle(
              //        color: Theme.of(context).primaryColor,
              //        fontSize: 24,
              //        fontWeight: FontWeight.w900)),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text("Verify that you are a real person",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.body1.color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Image.asset('images/signin2.png', width: 220),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 30),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                      border: Border.all(
                          color: isValid ? const Color(0xFF05283e) : Colors.red,
                          width: 1.0),
                      borderRadius:
                          new BorderRadius.all(Radius.circular(30.0))),
                  child: Row(
                    children: <Widget>[
                      CountryCodePicker(
                        padding: EdgeInsets.only(top: 0, left: 30, right: 0),
                        onChanged: (_countryCode) {
                          countryCode = _countryCode;
                        },
                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        initialSelection: 'IL',
                        favorite: [],
                        // optional. Shows only country name and flag
                        showCountryOnly: false,
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      Icon(Icons.arrow_drop_down),
                      new Container(
                        height: 35,
                        width: 1,
                        color: const Color(0xFFc1c1c1),
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          style: const TextStyle(fontSize: 18),
                          decoration: const InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              hintText: 'Phone number',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide.none)),
                        ),
                      )
                    ],
                  ),
                ),
                !isValid
                    ? Padding(
                        child: Center(
                          child: Text("Please enter a valid phone number",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14)),
                        ),
                        padding: const EdgeInsets.only(top: 7.0),
                      )
                    : SizedBox(height: 18.0),
                const SizedBox(height: 16.0),
                Center(
                  child: PrimaryButton(
                    label: "NEXT",
                    onPressed: () async {
                      setState(() {
                        isValid = true;
                        isLoading = true;
                      });
                      if (phoneController.text.trim().isEmpty ||
                          !isValidPhone(phoneController.text.trim())) {
                        setState(() {
                          isValid = false;
                          isLoading = false;
                        });
                      } else {
                        _sendCodeToPhoneNumber(
                            countryCode.dialCode + phoneController.text.trim());
                        //await storage.write(key: "phone", value: phoneController.text.trim());
                      }
                    },
                    preload: isLoading,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
