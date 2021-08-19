import 'package:splasha/models/event_model.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>("booking_slots",fromDS: (id,data) => EventModel.fromDS(id, data), toMap:(event) => event.toMap());