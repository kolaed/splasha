import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';



class BookingHistoryWidget extends StatelessWidget {
  const BookingHistoryWidget({
    Key key,
    @required this.height,
    @required this.width,
    @required this.bookingData,
  }) : super(key: key);

  final double height;
  final double width;
  final DocumentSnapshot<Object> bookingData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding:
          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          height: height / 4,
          width: width ,
          child: Container(
            padding: EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bookingData['washType'],
                  style: kTextDecoration,
                ),
                Divider(
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Booking Date:'),
                    Text(
                      bookingData['booking date'],
                      style: kTextDecorationMini,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Booking Time:'),
                    Text(
                      bookingData['bookingTime'],
                      style: kTextDecorationMini,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Booking Address:'),
                    Text(
                      bookingData['bookingAddress'],
                      style: kTextDecorationMini,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Car Type:'),
                    Text(
                      bookingData['carType'],
                      style: kTextDecorationMini,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}