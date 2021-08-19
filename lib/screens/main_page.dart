
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splasha/screens/home_page.dart';
import 'package:splasha/screens/bookings_history_screen.dart';
import 'package:splasha/screens/favourites_page.dart';
import 'package:splasha/screens/profile_page.dart';



class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;



  int currentTabIndex = 0;

  List<Widget> pages;

  Widget currentPage;

  HomePage homepage;
  BookingHistoryScreen ordersPage;
  FavouritesPage favouritesPage;
  ProfilePage profilePage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homepage = HomePage();
    ordersPage=BookingHistoryScreen();
    favouritesPage= FavouritesPage();
    profilePage= ProfilePage(_firebaseAuth.currentUser.uid);


    pages=[homepage,ordersPage,favouritesPage,profilePage];
    currentPage= homepage;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index){
          setState(() {
            currentTabIndex=index;
            currentPage = pages[index];
          });
        },
        items:<BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label:'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: currentPage,
    );
  }
}