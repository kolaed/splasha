import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splasha/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:splasha/screens/main_page.dart';


class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final firebaseUser = context.watch<User>();

    if (firebaseUser!=null){
      return MainPage();
    }
    return LoginScreen();

  }
}
