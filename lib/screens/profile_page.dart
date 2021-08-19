import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splasha/constants.dart';
import 'package:splasha/models/my_user.dart';
import 'package:splasha/screens/addresses_screen.dart';
import 'package:splasha/screens/bookings_history_screen.dart';
import 'package:splasha/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:splasha/services/database.dart';

class ProfilePage extends StatelessWidget {
  final String documentId;

  ProfilePage(this.documentId);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    CollectionReference users = FirebaseFirestore.instance.collection('myUser');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: width,
                    height: height / 8,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          child: Icon(Icons.person),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: height / 14,
                          width: width / 8,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello",
                              style: kTextDecoration,
                            ),
                            Text(
                              '${data['name']}',
                              style: kTextDecoration,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: width,
                    height: height / 2.5,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AccountInfoTile(
                          width: width,
                          tileTitle: 'Account details',
                          titleIcon: Icon(Icons.person),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressesScreen(),
                              ),
                            );
                          },
                          child: AccountInfoTile(
                            width: width,
                            tileTitle: 'Saved Addresses',
                            titleIcon: Icon(Icons.location_on_outlined),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingHistoryScreen(),
                              ),
                            );
                          },
                          child: AccountInfoTile(
                            width: width,
                            tileTitle: 'Bookings',
                            titleIcon: Icon(Icons.reorder),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingHistoryScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        AccountInfoTile(
                          width: width,
                          tileTitle: 'Help',
                          titleIcon: Icon(Icons.headset_mic_rounded),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: width,
                    height: height / 8,
                    color: Colors.white,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          context.read<AuthenticationService>().signOut();
                        },
                        child: Text('logOut'),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class AccountInfoTile extends StatelessWidget {
  AccountInfoTile({
    @required this.width,
    @required this.tileTitle,
    @required this.titleIcon,
    this.onPressed,
  });

  final double width;
  final String tileTitle;
  final Icon titleIcon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  titleIcon,
                  SizedBox(width: width / 30),
                  Text(
                    tileTitle,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
          width: width / 2,
          child: Divider(
            color: Colors.blueGrey.shade200,
          ),
        )
      ],
    );
  }
}
