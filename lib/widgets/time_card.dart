import 'package:flutter/material.dart';

class TimeCard extends StatefulWidget {

  final String time;
  final Color color;



  TimeCard({this.time, this.color});


  @override
  _TimeCardState createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      height: 100,
      width: 100,
      child:Center(child: Text(widget.time)) ,
    );
  }
}