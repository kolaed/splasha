import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splasha/models/carwash_model.dart';
import 'package:splasha/screens/addresses_screen.dart';
import 'package:splasha/screens/bookings_history_screen.dart';
import 'package:splasha/screens/favourites_page.dart';
import 'package:splasha/screens/product_selection_screen.dart';
import 'package:splasha/screens/profile_page.dart';
import 'package:splasha/services/authentication_service.dart';
import 'package:splasha/services/database.dart';
import 'package:splasha/widgets/category_menu.dart';
import 'package:provider/provider.dart';

import 'package:splasha/widgets/services_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



    int carWashIndex = 0;
    int cleaningIndex = 1;
    int laundryIndex  =2;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: height / 3,
                    width: width,
                    color: Colors.amber,
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: DatabaseService(uid: '').services.snapshots(),
                  builder: (context, servicesSnapshot) {
                    if (!servicesSnapshot.hasData) {
                      return Text('Loading...');
                    } else {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: servicesSnapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot servicesData =
                                servicesSnapshot.data.docs[index];

                            return GestureDetector(
                              onTap: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    if (index == carWashIndex) {
                                      return FavouritesPage();
                                    } else if (index == cleaningIndex) {
                                      return AddressesScreen();
                                    } else {
                                      return BookingHistoryScreen();
                                    }
                                  }),
                                );
                              },
                              child: ServicesWidget(
                                  height: height,
                                  width: width,
                                  servicesData: servicesData),
                            );
                          });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
