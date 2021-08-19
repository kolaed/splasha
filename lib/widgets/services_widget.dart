import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ServicesWidget extends StatelessWidget {
  const ServicesWidget({
    Key key,
    @required this.height,
    @required this.width,
    @required this.servicesData,
  }) : super(key: key);

  final double height;
  final double width;
  final DocumentSnapshot<Object> servicesData;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height / 4,
          width: width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image:
              NetworkImage(servicesData['image']),
            ),
          ),
        ),
      ),
      Positioned(
        top: 15,
        left: 20,
        child: Text(
          servicesData['title'],
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
      )
    ]);
  }
}