import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:splasha/screens/bookings_history_screen.dart';
import 'package:splasha/screens/favourites_page.dart';
import 'package:splasha/screens/service_coming_soon.dart';
import 'package:splasha/services/database.dart';
import 'package:splasha/widgets/services_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Widget shimmer() => Shimmer.fromColors(
          baseColor: Colors.grey[400],
          highlightColor: Colors.grey[300],
          child: Container(
              margin: const EdgeInsets.all(8.0),
              height: height / 4,
              width: width / 2,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              )),
        );

    int carWashIndex = 0;
    int cleaningIndex = 1;
    int laundryIndex = 2;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height / 3,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/splasha-808c9.appspot.com/o/jj-ying-UcI5OAPD820-unsplash.jpg?alt=media&token=7ad148e5-e84a-48a5-b853-f9ed96d0e00f'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: DatabaseService(uid: '').services.snapshots(),
                  builder: (context, servicesSnapshot) {
                    if (!servicesSnapshot.hasData) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) => shimmer(),
                      );
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
                                      return ServiceComingSoon();
                                    } else if (index == laundryIndex) {
                                      return ServiceComingSoon();
                                    } else {
                                      return null;
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
