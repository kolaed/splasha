import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splasha/screens/address_look_up.dart';
import 'package:splasha/screens/main_page.dart';
import 'package:splasha/services/database.dart';
import 'package:splasha/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:splasha/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressCapture extends StatefulWidget {
  @override
  _AddressCaptureState createState() => _AddressCaptureState();
}

class _AddressCaptureState extends State<AddressCapture> {
  bool showSpinner = false;

 String complexName;

  String apartmentNum;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
              ),
              Positioned(
                child: Container(
                  height: height / 2,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: height / 6,
                left: 20,
                right: 20,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          apartmentNum = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Apt number'),
                      ),
                      SizedBox(
                        height: height / 32,
                      ),
                      TextField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          complexName = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'complex name'),
                      ),
                      SizedBox(
                        height: height / 32,
                      ),
                      InfoField(
                        info2: Provider.of<SelectedStreetNumber>(context)
                            .selectedStreetNumber,
                        info:
                            Provider.of<SelectedStreet>(context).selectedStreet,
                      ),
                      SizedBox(
                        height: height / 32,
                      ),
                      InfoField(
                        info2: '',
                        info: Provider.of<SelectedCity>(context).selectedCity,
                      ),
                      SizedBox(
                        height: height / 32,
                      ),
                      InfoField(
                        info2: '',
                        info: Provider.of<SelectedZipCode>(context)
                            .selectedZipCode,
                      ),
                      SizedBox(
                        height: height / 32,
                      ),
                      RoundedButton(
                        title: 'NEXT',
                        colour: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ),
                          );

                          User user = _firebaseAuth.currentUser;
                          DatabaseService(uid: user.uid).addUserAddress(
                            apartmentNum,complexName,
                              Provider.of<SelectedStreetNumber>(context,listen: false)
                                  .selectedStreetNumber,
                              Provider.of<SelectedStreet>(context,listen: false)
                                  .selectedStreet,
                              Provider.of<SelectedCity>(context,listen: false).selectedCity,
                              Provider.of<SelectedZipCode>(context,listen: false)
                                  .selectedZipCode,
                              user.uid);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoField extends StatelessWidget {
  String info = '';
  String info2 = '';

  InfoField({ this.info, this.info2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(info2, style: TextStyle(color: Colors.black)),
              SizedBox(
                width: 10,
              ),
              Text(
                info,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
