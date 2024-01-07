import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splasha/models/booking_times.dart';
import 'package:splasha/models/my_user.dart';
import 'package:splasha/models/bookings.dart';

class DatabaseService {
  final String uid;

  final CollectionReference bookingTimesCollection =
      FirebaseFirestore.instance.collection('booking_schedule');

  final CollectionReference myUserCollection =
      FirebaseFirestore.instance.collection('myUser');

  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('bookings');

  final CollectionReference addressesCollection =
      FirebaseFirestore.instance.collection('addresses');

  final CollectionReference carWash =
      FirebaseFirestore.instance.collection('car_wash');
  final CollectionReference services =
  FirebaseFirestore.instance.collection('services');

  final CollectionReference addresses =
  FirebaseFirestore.instance.collection('addresses');

  final CollectionReference laundry =
  FirebaseFirestore.instance.collection('laundry');

  DatabaseService({this.uid});

  Future updateMyUserData(
      String uid, String name, String contactNumber, String email) async {
    return await myUserCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'contactNumber': contactNumber,
      'email': email,
    });
  }

  List<MyUser> _myUserListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MyUser(
        uid: uid,
        name: doc['name'] ?? 'No User',
        contactNumber: doc['contactNumber'] ?? 0,
        email: doc['email'] ?? '',
      );
    }).toList();
  }

  Stream<List<MyUser>> get myUser {
    return myUserCollection.snapshots().map(_myUserListFromSnapshot);
  }

  void getUsersInfo() async {
    final usersInfo = await myUserCollection.doc(uid).get();
    print(usersInfo.data());
  }

  Future addUserBookingData(String washType, String carType, String bookingDate,
      String bookingTime, String bookingAddress, String uid) async {
    return await bookingsCollection.doc(uid).collection('user_bookings').add({
      'washType': washType,
      'carType': carType,
      'booking date': bookingDate,
      'bookingTime': bookingTime,
      'bookingAddress': bookingAddress,
      'uid': uid
    });
  }

  Future addUserAddress(
      String aptNumber,
      String complexName,
      String streetNumber,
      String street,
      String city,
      String zipCode,
      String uid) async {
    return await addressesCollection.doc(uid).collection('user_addresses').add({
      'aptNumber': aptNumber,
      'complexNamde': complexName,
      'streetNumber': streetNumber,
      'street': street,
      'city': city,
      'zipCode': zipCode,
      'uid': uid
    });
  }

  List<Bookings> _myBookingsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Bookings(
        washType: doc['washType'] ?? '',
        carType: doc['carType'] ?? '',
        bookingDate: doc['bookingDate'] ?? '',
        bookingTime: doc['bookingTime'] ?? '',
        bookingAddress: doc['bookingAddress'] ?? '',
      );
    }).toList();
  }

  Stream<List<Bookings>> get booking {
    return myUserCollection.snapshots().map(_myBookingsListFromSnapshot);
  }

  Future addBookingTime(
    DateTime date,
    String time,
  ) async {
    return await bookingTimesCollection.add({
      'date': date,
      'time': time,
    });
  }

  List<BookingTimes> _bookingTimesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BookingTimes(
        doc['date'],
        doc['time'],
      );
    }).toList();
  }

  Stream<List<BookingTimes>> get times {
    return bookingTimesCollection.snapshots().map(_bookingTimesFromSnapshot);
  }
}
