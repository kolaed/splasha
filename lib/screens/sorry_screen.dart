import 'package:flutter/material.dart';

class SorryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('Back'),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Text('Sorry we are not available in your area yet'),
      ),
    );
  }
}
