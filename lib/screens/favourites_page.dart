import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:splasha/services/database.dart';

import 'booking_screen.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService(uid: '').carWash.snapshots(),
        builder: (context, carWashSnapshot) {
          if (!carWashSnapshot.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.menu),
                ),
                actions: [
                  IconButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              body: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: carWashSnapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot carWashData =
                      carWashSnapshot.data.docs[index];

                  return Column(
                    children: [
                      Container(
                        height: height/2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [
                            Text(
                              carWashData['washType'].toString().toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(carWashData['specifications']),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,

                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ]
                              ),
                              height: height/8,
                              width: width,
                              child:
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingScreen()),
                                      );
                                      Provider.of<SelectedWashType>(context,
                                          listen: false)
                                          .changeString(carWashData['washType']);
                                      Provider.of<SelectedVehicleType>(context,
                                          listen: false)
                                          .changeString(carWashData['vehicleSedan']);
                                      Provider.of<SelectedPrice>(context, listen: false)
                                          .changeString(
                                          carWashData['priceSedan'].toString());
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                      children: [
                                        Text(carWashData['vehicleSedan'],style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                        ),),
                                        Text(
                                            'R${carWashData['priceSedan'].toString().substring(0, 3)}'),

                                      ],
                                    ),
                                  ),),
                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ]
                                    ),
                                    height: height/8,
                                    width: width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => BookingScreen()),
                                            );
                                            Provider.of<SelectedWashType>(context,
                                                listen: false)
                                                .changeString(carWashData['washType']);
                                            Provider.of<SelectedVehicleType>(context,
                                                listen: false)
                                                .changeString(carWashData['vehicleSUV']);
                                            Provider.of<SelectedPrice>(context, listen: false)
                                                .changeString(
                                                carWashData['priceSUV'].toString());
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(carWashData['vehicleSUV'],style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                              ),),
                                              Text(
                                                  'R${carWashData['priceSUV'].toString().substring(0, 3)}'),
                                            ],
                                          ),
                                        ),
                                        Container(

                                            width: 70,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(carWashData['image'])
                                              ),

                                            ),
                                           ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),


                    ],
                  );
                },
              ),
            );
          }
        });
  }
}

class SelectedWashType extends ChangeNotifier {
  String selectedWashType = '';

  void changeString(String newString) {
    selectedWashType = newString;
    notifyListeners();
  }
}

class SelectedVehicleType extends ChangeNotifier {
  String selectedVehicleType = '';

  void changeString(String newString) {
    selectedVehicleType = newString;
    notifyListeners();
  }
}

class SelectedPrice extends ChangeNotifier {
  String selectedPrice = '';

  void changeString(String newString) {
    selectedPrice = newString;
    notifyListeners();
  }
}

// import 'dart:collection';
// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'package:splasha/utils/utils.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:splasha/utils/calendar_utils.dart';
//
// class FavouritesPage extends StatefulWidget {
//   @override
//   _FavouritesPageState createState() => _FavouritesPageState();
// }
//
// class _FavouritesPageState extends State<FavouritesPage> {
//   ValueNotifier<List<Event>> _selectedEvents;
//   CalendarFormat _calendarFormat = CalendarFormat.week;
//   RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
//       .toggledOff; // Can be toggled on/off by longpressing a date
//   DateTime _focusedDay = DateTime.now();
//   DateTime _selectedDay;
//   DateTime _rangeStart;
//   DateTime _rangeEnd;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
//   }
//
//   @override
//   void dispose() {
//     _selectedEvents.dispose();
//     super.dispose();
//   }
//
//   List<Event> _getEventsForDay(DateTime day) {
//     // Implementation example
//     return kEvents[day] ?? [];
//   }
//
//   List<Event> _getEventsForRange(DateTime start, DateTime end) {
//     // Implementation example
//     final days = daysInRange(start, end);
//
//     return [
//       for (final d in days) ..._getEventsForDay(d),
//     ];
//   }
//
//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDay)) {
//       setState(() {
//         _selectedDay = selectedDay;
//         _focusedDay = focusedDay;
//         _rangeStart = null; // Important to clean those
//         _rangeEnd = null;
//         _rangeSelectionMode = RangeSelectionMode.toggledOff;
//       });
//
//       _selectedEvents.value = _getEventsForDay(selectedDay);
//     }
//   }
//
//   void _onRangeSelected(DateTime start, DateTime end, DateTime focusedDay) {
//     setState(() {
//       _selectedDay = null;
//       _focusedDay = focusedDay;
//       _rangeStart = start;
//       _rangeEnd = end;
//       _rangeSelectionMode = RangeSelectionMode.toggledOn;
//     });
//
//     // `start` or `end` could be null
//     if (start != null && end != null) {
//       _selectedEvents.value = _getEventsForRange(start, end);
//     } else if (start != null) {
//       _selectedEvents.value = _getEventsForDay(start);
//     } else if (end != null) {
//       _selectedEvents.value = _getEventsForDay(end);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TableCalendar - Events'),
//       ),
//       body: Column(
//         children: [
//           TableCalendar<Event>(
//             firstDay: kFirstDay,
//             lastDay: kLastDay,
//             focusedDay: _focusedDay,
//             selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//             rangeStartDay: _rangeStart,
//             rangeEndDay: _rangeEnd,
//             calendarFormat: _calendarFormat,
//             rangeSelectionMode: _rangeSelectionMode,
//             eventLoader: _getEventsForDay,
//             startingDayOfWeek: StartingDayOfWeek.monday,
//             calendarStyle: CalendarStyle(
//               // Use `CalendarStyle` to customize the UI
//               outsideDaysVisible: false,
//             ),
//             onDaySelected: _onDaySelected,
//             onRangeSelected: _onRangeSelected,
//             onFormatChanged: (format) {
//               if (_calendarFormat != format) {
//                 setState(() {
//                   _calendarFormat = format;
//                 });
//               }
//             },
//             onPageChanged: (focusedDay) {
//               _focusedDay = focusedDay;
//             },
//           ),
//           const SizedBox(height: 8.0),
//           Expanded(
//             child: ValueListenableBuilder<List<Event>>(
//               valueListenable: _selectedEvents,
//               builder: (context, value, _) {
//                 return ListView.builder(
//                   itemCount: value.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 12.0,
//                         vertical: 4.0,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       child: ListTile(
//                         onTap: () => print('${value[index]}'),
//                         title: Text('${value[index]}'),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
