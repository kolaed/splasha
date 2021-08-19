import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel {
  final String id;

  final DateTime date;

  EventModel({this.id,this.date});

  factory EventModel.fromMap(Map data) {
    return EventModel(
      date: data['date'],
    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    return EventModel(
      id: id,
      date: data['date'].toDate(),
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "id":id,
      "date":date,
    };
  }
}