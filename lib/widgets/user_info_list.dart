import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splasha/models/my_user.dart';

class UserInfoList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final myUser = Provider.of<List<MyUser>>(context);


    return ListView.builder(
      itemCount: myUser.length,
        itemBuilder:(context,index){
        return Container(
          child: Text(''),
        );
        });
  }
}
