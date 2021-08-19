import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';


class AddressesScreen extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    CollectionReference addresses =
    FirebaseFirestore.instance.collection('addresses');

    return StreamBuilder<QuerySnapshot>(
      stream: addresses
          .doc(_firebaseAuth.currentUser.uid)
          .collection('user_addresses')
          .snapshots(),
      builder: (context, addressSnapshot) {
        if (!addressSnapshot.hasData) {
          return Text('Loading....');
        } else {
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade50,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Text('Addresses'),
            ),
            body: ListView.builder(
                itemCount: addressSnapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot addressesData =
                  addressSnapshot.data.docs[index];
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
                          borderRadius: BorderRadius.circular(20),
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
                        width: width / 1.1,
                        child: Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                addressesData['aptNumber'],
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
                                    addressesData['complexNamde'],
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
                                    addressesData['streetNumber'],
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
                                    addressesData['street'],
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
                                    addressesData['city'],
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
                }),
          );
        }
      },
    );
  }
}
