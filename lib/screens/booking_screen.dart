import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splasha/models/category_info.dart';
import 'package:splasha/models/event_model.dart';
import 'package:splasha/services/event_firestore_service.dart';
import 'package:splasha/widgets/booking_pill_widget.dart';

import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';
import 'checkout_screen.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  final vehMakeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) {
      DateTime date =
          DateTime(event.date.year, event.date.month, event.date.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  String vehicleMake;
  String vehicleModel;
  String vehicleReg;

  String vehicleMakeHint = 'Vehicle Make (e.g.VW)';
  String vehicleModelHint = 'Vehicle Model(e.g.Polo 1.4)';
  String vehicleRegHint = 'Vehicle Registration (AB12CD GP)';

  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> formData = {
    'vehicleMake': null,
    'vehicleModel': null,
    'vehicleReg': null
  };

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        height: height / 1.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.more_horiz,size: 40,),
              Container(
                width: width / 1.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Vehicle Details',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter vehicle make';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      onSaved: (String value) {
                        formData['vehicleMake'] = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: vehicleMakeHint),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter vehicle model';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      onSaved: (String value) {
                        formData['vehicleModel'] = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: vehicleModelHint),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter vehicle registration';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      onSaved: (String value) {
                        formData['vehicleReg'] = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: vehicleRegHint),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<EventModel>>(
                  stream: eventDBS.streamList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<EventModel> allEvents = snapshot.data;
                      if (allEvents.isNotEmpty) {
                        _events = _groupEvents(allEvents);
                      } else {
                        _events = {};
                        _selectedEvents = [];
                      }
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TableCalendar(
                            events: _events,
                            initialCalendarFormat: CalendarFormat.week,
                            calendarStyle: CalendarStyle(
                                canEventMarkersOverflow: true,
                                todayColor: Colors.orange,
                                selectedColor: Theme.of(context).primaryColor,
                                todayStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.white)),
                            headerStyle: HeaderStyle(
                              centerHeaderTitle: true,
                              formatButtonDecoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              formatButtonTextStyle:
                                  TextStyle(color: Colors.white),
                              formatButtonShowsNext: false,
                            ),
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            onDaySelected: (date, events, _) {
                              setState(() {
                                _selectedEvents = events;
                              });
                            },
                            builders: CalendarBuilders(
                              selectedDayBuilder: (context, date, events) =>
                                  Container(
                                      margin: const EdgeInsets.all(4.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(
                                        date.day.toString(),
                                        style: TextStyle(color: Colors.white),
                                      )),
                              todayDayBuilder: (context, date, events) =>
                                  Container(
                                      margin: const EdgeInsets.all(4.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(
                                        date.day.toString(),
                                        style: TextStyle(color: Colors.white),
                                      )),
                            ),
                            calendarController: _controller,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 8,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.all(8),
                              itemCount: _selectedEvents.length,
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                final EventModel slots =
                                    _selectedEvents[index];
                                Color pillColor = Colors.blue;

                                return BookingPillWidget(
                                  slots: slots,
                                  color: pillColor,
                                  width: width,
                                  selectedVehicleMake: vehicleMake,
                                  selectedVehicleModel: vehicleModel,
                                  selectedVehicleReg: vehicleReg,
                                  formKey: _formKey,
                                  formData: formData,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                width: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedDate extends ChangeNotifier {
  String selectedDate = '';

  void changeString(String newString) {
    selectedDate = newString;
    notifyListeners();
  }
}

class SelectedTime extends ChangeNotifier {
  String selectedTime = '';

  void changeString(String newString) {
    selectedTime = newString;
    notifyListeners();
  }
}

class SelectedVehicleMake extends ChangeNotifier {
  String selectedVehicleMake = '';

  void changeString(String newString) {
    selectedVehicleMake = newString;
    notifyListeners();
  }
}

class SelectedVehicleModel extends ChangeNotifier {
  String selectedVehicleModel = '';

  void changeString(String newString) {
    selectedVehicleModel = newString;
    notifyListeners();
  }
}

class SelectedVehicleReg extends ChangeNotifier {
  String selectedVehicleReg = '';

  void changeString(String newString) {
    selectedVehicleReg = newString;
    notifyListeners();
  }
}
