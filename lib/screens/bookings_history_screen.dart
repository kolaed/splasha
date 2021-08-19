import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splasha/services/authentication_service.dart';
import 'package:splasha/services/database.dart';
import 'package:splasha/widgets/bookingHistoryWidget.dart';
import '../constants.dart';


class BookingHistoryScreen extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;



    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService(uid: _firebaseAuth.currentUser.uid).bookingsCollection
          .doc(_firebaseAuth.currentUser.uid)
          .collection('user_bookings')
          .snapshots(),
      builder: (context, bookingSnapshot) {
        if (!bookingSnapshot.hasData) {
          return Text('Loading....');
        } else {
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade50,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Text('Bookings'),
            ),
            body: ListView.builder(
                itemCount: bookingSnapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot bookingData =
                      bookingSnapshot.data.docs[index];
                  return BookingHistoryWidget(height: height, width: width, bookingData: bookingData);
                }),
          );
        }
      },
    );
  }
}


