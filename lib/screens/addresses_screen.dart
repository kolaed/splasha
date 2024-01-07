import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';
import 'package:splasha/services/database.dart';
import 'package:splasha/widgets/addresses_Stream.dart';
import '../constants.dart';


class AddressesScreen extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return AddressesStream(firebaseAuth: _firebaseAuth, height: height, width: width);
  }
}




class SelectedAptNo extends ChangeNotifier {
  String selectedAptNo = '';

  void changeString(String newString) {
    selectedAptNo = newString;
    notifyListeners();
  }
}

