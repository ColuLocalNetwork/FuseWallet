import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusewallet/modals/views/signin_viewmodel.dart';
import 'package:fusewallet/redux/state/app_state.dart';
import 'dart:core';
import 'package:fusewallet/widgets/widgets.dart';

class SignInVerificationPage extends StatefulWidget {
  SignInVerificationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInVerificationPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  final verificationCodeController = TextEditingController(text: "");
  bool isValidVerificationCode = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
          new StoreConnector<AppState, SignInViewModel>(
            converter: (store) {
              return SignInViewModel.fromStore(store);
            },
            builder: (_, viewModel) {
              return Padding(
            padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: verificationCodeController,
                    autofocus: true,
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
                          viewModel.signInWithPhoneNumber(context, verificationCodeController.text);
                        }
                      },
                      preload: viewModel.isLoading,
                    ),
                  )
                ],
              ),
            ),
          );
            })
          
        
      ]);
  }
}
