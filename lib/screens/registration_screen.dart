
import 'package:flutter/material.dart';

import 'package:splasha/services/authentication_service.dart';
import 'package:splasha/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:splasha/constants.dart';
import 'package:provider/provider.dart';

import 'address_look_up.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  bool showSpinner = false;
  String name;
  String surname;
  String phone;
  String email;
  String password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: Colors.white,
      body:  Center(
            child: Container(
              width: width/1.2,
              child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          TextField(
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                prefixIcon: Icon(Icons.person_rounded),
                                hintText: 'Enter your name'),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                prefixIcon: Icon(Icons.phone),
                                hintText: 'Enter your phone number'),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Enter your email'),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Enter your password'),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          RoundedButton(
                            title: 'Register',
                            colour: Colors.blueAccent,
                            onPressed: () {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final newUser = context
                                    .read<AuthenticationService>()
                                    .signUp(
                                        email: email,
                                        password: password,
                                        name: name,
                                        contactNumber: phone);
                                if (newUser != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddressLookUPScreen()),
                                  );
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ],
                      ),
            ),
          ),
    );
  }
}
