import 'package:flutter/material.dart';

import 'package:splasha/models/zip_codes.dart';
import 'package:splasha/screens/address_capture.dart';

import 'package:splasha/screens/sorry_screen.dart';

import 'address_search.dart';
import 'package:uuid/uuid.dart';
import 'package:splasha/services/places_services.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:splasha/widgets/rounded_button.dart';

import 'home_page.dart';
import 'main_page.dart';

class AddressLookUPScreen extends StatefulWidget {
  @override
  _AddressLookUPScreenState createState() => _AddressLookUPScreenState();
}

class _AddressLookUPScreenState extends State<AddressLookUPScreen> {
  bool showSpinner = false;

  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';

  FirebaseFirestore irestore = FirebaseFirestore.instance;

  int countOccurrencesUsingLoop(zipCodes, _zipCode) {
    List<String> zips = [];
    int count = 0;
    for (int i = 0; i < zipCodes.length; i++) {
      if (zipCodes[i] == _zipCode) {
        count++;
      }
    }
    return count;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height / 2,
                ),
                Container(
                  width: width / 1.2,
                  child: TextField(
                    controller: _controller,
                    readOnly: true,
                    onTap: () async {
                      final sessionToken = Uuid().v4();
                      final Suggestion result = await showSearch(
                        context: context,
                        delegate: AddressSearch(sessionToken),
                      );
                      // This will change the text displayed in the TextField
                      if (result != null) {
                        final placeDetails =
                            await PlaceApiProvider(sessionToken)
                                .getPlaceDetailFromId(result.placeId);
                        setState(() {
                          _controller.text = result.description;
                          _streetNumber = placeDetails.streetNumber;
                          _street = placeDetails.street;
                          _city = placeDetails.city;
                          _zipCode = placeDetails.zipCode;
                        });
                      }
                    },
                    // with some styling
                    decoration: InputDecoration(

                      hintText: "Enter your address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                RoundedButton(
                  title: ''
                      'NEXT',
                  colour: Colors.blue,
                  onPressed: () {
                    if (countOccurrencesUsingLoop(zipCodes, _zipCode) != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressCapture(),
                        ),
                      );
                      Provider.of<SelectedAddress>(context, listen: false)
                          .changeString(_controller.text);
                      Provider.of<SelectedStreetNumber>(context, listen: false)
                          .changeString(_streetNumber);
                      Provider.of<SelectedStreet>(context, listen: false)
                          .changeString(_street);
                      Provider.of<SelectedCity>(context, listen: false)
                          .changeString(_city);
                      Provider.of<SelectedZipCode>(context, listen: false)
                          .changeString(_zipCode);
                    } else
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SorryScreen(),
                        ),
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedAddress extends ChangeNotifier {
  String selectedAddress = '';

  void changeString(String newString) {
    selectedAddress = newString;
    notifyListeners();
  }
}

class SelectedStreetNumber extends ChangeNotifier {
  String selectedStreetNumber = '';

  void changeString(String newString) {
    selectedStreetNumber = newString;
    notifyListeners();
  }
}

class SelectedStreet extends ChangeNotifier {
  String selectedStreet = '';

  void changeString(String newString) {
    selectedStreet = newString;
    notifyListeners();
  }
}

class SelectedCity extends ChangeNotifier {
  String selectedCity = '';

  void changeString(String newString) {
    selectedCity = newString;
    notifyListeners();
  }
}

class SelectedZipCode extends ChangeNotifier {
  String selectedZipCode = '';

  void changeString(String newString) {
    selectedZipCode = newString;
    notifyListeners();
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SorryScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
