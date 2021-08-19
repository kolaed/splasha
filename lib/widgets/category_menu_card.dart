import 'package:flutter/material.dart';

class CategoryMenuCard extends StatelessWidget {
  final String washType;
  final String specification1;
  final String specification2;
  final String specification3;
  final String from;
  final String price;
  final VoidCallback onPressed;
  final String imageUrl;
  final String vehicleType;

  CategoryMenuCard(
      {this.vehicleType,
        this.imageUrl,
        this.from,
      this.price,
      this.specification1,
      this.specification2,
      this.specification3,
      this.washType,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 120,
        width: 337,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      washType,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(specification1),
                    Text(specification2),
                    Text(specification3),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      from,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      price.substring(0,3),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: width / 1.5,
              height: 1,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

