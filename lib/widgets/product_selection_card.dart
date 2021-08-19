import 'package:flutter/material.dart';
import 'package:splasha/models/category_info.dart';
import 'package:splasha/data/category_info_data.dart';

class ProductSelectionCard extends StatelessWidget {
  const ProductSelectionCard(
      {Key key,
      @required this.categoryInfo,
      this.image,
      this.vehicleType,
      this.price,
      this.onPressed,
      this.washType,
      this.selectedWash})
      : super(key: key);

  final CategoryInfo categoryInfo;

  final String image;
  final String vehicleType;
  final String price;
  final VoidCallback onPressed;
  final String washType;
  final String selectedWash;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onPressed,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              width: width / 1.2,
              height: height / 3,
              child: Column(
                children: [
                  Stack(
                    children: [

                      Container(
                        height: height / 4,
                        width: width / 1.2,
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(image),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 10,
                        child: Text(
                          selectedWash,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            vehicleType,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        Container(
                          child: Text(
                            price.substring(0, 3),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: height / 32,
        ),
      ],
    );
  }
}
