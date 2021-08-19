import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:splasha/widgets/rounded_button.dart';

import '../constants.dart';
import 'home_page.dart';

class ForgotPasswordScreen extends StatefulWidget {


  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {


  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {

    createAlertDialog(BuildContext context){
      return showDialog(context: context,builder: (context){
        return AlertDialog(
          title: Text('Password Reset'),
          content: Text('Please check your email!'),
        );
      });
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
              ),
              Positioned(
                child: Container(
                  height: height / 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                  ),
                  child: Center(
                    child: Text(
                      'SPLASHA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: height / 6,
                left: 20,
                right: 20,
                child: Container(
                  height: height / 2,
                  width: width / 1.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 48.0,
                        ),
                        TextField(
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: Icon(Icons.mail),
                              hintText: 'Enter your email'),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        RoundedButton(
                          title: 'Reset your password',
                          colour: Colors.lightBlueAccent,
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              await  _auth.sendPasswordResetEmail(
                                  email: email).then((value)=>print('check your emails'));
                              if (email != null) {
                                createAlertDialog(context);

                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } on FirebaseAuthException catch (e) {
                              print('Failed with error code: ${e.code}');
                              print(e.message);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
