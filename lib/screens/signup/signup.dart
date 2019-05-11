import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusewallet/logic/crypto.dart';
import 'dart:core';
import 'package:fusewallet/screens/signup/backup1.dart';
import 'package:fusewallet/widgets/widgets.dart';
import 'package:fusewallet/logic/common.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final firstNameController = TextEditingController(text: "");
  final lastNameController = TextEditingController(text: "");
  final emailController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Theme.of(context).canvasColor,
        ),
        backgroundColor: const Color(0xFFF8F8F8),
        body: ListView(children: <Widget>[
          Container(
            //color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Text("Sign up",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text("Text about siging in",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Image.asset('images/signin.png', width: 300),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: firstNameController,
                    autofocus: true,
                    style: const TextStyle(
                              fontSize: 18
                            ),
                    decoration: const InputDecoration(
                      labelText: 'First name',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'First name is required';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: lastNameController,
                    style: const TextStyle(
                              fontSize: 18
                            ),
                    decoration: const InputDecoration(
                      labelText: 'Last name',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Last name is required';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: emailController,
                    style: const TextStyle(
                              fontSize: 18
                            ),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!isValidEmail(value.trim())) {
                        return 'Please enter valid email';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: 
                    PrimaryButton(
                      label: "NEXT",
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
                          UserUpdateInfo userInfo = new UserUpdateInfo();
                          userInfo.displayName = firstNameController.text.trim();
                          userInfo.photoUrl = lastNameController.text.trim();
                          currentUser.updateProfile(userInfo);
                          //currentUser.updateEmail(emailController.text.trim());

                          await storage.write(key: "firstName", value: firstNameController.text.trim());
                          await storage.write(key: "lastName", value: lastNameController.text.trim());
                          await storage.write(key: "email", value: emailController.text.trim());
                          openPage(context, new Backup1Page());
                        }
                      },
                    )
                    
                    
                    ,
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
