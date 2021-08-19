import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:splasha/models/category_info.dart';
import 'package:provider/provider.dart';
import 'package:splasha/screens/address_look_up.dart';
import 'package:splasha/screens/bookings_history_screen.dart';
import 'package:splasha/screens/favourites_page.dart';
import 'package:splasha/utils/hexToColor.dart';
import 'dart:io';
import 'booking_screen.dart';
import 'package:splasha/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final plugin = PaystackPlugin();

  String publicKey = "pk_test_b1b3a99260ebaecfc29c652d0982afa6e9bfdd4f";

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    super.initState();
  }

  Dialog successDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_box,
                color: hexToColor("#41aa5e"),
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Payment has successfully',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'been made',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Your payment has been successfully",
                style: TextStyle(fontSize: 13),
              ),
              Text("processed.", style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return successDialog(context);
      },
    );
  }

  Dialog errorDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Failed to process payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Error in processing payment, please try again",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errorDialog(context);
      },
    );
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  chargeCard(int amount) async {
    Charge charge = Charge()
      ..amount = amount
      ..currency = 'ZAR'
      ..reference = _getReference()
      // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = 'thbkola@gmail.com';
    CheckoutResponse response = await plugin.checkout(context,
        method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
        charge: charge,
        fullscreen: false);
    if (response.status == true) {
      setState(() {
        User user = _firebaseAuth.currentUser;
        final CategoryInfo categoryInfo =
            ModalRoute.of(context).settings.arguments;
        DatabaseService(uid: user.uid).addUserBookingData(

            Provider.of<SelectedWashType>(context, listen: false)
                .selectedWashType,
            Provider.of<SelectedVehicleType>(context, listen: false)
                .selectedVehicleType,
            Provider.of<SelectedDate>(context, listen: false)
                .selectedDate
                .substring(0, 10),
            Provider.of<SelectedTime>(context, listen: false)
                .selectedTime
                .substring(10, 16),
            Provider.of<SelectedCity>(context, listen: false).selectedCity,
            user.uid);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingHistoryScreen()),
        );
      });
      _showDialog();
    } else {
      _showErrorDialog();
    }
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final CategoryInfo categoryInfo = ModalRoute.of(context).settings.arguments;

    String price = Provider.of<SelectedPrice>(context).selectedPrice;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(color: Colors.red, child: Icon(Icons.arrow_back)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height / 4,
            ),
            Container(
              width: double.infinity,
              height: height / 2,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Provider.of<SelectedWashType>(context).selectedWashType,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Provider.of<SelectedVehicleType>(context)
                            .selectedVehicleType,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Provider.of<SelectedDate>(context)
                            .selectedDate
                            .substring(0, 10),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Provider.of<SelectedTime>(context)
                            .selectedTime
                            .substring(10, 16),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'TOTAL',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'R$price'.substring(0,4),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    'R$price'.substring(0,4),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: width,
              height: height / 8,
              color: Colors.white,
              child: Center(
                child: InkWell(
                  onTap: () {
                    chargeCard(int.parse(price));
                  },
                  child: Text('CheckOut'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
