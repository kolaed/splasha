import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:splasha/models/category_info.dart';
import 'package:provider/provider.dart';
import 'package:splasha/screens/address_look_up.dart';
import 'package:splasha/screens/addresses_screen.dart';
import 'package:splasha/screens/bookings_history_screen.dart';
import 'package:splasha/screens/favourites_page.dart';
import 'package:splasha/services/paystack_service.dart';
import 'package:splasha/utils/hexToColor.dart';
import 'package:splasha/widgets/addresses_Stream.dart';
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







  String answer;

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    String price = Provider.of<SelectedPrice>(context).selectedPrice;

    void _navigateAndDisplayAddresses(BuildContext context) async {
      // Navigator.push returns a Future that completes after calling
      // Navigator.pop on the Selection Screen.

      final result = await showModalBottomSheet(
          context: context,
          builder: (context) {
            return AddressesStream(
                firebaseAuth: _firebaseAuth, height: height, width: width);
          });

      setState(() {
        answer = result;
      });

    }

    return Scaffold(
      bottomSheet:     Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: width,
        height: height / 8,
        color: Colors.white,
        child: Container(
          color: Colors.blue,
          child: Center(
            child: InkWell(
              onTap: () {
               chargeCard(int.parse(price));
              },
              child: Text('CHECKOUT R${price.substring(0, 3)}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              child: Icon(
            Icons.close,
            color: Colors.black,
            size: 30,
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: height ,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${Provider.of<SelectedWashType>(context).selectedWashType} ${Provider.of<SelectedVehicleType>(context).selectedVehicleType}',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                title: Text(
                    answer == null ? 'ADD ADDRESS' : answer.toUpperCase()),
                trailing: InkWell(
                    onTap: () {
                      _navigateAndDisplayAddresses(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    )),
              ),
              Center(
                child: SizedBox(
                  height: 20,
                  width: width / 2,
                  child: Divider(
                    color: Colors.blueGrey.shade200,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Booking date:',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(Provider.of<SelectedDate>(context).selectedDate.substring(0, 10))
                ],
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Booking time:',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(Provider.of<SelectedTime>(context).selectedTime.substring(10, 16))
                ],
              ),
              Center(
                child: SizedBox(
                  height: 20,
                  width: width / 2,
                  child: Divider(
                    color: Colors.blueGrey.shade200,
                  ),
                ),
              ),
              Text(
                'Vehicle Details',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                'Make: ${Provider.of<SelectedVehicleMake>(context).selectedVehicleMake.toUpperCase() }',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Model: ${Provider.of<SelectedVehicleModel>(context).selectedVehicleModel.toUpperCase() }',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Registration: ${Provider.of<SelectedVehicleReg>(context).selectedVehicleReg.toUpperCase() }',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),
              ),
              Center(
                child: SizedBox(
                  height: 20,
                  width: width / 2,
                  child: Divider(
                    color: Colors.blueGrey.shade200,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'R$price'.substring(0, 4),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                ],
              ),
              SizedBox(
                height:height / 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
