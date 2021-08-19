import 'package:flutter/material.dart';
import 'package:splasha/models/category_info.dart';
import 'package:splasha/screens/product_selection_screen.dart';
import 'package:splasha/widgets/product_selection_card.dart';

import 'category_menu_card.dart';


class CarWashMenu extends StatelessWidget {
  const CarWashMenu({
    Key key,
    @required List<CategoryInfo> categories,
  }) : categories = categories, super(key: key);

  final List<CategoryInfo> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 337,
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context,int index){
          return CategoryMenuCard(
            washType:categories[index].washType ,
            price:categories[index].price.toString() ,
            specification1:categories[index].specification1 ,
            specification2: categories[index].specification2,
            specification3: categories[index].specification3,
            from: categories[index].from,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductSelectionScreen(),
                  settings: RouteSettings(
                    arguments: categories[index],
                  ),
                ),
              );
            },

          );
        },
      ),
    );
  }
}

