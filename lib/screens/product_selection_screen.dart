import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splasha/models/category_info.dart';
import 'package:splasha/screens/favourites_page.dart';
import 'package:splasha/widgets/location_bar.dart';
import 'package:splasha/widgets/product_selection_card.dart';
import 'package:provider/provider.dart';

import 'booking_screen.dart';

class ProductSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final CategoryInfo categoryInfo = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryInfo.washType),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                height: height,
                child: ListView(
                  children: [
                    ProductSelectionCard(
                      selectedWash: '',
                      image: categoryInfo.imageUrl,
                      vehicleType: categoryInfo.vehicleType,
                      price: categoryInfo.price.toString(),
                      washType: categoryInfo.washType,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BookingScreen();
                            },
                            settings: RouteSettings(
                              arguments: CategoryInfo(
                                  washType: categoryInfo.washType,
                                  price: categoryInfo.price,
                                  price2: categoryInfo.price2,
                                  vehicleType: categoryInfo.vehicleType,
                                  vehicleType2: categoryInfo.vehicleType2),
                            ),
                          ),
                        );
                      },
                    ),
                    ProductSelectionCard(
                      selectedWash: '',
                      image: categoryInfo.imageUrl2,
                      vehicleType: categoryInfo.vehicleType2,
                      price: categoryInfo.price2.toString(),
                      washType: categoryInfo.washType,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return BookingScreen();
                              },
                              settings: RouteSettings(
                                  arguments: CategoryInfo(
                                      washType: categoryInfo.washType,
                                      price: categoryInfo.price2,
                                      vehicleType: categoryInfo.vehicleType2))),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
