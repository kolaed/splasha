import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splasha/screens/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'splash_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xff3F6E94),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(175),
              child: Container(
                height: 350,
                width: 350,
                color: Colors.white,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'SPLASHA',
                      style: TextStyle(
                          color: Color(0xff3F6E94),
                          fontSize: 48,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
