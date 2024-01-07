import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:splasha/screens/address_look_up.dart';
import 'package:splasha/services/database.dart';

import '../constants.dart';

class AddressesStream extends StatelessWidget {
  const AddressesStream({
    Key key,
    @required FirebaseAuth firebaseAuth,
    @required this.height,
    @required this.width,
  })  : _firebaseAuth = firebaseAuth,
        super(key: key);

  final FirebaseAuth _firebaseAuth;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService(uid: _firebaseAuth.currentUser.uid)
          .addresses
          .doc(_firebaseAuth.currentUser.uid)
          .collection('user_addresses')
          .snapshots(),
      builder: (context, addressSnapshot) {
        if (!addressSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddressLookUPScreen()),
                    );
                  },
                  icon:Icon(Icons.add,color: Colors.black,)

                ),
              ],
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                  icon: Icon(
                Icons.cancel,
                color: Colors.black,
              )),
              title: Text(
                'Addresses',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: ListView.builder(
                itemCount: addressSnapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot addressesData =
                      addressSnapshot.data.docs[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context,'${addressesData['aptNumber']} ${addressesData['complexNamde']}, ${addressesData['streetNumber']} ${addressesData['street']}, ${addressesData['city']}');
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
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
                          width: width / 1.1,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Booking Date:'),
                                  Text(
                                    addressesData['complexNamde'],
                                    style: kTextDecorationMini,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Booking Time:'),
                                  Text(
                                    addressesData['streetNumber'],
                                    style: kTextDecorationMini,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Booking Address:'),
                                  Text(
                                    addressesData['street'],
                                    style: kTextDecorationMini,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
