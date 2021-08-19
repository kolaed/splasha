import 'package:flutter/material.dart';

class MenuHeadline extends StatelessWidget {
  const MenuHeadline({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 337,
          child: Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/carwash3.JPG'),),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(

            child: Text(
              'CARWASH',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}

