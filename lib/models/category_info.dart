import 'package:flutter/material.dart';

class CategoryInfo {
  final String washType;
  final String specification1;
  final String specification2;
  final String specification3;
  final String from;
  final int price;
  final int price2;
  final String imageUrl;
  final String imageUrl2;
  final String vehicleType;
  final String vehicleType2;
  final VoidCallback onPressed;

  CategoryInfo(
      {this.onPressed,
      this.imageUrl,
      this.vehicleType,
      this.from,
      this.price,
      this.specification1,
      this.specification2,
      this.specification3,
      this.washType,
      this.imageUrl2,
      this.vehicleType2,
      this.price2});
}
