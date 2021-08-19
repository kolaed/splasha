import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splasha/screens/address_look_up.dart';
import 'package:splasha/services/places_services.dart';

class LocationBar extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.only(left: 10),
          color: Color(0xFF31F2FC),
          height: 37,
          width: 340,
          child: Row(
            children: [
              Icon(Icons.location_pin),
              SizedBox(width: 10),
              Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
