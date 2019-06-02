import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusewallet/logic/crypto.dart';
import 'package:fusewallet/logic/wallet_logic.dart';
import 'package:fusewallet/screens/signup/backup1.dart';
import 'dart:core';
import 'package:fusewallet/screens/signup/signup.dart';
import 'package:fusewallet/screens/wallet.dart';
import 'package:fusewallet/widgets/widgets.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:fusewallet/globals.dart' as globals;

class SignInVerificationPage extends StatefulWidget {
  SignInVerificationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInVerificationPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final verificationCodeController = TextEditingController(text: "");
  bool isValidVerificationCode = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _signInWithPhoneNumber(String smsCode) async {
    setState(() {
      isLoading = true;
    });

    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: globals.verificationCode,
      smsCode: smsCode,
    );

     await FirebaseAuth.instance.signInWithCredential(credential)
        .then((FirebaseUser user) async {
          final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
          assert(user.uid == currentUser.uid);

          if (currentUser.displayName != null) {
            openPage(context, new Backup1Page());
          } else {
            openPage(context, new SignUpPage());
          }
          
          setState(() {
            isLoading = false;
          });

          print('signed in with phone number successful: user -> $user');
        }).catchError((err) async {
          isValidVerificationCode = false;
          _formKey.currentState.validate();
          setState(() {
            isLoading = false;
          });
        });
      return true;
  }
  
  @override
  Widget build(BuildContext context) {
    return 
    CustomScaffold(
      title: "Sign in",
      children: <Widget>[
        
          Container(
            //color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text("Please enter the code your recieved:",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: verificationCodeController,
                    style: const TextStyle(
                              fontSize: 18
                            ),
                    decoration: const InputDecoration(
                      labelText: 'Verification code',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Verification code is required';
                      }
                      if (!isValidVerificationCode) {
                        return 'Wrong verification code';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: PrimaryButton(
                      label: "NEXT",
                      onPressed: () async {
                        isValidVerificationCode = true;
                        if (_formKey.currentState.validate()) {
                          _signInWithPhoneNumber(verificationCodeController.text);
                        }
                      },
                      preload: isLoading,
                    ),
                  )
                ],
              ),
            ),
          )
        
      ]);
  }
}
