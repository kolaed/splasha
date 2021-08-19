import 'package:flutter/material.dart';
import 'package:splasha/models/category_info.dart';
import 'package:splasha/data/category_info_data.dart';
import 'package:splasha/widgets/menu_headline_card.dart';
import 'car_wash_menu.dart';

class CategoryMenu extends StatelessWidget {

  final List<CategoryInfo> _categories= categoryInfo;



  @override
  Widget build(BuildContext context) {



    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 337,
            color: Colors.white,
            child: Column(
              children: [
                MenuHeadline(),
                CarWashMenu(categories:_categories),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
