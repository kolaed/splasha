import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splasha/services/database.dart';

import 'booking_screen.dart';

class ServiceComingSoon extends StatefulWidget {
  @override
  _ServiceComingSoonState createState() => _ServiceComingSoonState();
}

int laundryFee = 20;
// int _laundryCount = 0;

class _ServiceComingSoonState extends State<ServiceComingSoon> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Laundry', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      body: StreamBuilder<QuerySnapshot>(
          stream: DatabaseService(uid: '').laundry.snapshots(),
          builder: (context, laundrySnapShot) {
            if (!laundrySnapShot.hasData) {
              return Text('loading');
            } else {
              return ListView.builder(
                  itemCount: laundrySnapShot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot laundryData =
                        laundrySnapShot.data.docs[index];
                    int laundryCount = laundryData['item_count'];

                    return LaundryCard(
                        laundryData['item_price'],
                        laundryData['clothing_type'],
                        laundryData['clothing_image']);
                  });
            }
          }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 80),
        height: height / 5,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(30), bottom: Radius.circular(0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Container(
              height: height / 16,
              width: width / 1.5,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text('Checkout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LaundryCard extends StatefulWidget {
  final String imageURL;
  final String laundryItemType;
  final int laundryItemPrice;
  const LaundryCard(this.laundryItemPrice, this.laundryItemType, this.imageURL);



  @override
  _LaundryCardState createState() => _LaundryCardState();
}

class _LaundryCardState extends State<LaundryCard> {
  int _laundryCount = 0;
int minusLaundry=0;
  int addLaundry = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    void _navigateAndDisplayBookingScreen(BuildContext context) async {
      // Navigator.push returns a Future that completes after calling
      // Navigator.pop on the Selection Screen.

      final result = await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return BookingScreen();
          });

      // setState(() {
      //   answer = result;
      // });

    }

    return InkWell(
      onTap: (){
        _navigateAndDisplayBookingScreen(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: height / 6,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height / 8,
              width: width / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.imageURL),
                ),
              ),
            ),
            Container(
              height: height / 8,
              width: width / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.laundryItemType,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    widget.laundryItemPrice.toString(),
                  ),
                  Text(
                    'R$addLaundry',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _laundryCount != 0 ? Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blue),
                        child: IconButton(
                          iconSize: 10,
                          icon: Icon(Icons.horizontal_rule),
                          onPressed: () {
                            setState(() {

                              _laundryCount--;
                              minusLaundry = addLaundry -= widget.laundryItemPrice;
                              print(_laundryCount);
                            });
                          },
                        ),
                      )
                    : Container(),
                SizedBox(
                  width: 5,
                ),
                Text(_laundryCount.toString()),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue),
                  child: IconButton(
                    iconSize: 10,
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // int _laundryCount = laundryData['item_count'];
                      setState(() {
                        _laundryCount++;
                        addLaundry = _laundryCount * widget.laundryItemPrice;
                        print(_laundryCount);

                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class ListTileItem extends StatefulWidget {
//   String title;
//   ListTileItem({this.title});
//   @override
//   _ListTileItemState createState() => new _ListTileItemState();
// }
//
// class _ListTileItemState extends State<ListTileItem> {
//   int _itemCount = 0;
//   @override
//   Widget build(BuildContext context) {
//     return new ListTile(
//       title: new Text(widget.title),
//       trailing: new Row(
//         children: <Widget>[
//           _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
//           new Text(_itemCount.toString()),
//           new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
//         ],
//       ),
//     );
//   }
// }
